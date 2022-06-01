import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:couriercustomer/views/screens/authentication/forgotpassword/newpassword.dart';

class MakeSelection extends StatefulWidget {
  const MakeSelection({Key? key}) : super(key: key);

  @override
  _MakeSelectionState createState() => _MakeSelectionState();
}

class _MakeSelectionState extends State<MakeSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          height: 46,
          width: 46,
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/back.png')),
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
              'Make Selection',
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
              'Select which contact details we \nshould use to reset your password!',
              style: GoogleFonts.getFont('Montserrat',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 14,
                  fontStyle: FontStyle.normal),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewPassword()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff535353),
              ),
              child: ListTile(
                title: Text(
                  'Via email',
                  style: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff404040),
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Icon(Icons.mobile_friendly_outlined),
                ),
                subtitle: Text(
                  'example@gmail.com',
                  style: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewPassword()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffEB5757),
              ),
              child: ListTile(
                title: Text(
                  'Via email',
                  style: TextStyle(
                      color: Color(0xff404040),
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Icon(Icons.mobile_friendly_outlined),
                ),
                subtitle: Text(
                  '+38077777777',
                  style: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
