
import 'package:couriercustomer/views/onboardingScreens/onboard.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class WelcomeN extends StatefulWidget {
  const WelcomeN({Key? key}) : super(key: key);

  @override
  _WelcomeNState createState() => _WelcomeNState();
}

class _WelcomeNState extends State<WelcomeN> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
           
          ),
          child: Column(
            children: [
              Expanded(child: OnBoardingScreens()),
            ],
          ),
        ),
      ),
    );
  }
}
