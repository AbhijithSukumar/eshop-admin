// ignore_for_file: avoid_print

import 'package:eshop_admin/view/allUsers.dart';
import 'package:eshop_admin/view/ratings.dart';
import 'package:eshop_admin/view/userdetails.dart';
import 'package:eshop_admin/view/view_request_seller.dart';
import 'package:eshop_admin/widgets/rating.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:eshop_admin/config/configuration.dart';
import 'package:eshop_admin/config/routes.dart';
import 'package:eshop_admin/firebase_options.dart';
import 'package:eshop_admin/view/allsellers.dart';
import 'package:eshop_admin/view/home.dart';
import 'package:eshop_admin/view/login.dart';
import 'package:eshop_admin/view/orders.dart';
import 'package:eshop_admin/view/ordersdetails.dart';
import 'package:eshop_admin/view/requests.dart';
import 'package:eshop_admin/view/sellerdetails.dart';
import 'package:eshop_admin/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightmode,
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (context) => const SplashScreen(),
        Routes.home: (context) => const HomeScreen(),
        Routes.login: (context) => const LoginScreen(),
        Routes.allsellers: (context) => const Allsellers(),
        Routes.requests: (context) => const Requests(),
        Routes.orders: (context) => const Orders(),
        Routes.sellersdetails: (context) => const Sellerdetails(),
        Routes.orderdetails: (context) => const Ordersdetals(),
        Routes.allUsers: (context) => const AllUsers(),
        Routes.allReqSellers:(context) => const AllReqsellers(),
        Routes.userDetails:(context) => const Userdetails(),
        Routes.ratings:(context) => const Ratings()
      },
    );
  }
}
