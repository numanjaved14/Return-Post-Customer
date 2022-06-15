import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couriercustomer/views/screens/add_order_screen.dart';
import 'package:couriercustomer/views/screens/addreess/add_address.dart';
import 'package:couriercustomer/views/screens/order_place/scroll_ijector.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';

class BrandSelectScreen extends StatefulWidget {
  const BrandSelectScreen({Key? key}) : super(key: key);

  @override
  State<BrandSelectScreen> createState() => _BrandSelectScreenState();
}

class _BrandSelectScreenState extends State<BrandSelectScreen> {
  String? brand;
  String? carrier;
  String? price;
  Uint8List? _image;

  _selectImage() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              'Select an Image',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Divider(
                thickness: 3,
                color: Colors.red,
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Take a photo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List im = await pickeImage(ImageSource.camera);
                  setState(() {
                    _image = im;
                  });
                },
              ),
              // Divider(
              //   thickness: 0.5,
              //   color: Colors.red,
              // ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Choose from gallery',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List im = await pickeImage(ImageSource.gallery);
                  setState(() {
                    _image = im;
                  });
                },
              ),
              //  Divider(
              //   thickness: 0.5,
              //   color: Colors.red,
              // ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Close',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff404040),
        leading: Padding(
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
      backgroundColor: const Color(0xff404040),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('brands').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                List brands = [];
                List prices = [];

                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  brands.add(snapshot.data!.docs[i].data()['brandName']);
                  prices.add(snapshot.data!.docs[i].data()['brandPrice']);
                }
                // brands.add('Others');
                // snapshot.data!.docs
                //   ..forEach(
                //     (element) => brands.add(element),
                //   );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Book return',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Spacer(),
                    //Consider as brands
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('Choose retailer',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('Store',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8D8989))),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ScrollIjector(
                          groupingType: GroupingType.wrap,
                          child: GroupButton(
                              // buttons: snapshot.data!.docs[0].data()['brandName'],
                              buttons: brands,
                              controller: GroupButtonController(),
                              options: GroupButtonOptions(
                                textPadding: EdgeInsets.all(20),
                                selectedShadow: const [],
                                unselectedShadow: const [],
                                selectedBorderColor: Colors.red,
                                unselectedBorderColor: Colors.black,
                                unselectedColor: Colors.grey[300],
                                unselectedTextStyle: TextStyle(
                                  color: Colors.grey[600],
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              onSelected: (val, i, selected) {
                                brand = val.toString();
                                print(brand);
                                int i = brands.indexOf(brand);
                                print(i.toString());
                                price = prices.elementAt(i);
                                print(price);
                              }),
                        ),
                      ),
                    ),

                    // Means select the carrier of the service mean who picks the parcel

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('Select carrier',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('Post Office',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8D8989))),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    /// Put Carriers DETAILS iN ADMIN Panel
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('carriers')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasData) {
                            List carriers = [];
                            for (int i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              carriers.add(
                                  snapshot.data!.docs[i].data()['carrierName']);
                            }
                            // carriers.add('Others');
                            return Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ScrollIjector(
                                  groupingType: GroupingType.wrap,
                                  child: GroupButton(
                                    buttons: carriers,
                                    controller: GroupButtonController(),
                                    options: GroupButtonOptions(
                                      textPadding: EdgeInsets.all(20),
                                      selectedShadow: const [],
                                      unselectedShadow: const [],
                                      selectedBorderColor: Colors.red,
                                      unselectedBorderColor: Colors.black,
                                      unselectedColor: Colors.grey[300],
                                      unselectedTextStyle: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    onSelected: (val, i, selected) =>
                                        carrier = val.toString(),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('Upload QR code & Images',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 55,
                          width: 101,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xff535353)),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => _selectImage(),
                          child: Container(
                            height: 55,
                            width: 101,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color(0xff535353)),
                            child: _image == null
                                ? Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  )
                                : Image.memory(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 55,
                          width: 101,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xff535353)),
                          child: Icon(
                            Icons.qr_code,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Spacer(),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.1,
                    //   child: StreamBuilder(
                    //       stream: null,
                    //       builder: (context, snapshot) {
                    //         return ListView.builder(
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: 5,
                    //           itemBuilder: (context, index) => Card(
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(18.0),
                    //             ),
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(15.0),
                    //               child: Center(child: Text('amazon')),
                    //             ),
                    //           ),
                    //         );
                    //       }),
                    // ),
                    // Code Below to upload image
                    // Text(
                    //   'Upload Image',
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .headline6!
                    //       .copyWith(color: Colors.white),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.1,
                    //   width: MediaQuery.of(context).size.width * 0.3,
                    //   child: InkWell(
                    //     onTap: _selectImage,
                    //     child: Card(
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(18.0),
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(5.0),
                    //         child: _image == null
                    //             ? Center(child: Icon(Icons.add))
                    //             : Image.memory(
                    //                 _image!,
                    //                 fit: BoxFit.cover,
                    //               ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Container(
                      margin: EdgeInsets.only(bottom: 20, top: 10),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xffEB5757),
                            fixedSize: const Size(202, 60),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23)),
                          ),
                          onPressed: () {
                            if (brand != null &&
                                carrier != null &&
                                _image != null) {
                              print(brand! + price! + carrier!);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddAddress(
                                    brand: brand,
                                    price: price,
                                    carrier: carrier,
                                    image: _image,
                                  ),
                                ),
                              );
                            } else {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please Select all options",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          //  () {
                          //   print('this is name controller $_usernameController');

                          //   print('this is name controller $_emailController');

                          //   print('this is name controller $_passwordController');

                          //   print('this is name controller $_refreralController');

                          //   if (formKey.currentState!.validate()) ;

                          //   // Navigator.push(context,
                          //   //     MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                          // },
                          child: Text(
                            'Next',
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
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
