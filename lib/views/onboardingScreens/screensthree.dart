
import 'package:flutter/material.dart';

class OnboardingScreenThree extends StatefulWidget {
  @override
  State<OnboardingScreenThree> createState() => _OnboardingScreenThreeState();
}

class _OnboardingScreenThreeState extends State<OnboardingScreenThree> {
  bool currentTab = false;
  @override
  Widget build(BuildContext context) {
    //it will helps to return the size of the screen
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff404040),
      body:  Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    
                    alignment: Alignment.topRight,
                    child: Text("Skip",style: TextStyle(color: Color(0xff8D8989),fontSize: 12,fontWeight: FontWeight.w500),textAlign: TextAlign.center,)),
                ),
              ),
              Flexible(child: Container()),
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Be in control",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Flexible(child: Container()),
              Image.asset('assets/panethree.png',height: 248,),
                 Flexible(child: Container()),
               Text(
                'Track your parcels in real time \n from your door direct to carrier.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),                  
 Flexible(child: Container()),
  Flexible(child: Container()),
                
            ],
          ),
    );
  }
}
