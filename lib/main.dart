import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/order_provider.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/screens/auth/login_screen.dart';
import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/screens/category_screen.dart';
import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/screens/orders_screen.dart';
import 'package:e_commerce/screens/product_detail_screen.dart';
import 'package:e_commerce/services/fcm_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDAlAS0Fz5KgAtEanPDIbN_aOPCZ1uqYws",
    authDomain: "ecommerce-36d06.firebaseapp.com",
    projectId: "ecommerce-36d06",
    storageBucket: "ecommerce-36d06.appspot.com",
    messagingSenderId: "900853072435",
    appId: "1:900853072435:web:98747c16f20aa44e23d946",
    measurementId: "G-ZZYFPWJGCB",
    databaseURL: 'https://ecommerce-36d06-default-rtdb.firebaseio.com',
    )
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
 FCMService fcmService = FCMService();
  await fcmService.initialize();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message while in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
 NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission for notifications.');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission.');
  } else {
    print('User declined or has not accepted permission.');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()), // Authentication
  ChangeNotifierProvider(create: (_) => ProductProvider()), // Products
  ChangeNotifierProvider(create: (_) => CartProvider()), // Cart
  ChangeNotifierProvider(create: (_) => OrderProvider()), // Orders
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E-Commerce App',
            theme: ThemeData(
              primarySwatch: Colors.green,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            routes: {
              '/': (context) => authProvider.isAuthenticated
                  ? HomeScreen()
                  : LoginScreen(), // Home or Login based on authentication
              '/login': (context) => LoginScreen(),
              '/home': (context) => HomeScreen(),
              '/category': (context) {
                final String category =
                    ModalRoute.of(context)!.settings.arguments as String;
                return CategoryScreen(category: category);
              },
              '/productDetail': (context) {
  final Product product = ModalRoute.of(context)!.settings.arguments as Product;
  return ProductDetailScreen(product: product);
},
              '/cart': (context) => CartScreen(),
              '/orders': (context) => OrdersScreen(),
            },
            initialRoute: '/', // Start the app at the root route
          );
        },
      ),
    );
  }
}
