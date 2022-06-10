import 'package:couriercustomer/views/onboardingScreens/welcomeboarding.dart';
import 'package:couriercustomer/views/screens/authentication/signinpage.dart';
import 'package:couriercustomer/views/screens/order_place/brand_select_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // home: const Signinpage(),
      home: WelcomeN(),
    );
  }
}
