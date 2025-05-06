part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginSuccessState extends AuthState {
  UserModel? userModel;

  LoginSuccessState({required this.userModel});
}

final class LoginLoadingState extends AuthState {}

final class LoginErrorState extends AuthState {
  String? message;

  LoginErrorState({required this.message});
}
