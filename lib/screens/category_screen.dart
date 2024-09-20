// lib/screens/category_screen.dart

import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CategoryScreen extends StatefulWidget {
  final String category;

  CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false)
        .fetchProductsByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: productProvider.products.length,
              itemBuilder: (ctx, index) {
                final product = productProvider.products[index];
                return ProductTile(product: product);
              },
            ),
    );
  }
}
