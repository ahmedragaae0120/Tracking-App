///  Auth Intent ///
// ignore_for_file: non_constant_identifier_names, dangling_library_doc_comments

sealed class AuthIntent {}

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

