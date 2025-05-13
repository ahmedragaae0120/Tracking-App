class EndPoint {
  static const String signInEndpoint = "/v1/drivers/signin";
  static const String forgetPasswordEndpoints = "/v1/drivers/forgotPassword";
  static const String verifyEndpoint = "/v1/drivers/verifyResetCode";
  static const String resetPasswordEndpoint = "/v1/drivers/resetPassword";
  static const String apply= "/v1/drivers/apply";
  static const String getallvehicle='/v1/vehicles';
  static const String logoutEndpoint='/v1/drivers/logout';
  static const String getLoggedInDriver='/v1/drivers/profile-data';
  static  String updateOrderState(String id)=>"/v1/orders/state/$id";
}
