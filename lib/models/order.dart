import 'package:e_commerce/providers/cart_provider.dart';

class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;
  final String shippingAddress;
  final String status;
  final DateTime datePlaced;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.shippingAddress,
    this.status = 'Pending',      // Default status is 'Pending'
    required this.datePlaced,
  });

  /// Factory constructor to create an Order from a map (e.g., from Firebase)
    factory Order.fromMap(Map<String, dynamic> map, String documentId) {
    return Order(
      id: documentId,
      userId: map['userId'] ?? '',
      items: (map['items'] as List<dynamic>).asMap().entries.map<CartItem>((entry) {
        final itemIndex = entry.key;
        final itemValue = entry.value as Map<String, dynamic>;
        return CartItem.fromMap(itemValue, itemValue['id'] ?? 'item_$itemIndex'); // Provide item ID here
      }).toList(),
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      shippingAddress: map['shippingAddress'] ?? '',
      status: map['status'] ?? 'Pending',
      datePlaced: DateTime.parse(map['datePlaced']),
    );
  }

  /// Convert an Order instance into a map (e.g., for uploading to Firebase)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'shippingAddress': shippingAddress,
      'status': status,
      'datePlaced': datePlaced.toIso8601String(),
    };
  }
}
