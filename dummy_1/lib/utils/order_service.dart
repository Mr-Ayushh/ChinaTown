import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_1/models/orders_model.dart';
import 'package:dummy_1/utils/exports.dart';

class OrderService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _ordersCollection =
      _firestore.collection('ordersMaster');

  static Future<void> placeOrder(Orders order) async {
    try {
      await _ordersCollection.add(order.toJson());
    } catch (e) {
      debugPrint("Error placing order: $e");
      throw Exception("Failed to place order");
    }
  }
}
