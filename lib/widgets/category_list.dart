// lib/widgets/category_list.dart

import 'dart:async';

import 'package:e_commerce/screens/category_screen.dart';
import 'package:flutter/material.dart';import 'package:firebase_database/firebase_database.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final DatabaseReference _categoryRef =
      FirebaseDatabase.instance.ref().child('categories');
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    _categoryRef.once().then((DataSnapshot snapshot) {
      List<Map<String, dynamic>> categories = [];
      Map<dynamic, dynamic> categoryMap = snapshot.value as Map<dynamic, dynamic>;
      categoryMap.forEach((key, value) {
        categories.add({
          'name': value['name'],
          'imageUrl': value['imageUrl'],
        });
      });
      setState(() {
        _categories = categories;
      });
    } as FutureOr Function(DatabaseEvent value)).catchError((error) {
      print('Error fetching categories: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return _categories.isEmpty
        ? CircularProgressIndicator()
        : Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(
                          category: category['name'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Image.network(
                          category['imageUrl'],
                          height: 60,
                          width: 60,
                        ),
                        Text(category['name']),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
