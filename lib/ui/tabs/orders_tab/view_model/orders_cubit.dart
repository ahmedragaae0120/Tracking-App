
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/domain/use_cases/get_driver_orders_usecase.dart';
import 'package:tracking_app/domain/use_cases/get_specific_product_usecase.dart';
import 'package:tracking_app/ui/tabs/orders_tab/view_model/orders_intent.dart';

import '../../../../core/api/api_result.dart';
import '../../../../data/model/orders/driver_order.dart';
import '../../../../data/model/orders/product.dart';

part 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  @factoryMethod
  final GetDriverOrdersUsecase getDriverOrdersUsecase;
  final GetSpecificProductUsecase getSpecificProductUsecase;

  OrdersCubit(this.getDriverOrdersUsecase,this.getSpecificProductUsecase) : super(OrdersInitial());

  Future<void> _getDriverOrders() async {
    emit(GetDriverOrdersLoadingState());
    final result = await getDriverOrdersUsecase.invoke();

    switch (result) {
      case SuccessApiResult():
        emit(GetDriverOrdersSuccessState(orders: result.data ?? []));
      case ErrorApiResult():
        emit(GetDriverOrdersErrorState(message: result.exception.toString()));
    }
  }

  Future<void> _getSpecificProduct(String productId) async {
    emit(GetSpecificProductLoadingState());

    final result = await getSpecificProductUsecase.invoke(productId);

    switch (result) {
      case SuccessApiResult():
        emit(GetSpecificProductSuccessState(product: result.data!));
      case ErrorApiResult():
        emit(GetSpecificProductErrorState(message: result.exception.toString()));
    }
  }


  void doIntent(OrdersIntent intent) {
    switch (intent) {
      case GetDriverOrdersIntent():
        _getDriverOrders();
        break;
      case GetSpecificProductIntent():
        _getSpecificProduct(intent.productId);
        break;
    }
  }
}
