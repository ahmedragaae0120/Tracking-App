part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
class applySuccess extends AuthState {
  final ApplyEntity applyEntity;
  applySuccess(this.applyEntity);
}
class applyFailure extends AuthState {
  String message;
  applyFailure({required this.message});
}
class applyLoading extends AuthState {}

class LoadContrySuccess extends AuthState {
   List countries;
  LoadContrySuccess(this.countries);
}
class LoadContryFailure extends AuthState {
  String message;
  LoadContryFailure({required this.message});
}
class getVehiclesSuccess extends AuthState {
   GetallvehicleEntity vehicles;
  getVehiclesSuccess(this.vehicles);
}
class getVehiclesFailure extends AuthState {
  String message;
  getVehiclesFailure({required this.message});
}