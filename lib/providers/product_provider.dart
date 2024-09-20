// lib/providers/product_provider.dart

import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/services/product_service.dart';
import 'package:flutter/material.dart';


class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

   // Fetch all products and update state
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();  // Notify UI to show loading state

    try {
      _products = await _productService.fetchAllProducts();
      notifyListeners();  // Notify UI to update with fetched data
    } catch (e) {
      print('Failed to fetch products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();  // Notify UI to hide loading state
    }
  }

  // Fetch products by category
  Future<void> fetchProductsByCategory(String category) async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productService.fetchProductsByCategory(category);
      notifyListeners();
    } catch (e) {
      print('Failed to fetch products by category: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
