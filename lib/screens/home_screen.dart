import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/widgets/banner_carousel.dart';
import 'package:e_commerce/widgets/category_list.dart';
import 'package:e_commerce/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch products when the screen initializes
    Future.microtask(() => Provider.of<ProductProvider>(context, listen: false).fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerCarousel(), // Displays promotional banners
            CategoryList(),   // Displays product categories
            productProvider.isLoading
                ? Center(child: CircularProgressIndicator()) // Show loading spinner
                : productProvider.products.isEmpty
                    ? Center(child: Text('No products available'))
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
          ],
        ),
      ),
    );
  }
}
