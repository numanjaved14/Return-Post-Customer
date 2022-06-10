import 'package:flutter/material.dart';

class OnboardingScreenTwo extends StatefulWidget {
  @override
  State<OnboardingScreenTwo> createState() => _OnboardingScreenTwoState();
}

class _OnboardingScreenTwoState extends State<OnboardingScreenTwo> {
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
                    "It's Easy!",
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
              Image.asset('assets/panetwo.png',height: 248,),
                 Flexible(child: Container()),
               Text(
                'You Book - We Collect - Your \n  parcel is returned.',
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
