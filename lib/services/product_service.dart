// lib/services/product_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/product.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all products from Firestore
 Future<List<Product>> fetchAllProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (error) {
      print('Error fetching products: $error');
      return [];
    }
  }

  // Fetch products by category
 Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('category', isEqualTo: category)
          .get();
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (error) {
      print('Error fetching products by category: $error');
      return [];
    }
  }

  // Fetch a single product by ID
  Future<Product?> fetchProductById(String productId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (error) {
      print('Error fetching product: $error');
      return null;
    }
  }
}
