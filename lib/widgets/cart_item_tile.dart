// lib/widgets/cart_item_tile.dart

import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;

  CartItemTile({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        leading: Image.network(
          cartItem.imageUrl,
          width: 50,
          fit: BoxFit.cover,
        ),
        title: Text(cartItem.name),
        subtitle: Text('Price: \$${cartItem.price.toStringAsFixed(2)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                cartProvider.removeItem(cartItem.id);
              },
            ),
            Text('${cartItem.quantity}'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                cartProvider.addItem(cartItem as Product);
              },
            ),
          ],
        ),
      ),
    );
  }
}
