class Constant {
  static const String tokenKey = 'auth_token';
  static const String highestPrice = 'HighestPrice';
  static const String lowestPrice = 'LowestPrice';
  static const String isRememberMe = 'isRememberMe';
  static const String baseUrl = "https://flower.elevateegy.com/api";
  static const String openRouteStreetBaseUrl =
      "https://api.openrouteservice.org";
  static const String regExValidateEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static RegExp regexPass = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$',
  );
  static const String questCacheKey = "is_quest";
  static const String cacheOnDelivery = "CacheOnDelivery";
  static const String creditCard = "CreditCard";
  static const String completedKey = "completed";
  static const String canceledKey = "canceled";
  static const String acceptedOrderKey = "accepted_order_id";

  static const String openRouteStreetApiKey =
      "5b3ce3597851110001cf6248ffa453852f25456fbbf8b2f3cc90a574";

  static const Duration connectTimeout = Duration(seconds: 40);
}
