// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/use_cases/tracking/update_driver_Info_usecase.dart';
import 'package:tracking_app/domain/use_cases/tracking/update_order_status_usecase.dart';
import 'package:tracking_app/domain/use_cases/update_order_use_case.dart';
import 'package:tracking_app/ui/order_details_screen/view_model/cubit/oreder_datails_intent.dart';

part 'order_details_state.dart';

@injectable
class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit(this.updateOrderApiUseCase, this.updateDriverInfoUsecase,
      this.updateOrderStatusUsecase)
      : super(OrderDetailsInitial());
  final UpdateDriverInfoUsecase updateDriverInfoUsecase;
  final UpdateOrderStatusUsecase updateOrderStatusUsecase;
  final UpdateOrderUseCase updateOrderApiUseCase;

  doIntent(OrderDetailsIntent intent) {
    switch (intent) {
      case UpdateDriverInfoIntent():
        _updateDriverInfo(driverInfoIntent: intent);
        break;
      case UpdateOrderStatusIntent():
        _updateOrderStatus(orderStatusIntent: intent);
        break;
      case UpdateOrderStatusApiIntent():
        _updateOrderStatusApi(orderStatusApiIntent: intent);
        break;
    }
  }

  _updateOrderStatusApi({
    required UpdateOrderStatusApiIntent orderStatusApiIntent,
  }) async {
    emit(UpdateOrderStatusApiLoadingState());
    final result = await updateOrderApiUseCase.invoke(
      orderStatusApiIntent.orderId,
    );

    switch (result) {
      case SuccessApiResult():
        emit(UpdateOrderStatusApiSuccessState());
        break;
      case ErrorApiResult():
        emit(UpdateOrderStatusErrorState(result.exception.toString()));
        break;
    }
  }

  _updateDriverInfo({
    required UpdateDriverInfoIntent driverInfoIntent,
  }) async {
    final result = await updateDriverInfoUsecase(
        orderId: driverInfoIntent.orderId,
        name: driverInfoIntent.name,
        phone: driverInfoIntent.phone,
        driverId: driverInfoIntent.driverId,
        driverStatus: driverInfoIntent.driverStatus);

    switch (result) {
      case Success():
        emit(UpdateDriverInfoSuccessState());
        break;
      case Error():
        emit(UpdateDriverInfoErrorState(result.exception.toString()));
        break;
    }
  }

  _updateOrderStatus({
    required UpdateOrderStatusIntent orderStatusIntent,
  }) async {
    final result = await updateOrderStatusUsecase(
        orderId: orderStatusIntent.orderId,
        statusName: orderStatusIntent.statusName,
        isDone: orderStatusIntent.isDone);

    switch (result) {
      case Success():
        emit(UpdateOrderStatusSuccessState());
        break;
      case Error():
        emit(UpdateOrderStatusErrorState(result.exception.toString()));
        break;
    }
  }
}
