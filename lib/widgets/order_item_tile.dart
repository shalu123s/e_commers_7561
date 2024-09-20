// lib/widgets/order_item_tile.dart

import 'package:e_commerce/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
class OrderItemTile extends StatelessWidget {
  final Order order;

  OrderItemTile({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Total: \$${order.totalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${DateFormat.yMMMd().format(order.datePlaced)}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Status: ${order.status}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _getStatusColor(order.status),
              ),
            ),
            SizedBox(height: 8),
            ExpansionTile(
              title: Text(
                'View Items',
                style: TextStyle(color: Colors.blue),
              ),
              children: order.items.map((cartItem) {
                return ListTile(
                  leading: Image.network(
                    cartItem.imageUrl,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(cartItem.name),
                  subtitle: Text('Qty: ${cartItem.quantity}'),
                  trailing: Text('\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns a color based on the status of the order
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'shipped':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
