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

  _searchOrders(SearchOrdersIntent intent) {
    if (intent.query.isEmpty) {
      filteredOrders = allOrders;
    } else {
      filteredOrders = allOrders.where((order) {
        // Search by order number, customer name, or any other relevant field
        final orderNumber = order.orderNumber?.toLowerCase() ?? '';
        final customerName =
            '${order.user?.firstName} ${order.user?.lastName}'.toLowerCase();
        final query = intent.query.toLowerCase();

        return orderNumber.contains(query) || customerName.contains(query);
      }).toList();
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
