import 'dart:async';
import 'dart:typed_data';

import 'package:couriercustomer/views/screens/order_place/near_courrier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../services/database_services.dart';
import '../../../services/geo_locator.dart';
import '../bottom_nav.dart';

class OrderCheckOut extends StatefulWidget {
  String? brand, carrier, price, aName, address, floor, catName, category, date;
  double? lati, longi;
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
    this.lati,
    this.longi,
  }) : super(key: key);

  @override
  State<OrderCheckOut> createState() => _OrderCheckOutState();
}

class _OrderCheckOutState extends State<OrderCheckOut> {
  bool _isLoading = false;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? newGoogleMapController;
  var _address;
  List<double>? latlong;
  bool _gotLatLong = false;

  @override
  void initState() {
    getLatLong();
    super.initState();
  }

  void getLatLong() async {
    await getLocation().getLatLong().then((value) {
      latlong = value;
      setState(() {
        _gotLatLong = true;
      });
    });
  }

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
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  height: 130,
                  width: 310,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: _gotLatLong
                        ? GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(latlong![0], latlong![1]),
                              zoom: 16,
                            ),
                            mapType: MapType.normal,
                            compassEnabled: true,
                            zoomControlsEnabled: false,
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                              newGoogleMapController = controller;
                              newGoogleMapController!.setMapStyle('''
                      [
                        {
                          "elementType": "geometry",
                          "stylers": [
                            {
                              "color": "#242f3e"
                            }
                          ]
                        },
                        {
                          "elementType": "labels.text.fill",
                          "stylers": [
                            {
                              "color": "#746855"
                            }
                          ]
                        },
                        {
                          "elementType": "labels.text.stroke",
                          "stylers": [
                            {
                              "color": "#242f3e"
                            }
                          ]
                        },
                        {
                          "featureType": "administrative.locality",
                          "elementType": "labels.text.fill",
                          "stylers": [
                            {
                              "color": "#d59563"
                            }
                          ]
                        },
                        {
                          "featureType": "poi",
                          "elementType": "labels.text.fill",
                          "stylers": [
                            {
                              "color": "#d59563"
                            }
                          ]
                        },
                        {
                          "featureType": "poi.park",
                          "elementType": "geometry",
                          "stylers": [
                            {
                              "color": "#263c3f"
                            }
                          ]
                        },
                        {
                          "featureType": "poi.park",
                          "elementType": "labels.text.fill",
                          "stylers": [
                            {
                              "color": "#6b9a76"
                            }
                          ]
                        },
                        {
                          "featureType": "road",
                          "elementType": "geometry",
                          "stylers": [
                            {
                              "color": "#38414e"
                            }
                          ]
                        },
                        {
                          "featureType": "road",
                          "elementType": "geometry.stroke",
                          "stylers": [
                            {
                              "color": "#212a37"
                            }
                          ]
                        },
                        {
                          "featureType": "road",
                          "elementType": "labels.text.fill",
                          "stylers": [
                            {
                              "color": "#9ca5b3"
                            }
                          ]
                        },
                        {
                          "featureType": "road.highway",
                          "elementType": "geometry",
                          "stylers": [
                            {
                              "color": "#746855"
                            }
                          ]
                        },
                        {
                          "featureType": "road.highway",
                          "elementType": "geometry.stroke",
                          "stylers": [
                            {
                              "color": "#1f2835"
                            }
                          ]
                        },
                        {
                          "featureType": "road.highway",
                          "elementType": "labels.text.fill",
                          "stylers": [
                            {
                              "color": "#f3d19c"
                            }
                          ]
                        },
                        {
                          "featureType": "transit",
                          "elementType": "geometry",
                          "stylers": [
                            {
                              "color": "#2f3948"
                            }
                          ]
                        },
                        {
                          "featureType": "transit.station",
                          "elementType": "labels.text.fill",
                          "stylers": [
                            {
                              "color": "#d59563"
                            }
                          ]
                        },
                        {
                          "featureType": "water",
                          "elementType": "geometry",
                          "stylers": [
                            {
                              "color": "#17263c"
                            }
                          ]
                        },
                        {
                          "featureType": "water",
                          "elementType": "labels.text.fill",
                          "stylers": [
                            {
                              "color": "#515c6d"
                            }
                          ]
                        },
                        {
                          "featureType": "water",
                          "elementType": "labels.text.stroke",
                          "stylers": [
                            {
                              "color": "#17263c"
                            }
                          ]
                        }
                      ]
                  ''');
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Image.asset('assets/maps.png'),
            // ),
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
                          lati: widget.lati!,
                          longi: widget.longi!,
                          orderId: DateTime.now().toString(),
                        )
                        .then(
                          (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => const NearCourrier(),
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
