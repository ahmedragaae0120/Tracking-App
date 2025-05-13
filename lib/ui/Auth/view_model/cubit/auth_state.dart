// ignore_for_file: must_be_immutable

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

final class LoginSuccessState extends AuthState {
  UserModel? userModel;

  LoginSuccessState({required this.userModel});
}

final class LoginLoadingState extends AuthState {}

final class LoginErrorState extends AuthState {
  String? message;

  LoginErrorState({required this.message});
}

///  FORGOT PASSWORD STATES  ///

final class SendEmailVerificationSuccessState extends AuthState {
  bool isSent;

  SendEmailVerificationSuccessState({required this.isSent});
}

final class SendEmailVerificationLoadingState extends AuthState {
  SendEmailVerificationLoadingState();
}

final class SendEmailVerificationErrorState extends AuthState {
  String? message;

  SendEmailVerificationErrorState({required this.message});
}

///  VERIFY RESET CODE STATES  ///

final class VerifyResetCodeSuccessState extends AuthState {
  bool isVerified;

  VerifyResetCodeSuccessState({required this.isVerified});
}

final class VerifyResetCodeLoadingState extends AuthState {
  VerifyResetCodeLoadingState();
}

final class VerifyResetCodeErrorState extends AuthState {
  String? message;

  VerifyResetCodeErrorState({required this.message});
}

///  PASSWORD RESET STATES  ///

final class ResetPasswordSuccessState extends AuthState {
  bool isChanged;

  ResetPasswordSuccessState({required this.isChanged});
}

final class ResetPasswordLoadingState extends AuthState {
  ResetPasswordLoadingState();
}

final class ResetPasswordErrorState extends AuthState {
  String? message;

  ResetPasswordErrorState({required this.message});
}

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

final class GetLoggedInDriverDataSuccessState extends AuthState {
  GetLoggedInDriverDataSuccessState();
}

final class GetLoggedInDriverDataLoadingState extends AuthState {}

final class GetLoggedInDriverDataErrorState extends AuthState {
  String? message;

  GetLoggedInDriverDataErrorState({required this.message});
}



///  LOGOUT STATES  ///


class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {}

class LogoutFailureState extends AuthState {
  final String message;
  LogoutFailureState({required this.message});
}
