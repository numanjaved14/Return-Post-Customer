
import 'package:couriercustomer/views/onboardingScreens/screensone.dart';
import 'package:couriercustomer/views/onboardingScreens/screensthree.dart';
import 'package:couriercustomer/views/onboardingScreens/screenstwo.dart';
import 'package:couriercustomer/views/screens/authentication/signinpage.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class OnBoardingScreens extends StatefulWidget {
  @override
  _OnBoardingScreensState createState() => _OnBoardingScreensState();
}

int currentPage = 0;

final _controller = PageController(initialPage: 0);
List<Widget> _pages = [
  Column(children: [Expanded(child: OnboardingScreenOne())]),
  Column(children: [Expanded(child: OnboardingScreenTwo())]),
  Column(children: [Expanded(child: OnboardingScreenThree())]),
  

];

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  int currnetTab = 0;
  @override
  Widget build(BuildContext context) {
    //  Size size = MediaQuery.of(context).size;
    return Scaffold(
     
      body: Column(
        children: [
            
          
         
                  
                        // 

             
          Expanded(
            child: PageView(
              controller: _controller,
              children: _pages,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),
        
         Container(
          color: Color(0xff404040),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [


               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: DotsIndicator(
                            dotsCount: _pages.length,
                            position: currentPage.toDouble(),
                            decorator: DotsDecorator(
                                  size: const Size.square(9.0),
    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                              color: Color(0xffC4C4C4), // Inactive color
                              activeColor: Colors.white,
                            ),
      ),
               ),
                   Container(
                     margin: EdgeInsets.only(bottom: 10),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder) => Signinpage()));
                       }, child: Text(currentPage == 0 ? "Next": currentPage == 1 ? "Next" : "Skip"),style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        fixedSize: Size(150, 60)
                       ),),
                     ),
                   ),

             ],
           ),
         ),
        ],
      ),
    );
  }
}
