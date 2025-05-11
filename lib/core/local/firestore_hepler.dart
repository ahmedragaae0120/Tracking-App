import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

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
}
