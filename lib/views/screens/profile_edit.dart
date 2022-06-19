import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couriercustomer/models/usermodel.dart';
import 'package:couriercustomer/services/authmethods.dart';
import 'package:couriercustomer/services/database_services.dart';
import 'package:couriercustomer/services/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/utils.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController _fieldController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  Uint8List? _image;
  var userData;
  bool _hasData = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    _fieldController.dispose();
    _passController.dispose();
    _emailController.dispose();
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
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: _hasData
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'My Profile',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 24,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: Image.network(
                              userData['photoUrl'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          // margin: const EdgeInsets.only(left: 5),
                          child: TextButton(
                            onPressed: () => _selectImage(),
                            child: Text(
                              'Edit photo',
                              style: GoogleFonts.getFont('Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: const Color(0xff0E7DE3),
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: const Text(
                      'Name',
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
                      userData['username'],
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: TextButton(
                      onPressed: () => showAlertDialog('Name'),
                      child: Text(
                        'Edit',
                        style: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: const Color(0xff0E7DE3),
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  //   child: const Divider(
                  //     color: Color(0xff535353),
                  //   ),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.only(left: 20, top: 10),
                  //   child: const Text(
                  //     'Phone number',
                  //     style: TextStyle(
                  //       fontSize: 10,
                  //       fontWeight: FontWeight.w500,
                  //       color: Color(0xff8D8989),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(left: 20, top: 15),
                  //   child: Text(
                  //     '+380 93 747 23 18',
                  //     style: GoogleFonts.getFont('Montserrat',
                  //         fontWeight: FontWeight.w600,
                  //         color: Colors.white,
                  //         fontSize: 14,
                  //         fontStyle: FontStyle.normal),
                  //   ),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.only(left: 5),
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       'Edit',
                  //       style: GoogleFonts.getFont('Montserrat',
                  //           fontWeight: FontWeight.w500,
                  //           fontSize: 14,
                  //           color: const Color(0xff0E7DE3),
                  //           fontStyle: FontStyle.normal),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: const Divider(
                      color: Color(0xff535353),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: const Text(
                      'Email',
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
                      userData['email'],
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: TextButton(
                      onPressed: () => showEmailAlertDialog(userData['email']),
                      child: Text(
                        'Edit',
                        style: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: const Color(0xff0E7DE3),
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  showAlertDialog(String title) {
    setState(() {
      _isLoading = false;
    });
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: const Color(0xffEB5757),
          // shape: ,
          title: Text(
            'New $title',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 55,
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),

                //  padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(20),
                ),
                // border: Border.all(color: Colors.grey,width: 0.5)

                child: TextFormField(
                  controller: _fieldController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return "Please Enter field";
                    }
                  },
                  obscureText: false,
                  //  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: ' Enter new $title',
                    contentPadding: EdgeInsets.only(top: 10, left: 20),
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    hintStyle: GoogleFonts.getFont('Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Color(0xffEB5757),
                        fontSize: 12,
                        fontStyle: FontStyle.normal),
                    // hintStyle: TextStyle(

                    //   color: Color(0xff8D8989), // <-- Change this
                    //   fontSize: 12,
                    //   fontWeight: FontWeight.w600,
                    //   fontStyle: FontStyle.normal,
                    // ),
                  ),
                ),
              ),
            ),
            SimpleDialogOption(
              child: Container(
                height: 55,
                margin: const EdgeInsets.only(left: 30, right: 30, top: 10),

                //  padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                // border: Border.all(color: Colors.grey,width: 0.5)

                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Save',
                          style: TextStyle(
                            color: Color(0xffEB5757),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                var res = await DataBaseMethods().UpdateCustomerUser(
                    key: title == 'Name' ? 'username' : 'email',
                    value: _fieldController.text);
                if (res == 'updated successfully') {
                  setState(() {
                    _isLoading = false;
                    _fieldController.clear();
                  });
                  Navigator.of(context).pop();
                  getData();
                }
              },
            ),
          ],
        );
      },
    );
  }

  showEmailAlertDialog(String email) {
    setState(() {
      _isLoading = false;
    });
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: const Color(0xffEB5757),
          // shape: ,
          title: const Text(
            'Change Email',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 55,
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),

                //  padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                // border: Border.all(color: Colors.grey,width: 0.5)

                child: TextFormField(
                  controller: _passController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return "Please Enter field";
                    }
                  },
                  obscureText: false,
                  //  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: ' Enter your old Password',
                    contentPadding: EdgeInsets.only(top: 10, left: 20),
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    hintStyle: GoogleFonts.getFont('Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Color(0xffEB5757),
                        fontSize: 12,
                        fontStyle: FontStyle.normal),
                    // hintStyle: TextStyle(

                    //   color: Color(0xff8D8989), // <-- Change this
                    //   fontSize: 12,
                    //   fontWeight: FontWeight.w600,
                    //   fontStyle: FontStyle.normal,
                    // ),
                  ),
                ),
              ),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 55,
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),

                //  padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(20),
                ),
                // border: Border.all(color: Colors.grey,width: 0.5)

                child: TextFormField(
                  controller: _emailController,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return "Please Enter field";
                    }
                  },
                  obscureText: false,
                  //  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: ' Enter new Email',
                    contentPadding: EdgeInsets.only(top: 10, left: 20),
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    hintStyle: GoogleFonts.getFont('Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Color(0xffEB5757),
                        fontSize: 12,
                        fontStyle: FontStyle.normal),
                    // hintStyle: TextStyle(

                    //   color: Color(0xff8D8989), // <-- Change this
                    //   fontSize: 12,
                    //   fontWeight: FontWeight.w600,
                    //   fontStyle: FontStyle.normal,
                    // ),
                  ),
                ),
              ),
            ),
            SimpleDialogOption(
              child: Container(
                height: 55,
                margin: const EdgeInsets.only(left: 30, right: 30, top: 10),

                //  padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                // border: Border.all(color: Colors.grey,width: 0.5)

                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Save',
                          style: TextStyle(
                            color: Color(0xffEB5757),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                var res = await AuthMethods().changeEmail(
                    email, _passController.text, _emailController.text);
                if (res == 'Success') {
                  setState(() {
                    _isLoading = false;
                  });
                  _emailController.clear();
                  _passController.clear();
                  Navigator.of(context).pop();
                  getData();
                }
              },
            ),
          ],
        );
      },
    );
  }

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
              const Divider(
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
                  var res = DataBaseMethods()
                      .UpdateCustomerUser(key: 'photoUrl', value: '', file: im);
                  if (res == 'updated successfully') {
                    Navigator.of(context).pop();
                  }
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

  void getData() async {
    setState(() {
      _hasData = false;
    });
    userData = await FirebaseFirestore.instance
        .collection('customers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      _hasData = true;
    });
  }
}
