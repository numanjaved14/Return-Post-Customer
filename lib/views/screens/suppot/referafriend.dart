import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ReferAFreiend extends StatefulWidget {
  const ReferAFreiend({Key? key}) : super(key: key);

  @override
  State<ReferAFreiend> createState() => _ReferAFreiendState();
}

class _ReferAFreiendState extends State<ReferAFreiend> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
                backgroundColor: Color(0xff404040),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
                  margin: EdgeInsets.only(left: 20,bottom: 10),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/backbutton.png',width: 49,height: 49,))),
      
                Container(
                              margin: EdgeInsets.only(left: 20,top:10),
      
                child: Text('Refer a friend and earn',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 24),)),
      
                Container(
                margin: EdgeInsets.only(left: 20,bottom: 10),
                child:  Image.asset('assets/five.png',width: 321,height: 321,)),        
      
               Center(
                 child: Container(
                                              margin: EdgeInsets.only(left: 20,top: 20,right: 20),
      
                  child: Text('If you enjoy the app, refer your friends and receive a £ 0.50 reward!',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 24),),
                 ),
               ) ,
               Center(
                 child: Container(
                                              margin: EdgeInsets.only(left: 20,top: 20,right: 20),
      
                  child: Text("Share your love for Return Post with your bestie and unlock big bonuses. They'll no doubt fall for our Supadupa service. And your friend make their first order, you'll pocket £0.50 in your account balance!But hurry! This offer wont stick around",style: TextStyle(color: Color(0xff8D8989),fontWeight: FontWeight.w600,fontSize: 16),),
                 ),
               ) ,
               SizedBox(height: 10,),
                 Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffEB5757),
                    minimumSize: Size(310, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                  ),
                  onPressed: () async {
                  
                 
                  },
                  child:Text(
                          'Invite Friend',
                          style: GoogleFonts.getFont('Montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 15,
                              fontStyle: FontStyle.normal),
                        ),
                ),
              ),
                             SizedBox(height: 10,),

          ],
        ),
      ),
      ),
    );
  }
}