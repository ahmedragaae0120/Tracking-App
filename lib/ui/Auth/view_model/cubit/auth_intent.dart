import 'package:tracking_app/domain/entity/auth/apply_request.dart';

sealed class AuthIntent {}
class applyIntent extends AuthIntent{
  applyrequest request;
  applyIntent({required this.request});

}
class getVehiclesIntent extends AuthIntent{}