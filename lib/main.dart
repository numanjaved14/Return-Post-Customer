import 'package:couriercustomer/providers/location_provider.dart';
import 'package:couriercustomer/views/onboardingScreens/welcomeboarding.dart';
import 'package:couriercustomer/views/screens/addreess/add_address.dart';
import 'package:couriercustomer/views/screens/authentication/signinpage.dart';
import 'package:couriercustomer/views/screens/bottom_nav.dart';
import 'package:couriercustomer/views/screens/order_place/brand_select_screen.dart';
import 'package:couriercustomer/widgets/mydrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/screens/checkout/order_checkout.dart';

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
      home: FirebaseAuth.instance.currentUser == null
          ? const WelcomeN()
          : MyNavigationBar(),
    );
  }
}
