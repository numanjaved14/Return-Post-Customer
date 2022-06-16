import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/database_services.dart';

class OrderDetails extends StatefulWidget {
  var snap;

  OrderDetails({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff404040),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff404040),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/back.png'),
                )),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Delivery to',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8D8989),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 15),
              child: Text(
                '8 St. Martin’s Pl',
                style: GoogleFonts.getFont('Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.normal),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                widget.snap['address'],
                style: GoogleFonts.getFont('Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.normal),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: Divider(
                  color: Color(0xff535353),
                )),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Text('Store you’re returning to',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8D8989))),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 15),
              child: Text(
                widget.snap['brandName'],
                style: GoogleFonts.getFont('Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.normal),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 20, top: 5, right: 20),
                child: Divider(
                  color: Color(0xff535353),
                )),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Text('Categories',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8D8989))),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 15),
              child: Text(
                widget.snap['categoryName'],
                style: GoogleFonts.getFont('Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.normal),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 20, top: 5, right: 20),
                child: Divider(
                  color: Color(0xff535353),
                )),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Text('Carrier',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8D8989))),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 15),
              child: Text(
                widget.snap['carrier'],
                style: GoogleFonts.getFont('Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.normal),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 20, top: 5, right: 20),
                child: Divider(
                  color: Color(0xff535353),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Discount code',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Container(
                    child: Text(
                      '5KS82Q',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Tracking number',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Container(
                    child: Text(
                      'QQ581593089GB',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Distance',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Container(
                    child: Text(
                      '5.1 km',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Service fees',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Container(
                    child: Text(
                      '£ 2.99',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 20, top: 5, right: 20),
                child: Divider(
                  color: Color(0xff535353),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Payment method',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Total Price:',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Container(
                    child: Text(
                      '£ ${widget.snap['price']}',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
