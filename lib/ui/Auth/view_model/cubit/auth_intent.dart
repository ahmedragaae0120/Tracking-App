// ignore_for_file: camel_case_types

import 'package:tracking_app/domain/entity/auth/apply_request.dart';

///  Auth Intent ///
// ignore_for_file: non_constant_identifier_names, dangling_library_doc_comments

sealed class AuthIntent {}

class applyIntent extends AuthIntent {
  applyrequest request;

  applyIntent({required this.request});
}

class SignInIntent extends AuthIntent {
  final String email;
  final bool rememberMe;
  final String password;

  SignInIntent({
    required this.rememberMe,
    required this.email,
    required this.password,
  });
}

///  FORGOT PASSWORD INTENT ///
class ForgetPassword extends AuthIntent {
  final String email;

  ForgetPassword({required this.email});
}

///  VERIFY RESET CODE INTENT ///
class VerifyResetCode extends AuthIntent {
  final String resetCode;

  VerifyResetCode({required this.resetCode});
}

///  RESET PASSWORD INTENT ///
class ResetPassword extends AuthIntent {
  final String email;
  final String NewPassword;

  ResetPassword({required this.email, required this.NewPassword});
}

class getVehiclesIntent extends AuthIntent {}

class getLoginDriverDataIntent extends AuthIntent {}
