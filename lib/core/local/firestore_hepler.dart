import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:latlong2/latlong.dart';

enum DriverStatus {
  accept("Accept"),
  reject("Reject");

  final String status;

  const DriverStatus(this.status);
}

enum OrderStatus {
  receivedYourOrder("Received your order"),
  preparingYourOrder("Preparing your order"),
  outForDelivery("Out for delivery"),
  delivered("Delivered");

  final String statusName;

  const OrderStatus(this.statusName);
}

abstract class FireStoreHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get ordersCollection =>
      _firestore.collection('orders');
  static final String formattedDate =
      DateFormat('dd MMM yyyy - h:mm').format(DateTime.now());

  static Future<void> updateOrderStatusIsDoneByName({
    required String orderId,
    required OrderStatus statusName,
    required bool isDone,
  }) async {
    final doc = await ordersCollection.doc(orderId).get();
    final data = doc.data();
    if (data == null) throw Exception('Order not found');

    final List<dynamic> orderStatus = List.from(data['orderStatus'] ?? []);
    final index = orderStatus.indexWhere(
        (element) => element['status name'] == statusName.statusName);

    if (index == -1) {
      throw Exception('Status "${statusName.statusName}" not found');
    }

    orderStatus[index]['is done'] = isDone;
    orderStatus[index]['date'] = isDone ? formattedDate : null;

    await ordersCollection.doc(orderId).update({'orderStatus': orderStatus});
  }

  static Future<void> updateDriverInfo({
    required String orderId,
    required String name,
    required String phone,
    required String driverId,
    required DriverStatus driverStatus,
  }) async {
    final doc = await ordersCollection.doc(orderId).get();
    if (!doc.exists) throw Exception('Order not found');

    await ordersCollection.doc(orderId).update({
      'driverName': name,
      'driverPhone': phone,
      'driverId': driverId,
      'driverStatus': driverStatus.status,
    });
  }

  static Future<void> updateDriverAddress({
    required String orderId,
    required String lat,
    required String long,
  }) async {
    final doc = await ordersCollection.doc(orderId).get();
    if (!doc.exists) throw Exception('Order not found');

    await ordersCollection.doc(orderId).update({
      'driverLatitude': lat,
      'driverLongitude': long,
    });
  }

  static Future<LatLng> getUserLocationByOrderId(String orderId) async {
    final doc = await ordersCollection.doc(orderId).get();
    final data = doc.data();
    if (data == null) throw Exception('Order not found');

    final latStr = data['userLatitude']?.toString();
    final longStr = data['userLongitude']?.toString();

    if (latStr == null || longStr == null) {
      throw Exception('User location data not found in this order');
    }

    final lat = double.tryParse(latStr);
    final long = double.tryParse(longStr);

    if (lat == null || long == null) {
      throw Exception('User location format is invalid');
    }

    print(" ⭐⭐ ${lat} , ${long}");

    return LatLng(lat, long);
  }
}
