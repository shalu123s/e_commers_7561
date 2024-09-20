// lib/providers/order_provider.dart

import 'package:e_commerce/models/order.dart';
import 'package:e_commerce/services/order_service.dart';
import 'package:flutter/material.dart';


class OrderProvider with ChangeNotifier {
  final OrderService _orderService = OrderService();
  List<Order> _orders = [];
  bool _isLoading = false;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;

  Future<void> fetchOrders(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _orders = (await _orderService.fetchOrdersForUser(userId)).cast<Order>();
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Failed to fetch orders: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> placeOrder( order) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _orderService.placeOrder(order);
      _orders.insert(0, order);  // Add the order to the beginning of the list
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Failed to place order: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
