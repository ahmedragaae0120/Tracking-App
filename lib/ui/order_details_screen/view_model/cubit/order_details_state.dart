part of 'order_details_cubit.dart';

@immutable
sealed class OrderDetailsState {}

final class OrderDetailsInitial extends OrderDetailsState {}

final class UpdateDriverInfoLoadingState extends OrderDetailsState {}

final class UpdateDriverInfoSuccessState extends OrderDetailsState {}

final class UpdateDriverInfoErrorState extends OrderDetailsState {
  final String message;

  UpdateDriverInfoErrorState(this.message);
}

final class UpdateOrderStatusSuccessState extends OrderDetailsState {}

final class UpdateOrderStatusErrorState extends OrderDetailsState {
  final String message;

  UpdateOrderStatusErrorState(this.message);
}

final class UpdateOrderStatusLoadingState extends OrderDetailsState {}

final class UpdateOrderStatusApiSuccessState extends OrderDetailsState {}

final class UpdateOrderStatusApiErrorState extends OrderDetailsState {
  final String message;

  UpdateOrderStatusApiErrorState(this.message);
}

final class UpdateOrderStatusApiLoadingState extends OrderDetailsState {}
