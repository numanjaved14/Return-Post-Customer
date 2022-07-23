import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff404040),
        body:Column(
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
                            margin: EdgeInsets.only(left: 20,top: 20),

              child: Text('Support',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 24),)),
                      Container(
                                                    margin: EdgeInsets.only(left: 20,top: 20),
                        child: Text('How To Connect Wallet',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),)),
                      Container(
                                                                            margin: EdgeInsets.only(left: 20,top: 20),

                        child: Text('Text Support Not Found IN DOucnment',style: TextStyle(color: Colors.white),)),
    
          ],
        )
      ),
    );
  }
}