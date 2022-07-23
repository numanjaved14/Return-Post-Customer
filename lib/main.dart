import 'package:couriercustomer/providers/location_provider.dart';
import 'package:couriercustomer/views/onboardingScreens/welcomeboarding.dart';
import 'package:couriercustomer/views/screens/addreess/add_address.dart';
import 'package:couriercustomer/views/screens/authentication/signinpage.dart';
import 'package:couriercustomer/views/screens/bottom_nav.dart';
import 'package:couriercustomer/views/screens/chatmodels/chat.dart';
import 'package:couriercustomer/views/screens/chatmodels/chatpage.dart';
import 'package:couriercustomer/views/screens/order_place/add_payment.dart';
import 'package:couriercustomer/views/screens/order_place/brand_select_screen.dart';
import 'package:couriercustomer/views/screens/suppot/support.dart';
import 'package:couriercustomer/widgets/mydrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'views/screens/checkout/order_checkout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51KxapZBmHAwiQPYIuhMu1UtbLnLzL0mQAxLN2aauvJxtHTjEFI5CGfA8yptCI7iklCb1ffAnrvxyR8e8iP3B88JA00GktN5pqZ';

  await Stripe.instance.applySettings();
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
      // home: Chat(),
      home: FirebaseAuth.instance.currentUser == null
          ? const WelcomeN()
          : MyNavigationBar(),
    );
  }
}
