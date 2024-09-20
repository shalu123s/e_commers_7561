// lib/services/order_service.dart


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/order.dart'as Or;

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Place a new order
  Future<void> placeOrder(Or.Order order) async {
    try {
      DocumentReference orderRef = _firestore.collection('orders').doc();
      await orderRef.set(order);
    } catch (error) {
      print('Error placing order: $error');
    }
  }

  // Fetch all orders for a user
  Future<List<Object>> fetchOrdersForUser(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();
      return snapshot.docs.map((doc) {
        return Or.Order.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (error) {
      print('Error fetching orders: $error');
      return [];
    }
  }
}
