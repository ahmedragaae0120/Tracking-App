// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/cache/shared_pref.dart';
import 'package:tracking_app/data/model/orders/orders.dart';
import 'package:tracking_app/domain/use_cases/get_pending_orders_usecase.dart';
import 'package:tracking_app/domain/use_cases/start_order_usecase.dart';
import 'package:tracking_app/ui/tabs/home_tab/view_model/home_intent.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
      this.getPendingOrdersUseCase, this.startOrderUseCase, this.cacheHelper)
      : super(HomeInitial());

  final GetPendingOrdersUseCase getPendingOrdersUseCase;
  final StartOrderUseCase startOrderUseCase;
  final CacheHelper cacheHelper;

  List<Orders> allOrders = [];
  List<Orders> filteredOrders = [];

  int _currentPage = 1;
  bool _hasMoreData = true;

  doIntent(HomeIntent intent) {
    switch (intent) {
      case GetPendingOrdersIntent():
        _currentPage = 1; // Reset page when getting fresh data
        _hasMoreData = true;
        _getPendingOrders();
        break;
      case StartOrderIntent():
        _startOrder(intent);
        break;
      case SearchOrdersIntent():
        _searchOrders(intent);
        break;
      case RejectOrderIntent():
        _rejectOrder(intent);
        break;
      case LoadMoreOrdersIntent():
        if (_hasMoreData) {
          _currentPage++;
          _loadMoreOrders();
        }
        break;
    }
  }

  _getPendingOrders() async {
    emit(GetPendingOrdersLoadingState());
    final result = await getPendingOrdersUseCase.invoke();

    switch (result) {
      case SuccessApiResult():
        allOrders = result.data ?? [];
        filteredOrders = allOrders;
        emit(GetPendingOrdersSuccessState(orders: filteredOrders));
        break;
      case ErrorApiResult():
        emit(GetPendingOrdersErrorState(message: result.exception.toString()));
        break;
    }
  }

  _loadMoreOrders() async {
    if (!_hasMoreData) return;

    emit(GetPendingOrdersLoadingState());

    final result = await getPendingOrdersUseCase.invoke(page: _currentPage);

    switch (result) {
      case SuccessApiResult():
        final newOrders = result.data ?? [];
        if (newOrders.isEmpty) {
          _hasMoreData = false;
        } else {
          allOrders.addAll(newOrders);
          filteredOrders = List.from(allOrders);
        }
        emit(GetPendingOrdersSuccessState(orders: filteredOrders));
        break;
      case ErrorApiResult():
        emit(GetPendingOrdersErrorState(message: result.exception.toString()));
        break;
    }
  }

  _startOrder(StartOrderIntent intent) async {
    emit(StartOrderLoadingState());
    final result = await startOrderUseCase.invoke(intent.orderId);

    switch (result) {
      case SuccessApiResult():
        // Save the current order ID to shared preferences
        await cacheHelper.setData('current_order_id', intent.orderId);
        emit(StartOrderSuccessState(orderId: intent.orderId));
        break;
      case ErrorApiResult():
        emit(StartOrderErrorState(message: result.exception.toString()));
        break;
    }
  }

  _searchOrders(SearchOrdersIntent intent) async {
    if (intent.query.isEmpty) {
      filteredOrders = allOrders;
      emit(SearchOrdersSuccessState(orders: filteredOrders));
      return;
    }

    List<Orders> localResults = allOrders.where((order) {
      final orderId = order.id?.toLowerCase() ?? '';
      final orderNumber = order.orderNumber?.toLowerCase() ?? '';
      final customerName =
          '${order.user?.firstName} ${order.user?.lastName}'.toLowerCase();
      final query = intent.query.toLowerCase();

      return orderId.contains(query) ||
          orderNumber.contains(query) ||
          customerName.contains(query);
    }).toList();

    if (localResults.isNotEmpty) {
      filteredOrders = localResults;
      emit(SearchOrdersSuccessState(orders: filteredOrders));
      return;
    }

    if (intent.query.length >= 5) {
      emit(GetPendingOrdersLoadingState());

      int page = 1;
      bool hasMorePages = true;
      int totalPages = 9;
      List<Orders> searchResults = [];

      while (hasMorePages && page <= totalPages) {
        final result = await getPendingOrdersUseCase.invoke(page: page);

        switch (result) {
          case SuccessApiResult():
            final pageOrders = result.data ?? [];

            if (pageOrders.isEmpty) {
              hasMorePages = false;
            } else {
              final matchingOrders = pageOrders.where((order) {
                final orderId = order.id?.toLowerCase() ?? '';
                final orderNumber = order.orderNumber?.toLowerCase() ?? '';
                final query = intent.query.toLowerCase();

                return orderId.contains(query) || orderNumber.contains(query);
              }).toList();

              if (matchingOrders.isNotEmpty) {
                searchResults.addAll(matchingOrders);
                // If we found an exact match, we can stop searching
                if (matchingOrders.any((order) =>
                    (order.id?.toLowerCase() ?? '') ==
                        intent.query.toLowerCase() ||
                    (order.orderNumber?.toLowerCase() ?? '') ==
                        intent.query.toLowerCase())) {
                  hasMorePages = false;
                }
              }

              page++;
            }
            break;
          case ErrorApiResult():
            emit(GetPendingOrdersErrorState(
                message: result.exception.toString()));
            return;
        }
      }

      // Update our local cache with the search results
      for (var order in searchResults) {
        if (!allOrders.any((existingOrder) => existingOrder.id == order.id)) {
          allOrders.add(order);
        }
      }

      filteredOrders = searchResults;
    } else {
      // For short queries that didn't match locally, just show empty results
      filteredOrders = [];
    }

    emit(SearchOrdersSuccessState(orders: filteredOrders));
  }

  _rejectOrder(RejectOrderIntent intent) {
    // Remove the order from the list
    allOrders.removeWhere((order) => order.id == intent.orderId);
    filteredOrders = allOrders;
    emit(RejectOrderSuccessState(orders: filteredOrders));
  }
}
