sealed class OrdersIntent {}

class GetDriverOrdersIntent extends OrdersIntent {}

class GetSpecificProductIntent extends OrdersIntent {
  final String productId;
  GetSpecificProductIntent({required this.productId});
}