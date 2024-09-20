// lib/services/cart_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/providers/cart_provider.dart';


class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a product to the cart
  Future<void> addToCart(String userId, CartItem cartItem) async {
    try {
      DocumentReference cartRef = _firestore
          .collection('carts')
          .doc(userId)
          .collection('items')
          .doc(cartItem.id);
      await cartRef.set(cartItem);
    } catch (error) {
      print('Error adding item to cart: $error');
    }
  }

  // Remove a product from the cart
  Future<void> removeFromCart(String userId, String productId) async {
    try {
      DocumentReference cartRef = _firestore
          .collection('carts')
          .doc(userId)
          .collection('items')
          .doc(productId);
      await cartRef.delete();
    } catch (error) {
      print('Error removing item from cart: $error');
    }
  }

  // Fetch the cart items for a user
  Future<List> fetchCartItems(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('carts')
          .doc(userId)
          .collection('items')
          .get();
      return snapshot.docs.map((doc) {
        return CartItem.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (error) {
      print('Error fetching cart items: $error');
      return [];
    }
  }

  // Clear the cart
  Future<void> clearCart(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('carts')
          .doc(userId)
          .collection('items')
          .get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (error) {
      print('Error clearing cart: $error');
    }
  }
}
