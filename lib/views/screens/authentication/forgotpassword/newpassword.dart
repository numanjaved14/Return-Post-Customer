import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:couriercustomer/views/screens/authentication/signinpage.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/back.png',
                height: 46,
                width: 46,
              )),
        ),
      ),
      extendBody: true,
      backgroundColor: Color(0xff404040),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 237,
            height: 88,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Text(
              'New Credentials',
              style: GoogleFonts.getFont('Montserrat',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 36,
                  fontStyle: FontStyle.normal),
            ),
          ),
          Container(
            // width: 265,
            height: 42,
            margin: EdgeInsets.only(left: 30, top: 15, bottom: 10),
            child: Text(
              'Your identity has been verified \n Set your new password',
              style: GoogleFonts.getFont('Montserrat',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 14,
                  fontStyle: FontStyle.normal),
            ),
          ),
          Container(
              height: 60,
              margin: EdgeInsets.only(left: 30, right: 30, top: 30),

              //  padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Color(0xff535353),
                borderRadius: new BorderRadius.circular(20),
              ),
              // border: Border.all(color: Colors.grey,width: 0.5)

              child: TextFormField(
                obscureText: true,
                //  textAlign: TextAlign.start,
                decoration: InputDecoration(
                  suffixIcon: Padding(
                      padding: EdgeInsets.only(top: 15, right: 20),
                      child: Icon(
                        Icons.visibility_outlined,
                        color: Color(0xff8D8989),
                      )),
                  hintText: 'New password',
                  contentPadding: EdgeInsets.only(top: 20, left: 20),
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  hintStyle: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8D8989),
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                  // hintStyle: TextStyle(

                  //   color: Color(0xff8D8989), // <-- Change this
                  //   fontSize: 12,
                  //   fontWeight: FontWeight.w600,
                  //   fontStyle: FontStyle.normal,
                  // ),
                ),
              )),
          Container(
              height: 60,
              margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),

              //  padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Color(0xff535353),
                borderRadius: new BorderRadius.circular(20),
              ),
              // border: Border.all(color: Colors.grey,width: 0.5)

              child: TextFormField(
                obscureText: true,
                //  textAlign: TextAlign.start,
                decoration: InputDecoration(
                  suffixIcon: Padding(
                      padding: EdgeInsets.only(top: 15, right: 20),
                      child: Icon(
                        Icons.visibility_outlined,
                        color: Color(0xff8D8989),
                      )),
                  hintText: 'Confrim password',
                  contentPadding: EdgeInsets.only(top: 20, left: 20),
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  hintStyle: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8D8989),
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                  // hintStyle: TextStyle(

                  //   color: Color(0xff8D8989), // <-- Change this
                  //   fontSize: 12,
                  //   fontWeight: FontWeight.w600,
                  //   fontStyle: FontStyle.normal,
                  // ),
                ),
              )),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xffEB5757),
                minimumSize: Size(310, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Signinpage()));
              },
              child: Text(
                'Update',
                style: GoogleFonts.getFont('Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 15,
                    fontStyle: FontStyle.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
