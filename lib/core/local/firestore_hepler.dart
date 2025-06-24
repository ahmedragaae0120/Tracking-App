import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

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

@injectable
@singleton
class FirestoreHepler {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get ordersCollection =>
      _firestore.collection('orders');

  final formattedDate = DateFormat('dd MMM yyyy - h:mm').format(DateTime.now());

  Future<void> updateOrderStatusIsDoneByName({
    required String orderId,
    required OrderStatus statusName,
    required bool isDone,
  }) async {
    final docRef = ordersCollection.doc(orderId);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      final List<dynamic> orderStatus = List.from(data?['orderStatus'] ?? []);

      bool updated = false;

      for (int i = 0; i < orderStatus.length; i++) {
        if (orderStatus[i]['status name'] == statusName.statusName) {
          orderStatus[i]['is done'] = isDone;
          orderStatus[i]['date'] = isDone == false ? null : formattedDate;
          updated = true;
          break;
        }
      }

      if (updated) {
        await docRef.update({'orderStatus': orderStatus});
      } else {
        throw Exception('Status name "${statusName.statusName}" not found');
      }
    } else {
      throw Exception('Order not found');
    }
  }

  Future<void> updateDriverInfo(
      {required String orderId,
      required String name,
      required String phone,
      required String driverId,
      required DriverStatus driverStatus}) async {
    final docRef = ordersCollection.doc(orderId);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      await docRef.update({
        'driverName': name,
        'driverPhone': phone,
        'driverId': driverId,
        'driverStatus': driverStatus.status
      });
    } else {
      throw Exception('Order not found');
    }
  }
}
