part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetPendingOrdersLoadingState extends HomeState {}

final class GetPendingOrdersSuccessState extends HomeState {
  final List<Orders> orders;
  GetPendingOrdersSuccessState({required this.orders});
}

final class GetPendingOrdersErrorState extends HomeState {
  final String message;
  GetPendingOrdersErrorState({required this.message});
}

final class StartOrderLoadingState extends HomeState {}

final class StartOrderSuccessState extends HomeState {
  final String orderId;
  StartOrderSuccessState({required this.orderId});
}

final class StartOrderErrorState extends HomeState {
  final String message;
  StartOrderErrorState({required this.message});
}

final class SearchOrdersSuccessState extends HomeState {
  final List<Orders> orders;
  SearchOrdersSuccessState({required this.orders});
}

final class RejectOrderSuccessState extends HomeState {
  final List<Orders> orders;
  RejectOrderSuccessState({required this.orders});
}

final class LoadMoreOrdersLoadingState extends HomeState {}

final class LoadMoreOrdersSuccessState extends HomeState {}

final class LoadMoreOrdersErrorState extends HomeState {
  final String message;
  LoadMoreOrdersErrorState({required this.message});
}
