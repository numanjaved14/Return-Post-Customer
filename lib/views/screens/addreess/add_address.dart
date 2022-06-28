import 'dart:async';
import 'dart:typed_data';

import 'package:couriercustomer/services/geo_locator.dart';
import 'package:couriercustomer/views/screens/add_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddress extends StatefulWidget {
  String? brand, carrier, price;
  Uint8List? image;
  AddAddress({
    Key? key,
    this.image,
    this.brand,
    this.carrier,
    this.price,
  }) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _floorController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  var _address;
  List<double>? latlong;
  bool _gotLatLong = false;

  @override
  void initState() {
    getAddress();
    getLatLong();
    super.initState();
  }

  void getAddress() async {
    await getLocation().getCurrentLocation(false).then((value) {
      setState(() {
        _addressController.text = value;
      });
    });
    // _addressController.text = _address.toString();
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
            child: Image.asset('assets/backs.png'),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 10, top: 15),
              child: const Text(
                'Add your address',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              )),
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
                            zoom: 20,
                          ),
                          mapType: MapType.normal,
                          compassEnabled: true,
                          zoomControlsEnabled: false,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 10, top: 15),
              child: Text(
                'Details',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              )),
          Container(
            margin: EdgeInsets.only(left: 30, top: 25),
            child: Text('Name',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff8D8989))),
          ),
          Container(
              height: 55,
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),

              //  padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Color(0xff535353),
                borderRadius: new BorderRadius.circular(20),
              ),
              // border: Border.all(color: Colors.grey,width: 0.5)

              child: TextFormField(
                controller: _nameController,
                //  textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: ' eg. Home, Job',
                  contentPadding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                  ),
                  border: InputBorder.none,
                  labelStyle: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                  hintStyle: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff8D8989),
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                ),
              )),
          Container(
            margin: EdgeInsets.only(left: 30, top: 15),
            child: Text(
              'Address',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0xff8D8989),
              ),
            ),
          ),
          Container(
              height: 55,
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),

              //  padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Color(0xff535353),
                borderRadius: new BorderRadius.circular(20),
              ),
              // border: Border.all(color: Colors.grey,width: 0.5)

              child: TextFormField(
                controller: _addressController,
                //  textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: ' London, WC2n 4JH, United Kingdom',
                  contentPadding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                  ),
                  border: InputBorder.none,
                  labelStyle: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                  hintStyle: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff8D8989),
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                ),
              )),
          Container(
            margin: EdgeInsets.only(left: 30, top: 15),
            child: Text('Floor number, apartments',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff8D8989))),
          ),
          Container(
              height: 55,
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),

              //  padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Color(0xff535353),
                borderRadius: new BorderRadius.circular(20),
              ),
              // border: Border.all(color: Colors.grey,width: 0.5)

              child: TextFormField(
                controller: _floorController,
                //  textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: ' e.g. Floor, Unit',
                  contentPadding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                  ),
                  border: InputBorder.none,
                  labelStyle: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                  hintStyle: GoogleFonts.getFont('Montserrat',
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff8D8989),
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                ),
              )),
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffEB5757),
                  minimumSize: Size(310, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () async {
                  if (_nameController.text.isNotEmpty &&
                      _addressController.text.isNotEmpty &&
                      _floorController.text.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddOrderScreen(
                          aName: _nameController.text,
                          address: _addressController.text,
                          brand: widget.brand,
                          carrier: widget.carrier,
                          floor: _floorController.text,
                          image: widget.image,
                          price: widget.price,
                          lati: latlong![0],
                          longi: latlong![1],
                        ),
                      ),
                    );
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please input all fields",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text(
                  'Add Address',
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
    );
  }
}
