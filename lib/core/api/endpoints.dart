class EndPoint {
  static const String signInEndpoint = "/v1/auth/signin";
  static const String verifyEndpoint = "/v1/auth/verifyResetCode";
  static const String resetPasswordEndpoint = "/v1/auth/resetPassword";
  static const String forgetPasswordEndpoints = "/v1/auth/forgotPassword";
  static const String changePasswordEndpoint = "/v1/auth/change-password";
  static const String signUpEndpoint = "/v1/auth/signup";
  static const String occassionsEndpoint = "/v1/occasions";
  static const String getAllProductsEndpoint = "/v1/products";
  static const String apply= "/v1/drivers/apply";
  static const String getallvehicle='/v1/vehicles';
  static const String getAllNotificationsEndpoint = "/v1/notifications";

  static const String bestSellerEndpoint = "/v1/best-seller";
  static const String allCategoriesEndpoint = "/v1/categories";
  static const String homeEndpoint = "/v1/home";
  static const String cartEndpoint = "/v1/cart";

  static String deleteFromCartEndpoint(String productId) =>
      "/v1/cart/$productId";

  static String updateProductQuantityEndpoint(String productId) =>
      "/v1/cart/$productId";
  static const String logoutEndpoint = "/v1/auth/logout";
  static const String mainProfile = "/v1/auth/profile-data";
  static const String editProfile = "/v1/auth/editProfile";
  static const String uploadPhoto = "/v1/auth/upload-photo";
  static const String cashPaymentEndpoint = "/v1/orders";
  static const String creditCardPaymentEndpoint = "/v1/orders/checkout";
  static const String changepassword = "/v1/auth/change-password";

  static const String getSavedAddress = "/v1/addresses";

  static String deleteSavedAddres(String id) => '/v1/addresses/$id';

  static const String addAddress = "/v1/addresses";
  static String updateAddress(String addressId) => "/v1/addresses/$addressId";
}
