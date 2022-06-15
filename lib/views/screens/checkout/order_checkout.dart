import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/database_services.dart';
import '../bottom_nav.dart';

class OrderCheckOut extends StatefulWidget {
  String? brand, carrier, price, aName, address, floor, catName, category, date;
  Uint8List? image;

  OrderCheckOut({
    Key? key,
    this.aName,
    this.address,
    this.brand,
    this.carrier,
    this.floor,
    this.price,
    this.image,
    this.catName,
    this.category,
    this.date,
  }) : super(key: key);

  @override
  State<OrderCheckOut> createState() => _OrderCheckOutState();
}

class _OrderCheckOutState extends State<OrderCheckOut> {
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
              margin: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Check Out',
                style: GoogleFonts.getFont('Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 24,
                    fontStyle: FontStyle.normal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/maps.png'),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Text('Delivery to',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8D8989))),
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
                widget.address!,
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
                widget.brand!,
                style: GoogleFonts.getFont('Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.normal),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 5),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Edit',
                    style: GoogleFonts.getFont('Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff0E7DE3),
                        fontStyle: FontStyle.normal),
                  ),
                )),
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
                widget.category!,
                style: GoogleFonts.getFont('Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.normal),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 5),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Edit',
                    style: GoogleFonts.getFont('Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff0E7DE3),
                        fontStyle: FontStyle.normal),
                  ),
                )),
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
                widget.carrier!,
                style: GoogleFonts.getFont('Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.normal),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 5),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Edit',
                    style: GoogleFonts.getFont('Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff0E7DE3),
                        fontStyle: FontStyle.normal),
                  ),
                )),
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
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Edit',
                          style: GoogleFonts.getFont('Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff0E7DE3),
                              fontStyle: FontStyle.normal),
                        ),
                      )),
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
                      '£ ${widget.price}',
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
              margin: EdgeInsets.only(bottom: 20, top: 20),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffEB5757),
                    minimumSize: Size(210, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)),
                  ),
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await DataBaseMethods()
                        .createOrder(
                          address: widget.address!,
                          category: widget.catName!,
                          price: widget.price!,
                          addressName: widget.aName!,
                          brand: widget.brand!,
                          carrier: widget.carrier!,
                          catName: widget.catName!,
                          date: widget.date!,
                          floor: widget.floor!,
                          image: widget.image!,
                          orderId: DateTime.now().toString(),
                        )
                        .then(
                          (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => MyNavigationBar(
                                  // title: '',
                                  ),
                            ),
                          ),
                        );
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          'Order',
                          style: GoogleFonts.getFont('Montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 15,
                              fontStyle: FontStyle.normal),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
