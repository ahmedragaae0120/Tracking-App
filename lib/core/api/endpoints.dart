class EndPoint {
  static const String signInEndpoint = "/v1/drivers/signin";
  static const String forgetPasswordEndpoints = "/v1/drivers/forgotPassword";
  static const String verifyEndpoint = "/v1/drivers/verifyResetCode";
  static const String resetPasswordEndpoint = "/v1/drivers/resetPassword";
  static const String logoutEndpoint='/v1/drivers/logout';
  static const String getLoggedInDriver='/v1/drivers/profile-data';
  static  String updateOrderState(String id)=>"/v1/orders/state/$id";
  static const String editProfile = "/v1/drivers/editProfile";
  static const String uploadPhoto = "/v1/drivers/upload-photo";
  static const String changePasswordEndpoint = "/v1/drivers/change-password";
  static const String apply = "/v1/drivers/apply";
  static const String getallvehicle = '/v1/vehicles';
  static const String getPendingOrders = "/v1/orders/pending-orders";
  static String startOrder(String orderId) => "/v1/orders/start/$orderId";
  static const String getDriverOrders = "/v1/orders/driver-orders";
  static String getSpecificProduct(String productId) => "/v1/products/$productId";
}
