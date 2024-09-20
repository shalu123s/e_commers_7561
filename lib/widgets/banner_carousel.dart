import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';

class BannerCarousel extends StatefulWidget {
  @override
  _BannerCarouselState createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final DatabaseReference _bannerRef =
      FirebaseDatabase.instance.ref().child('banners');
  List<String> _bannerUrls = [];

  @override
  void initState() {
    super.initState();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {
      // Access the event from the .once() call
      final DatabaseEvent event = await _bannerRef.once();

      // Access the snapshot from the DatabaseEvent
      final DataSnapshot snapshot = event.snapshot;

      // Check if the snapshot has data before trying to cast it
      if (snapshot.value != null) {
        List<String> bannerUrls = [];

        // Safely cast the snapshot value to Map
        Map<dynamic, dynamic> banners = snapshot.value as Map<dynamic, dynamic>;

        banners.forEach((key, value) {
          // Ensure that 'imageUrl' exists and is a string
          if (value != null && value is Map && value['imageUrl'] is String) {
            bannerUrls.add(value['imageUrl']);
          }
        });

        setState(() {
          _bannerUrls = bannerUrls;
        });
      } else {
        print('No banners found');
      }
    } catch (error) {
      print('Error fetching banners: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _bannerUrls.isEmpty
        ? Center(child: CircularProgressIndicator()) // Center the loading spinner
        : CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: _bannerUrls.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.network(url, fit: BoxFit.cover, width: 1000);
                },
              );
            }).toList(),
          );
  }
}
