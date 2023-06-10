import 'package:app_cooky/myfolder/mydelivery_provider.dart';
import 'package:app_cooky/providers/category.dart';
import 'package:app_cooky/providers/deliver_provider.dart';
import 'package:app_cooky/providers/product_provider.dart';
import 'package:app_cooky/providers/review_cart_provider.dart';
import 'package:app_cooky/providers/user_provider.dart';
import 'package:app_cooky/screens/loadcreens.dart';
import 'package:app_cooky/screens/login/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
            create: (context) => ReviewCartProvider()),
        ChangeNotifierProvider<CheckoutProvider>(
            create: (context) => CheckoutProvider()),
        ChangeNotifierProvider<HTProvider>(create: (context) => HTProvider())
      ],
      child: GetMaterialApp(
        showSemanticsDebugger: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return LoadScreen();
            }
            return Sign_In();
          },
        ),
      ),
    );
  }
}
