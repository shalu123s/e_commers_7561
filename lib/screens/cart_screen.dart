// lib/screens/cart_screen.dart

import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/widgets/cart_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (ctx, index) {
                final cartItem = cartProvider.items.values.toList()[index];
                return CartItemTile(cartItem: cartItem);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total: \$${cartProvider.totalAmount}', style: TextStyle(fontSize: 20)),
          ),
          ElevatedButton(
            onPressed: () {
              // Proceed to checkout
            },
            child: Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
