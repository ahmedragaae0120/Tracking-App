sealed class HomeIntent {}

class GetPendingOrdersIntent extends HomeIntent {}

class StartOrderIntent extends HomeIntent {
  final String orderId;
  StartOrderIntent({required this.orderId});
}

class SearchOrdersIntent extends HomeIntent {
  final String query;
  SearchOrdersIntent({required this.query});
}

class RejectOrderIntent extends HomeIntent {
  final String orderId;
  RejectOrderIntent({required this.orderId});
}

// Add this new intent class
class LoadMoreOrdersIntent extends HomeIntent {}