part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class GetDriverOrdersLoadingState extends OrdersState {}

final class GetDriverOrdersSuccessState extends OrdersState {
  final List<DriverOrder> orders;
  GetDriverOrdersSuccessState({required this.orders});
}

final class GetDriverOrdersErrorState extends OrdersState {
  final String message;
  GetDriverOrdersErrorState({required this.message});
}

final class GetSpecificProductLoadingState extends OrdersState {}

final class GetSpecificProductSuccessState extends OrdersState {
  final Product product;
  GetSpecificProductSuccessState({required this.product});
}

final class GetSpecificProductErrorState extends OrdersState {
  final String message;
  GetSpecificProductErrorState({required this.message});
}