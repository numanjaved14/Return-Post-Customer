import 'dart:typed_data';

import 'package:couriercustomer/views/screens/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:couriercustomer/views/screens/authentication/signinpage.dart';
import 'package:couriercustomer/services/authmethods.dart';
import 'package:couriercustomer/utils/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _refreralController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Uint8List? _image;

  bool _isLoading = false;

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

  signUpUser() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String res = await AuthMethods().signUpUser(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        userName: _usernameController.text,
        referal: _refreralController.text,
        address: _addressController.text,
        file: _image!,
      );
      print(_image);
      setState(() {
        _isLoading = false;
      });
      if (res == "Success") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => MyNavigationBar()),
          ),
        );
      }
    }
    print('this is SignUPUser $_emailController');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff404040),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    'Create an account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 32,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Center(
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 62,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: MemoryImage(_image!),
                              ),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage(
                                'assets/person.png',
                              ),
                            ),
                      Positioned(
                        bottom: -5,
                        left: 80,
                        child: IconButton(
                          onPressed: () {
                            _selectImage();
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    height: 60,
                    margin: EdgeInsets.only(left: 30, right: 30, top: 33),

                    //  padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: Color(0xff535353),
                      borderRadius: new BorderRadius.circular(20),
                    ),
                    // border: Border.all(color: Colors.grey,width: 0.5)

                    child: TextFormField(
                      style: TextStyle(color: Colors.white),

                      //  textAlign: TextAlign.start,
                      controller: _usernameController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return " Please Enter username..  ";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Name...',
                        contentPadding: EdgeInsets.only(top: 10, left: 20),
                        border: InputBorder.none,
                        labelStyle: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 12,
                            fontStyle: FontStyle.normal),
                        hintStyle: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Color(0xff8D8989),
                            fontSize: 12,
                            fontStyle: FontStyle.normal),
                      ),
                    )),
                Container(
                    height: 60,
                    margin: EdgeInsets.only(left: 30, right: 30, top: 25),

                    //  padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: Color(0xff535353),
                      borderRadius: new BorderRadius.circular(20),
                    ),
                    // border: Border.all(color: Colors.grey,width: 0.5)

                    child: TextFormField(
                      style: TextStyle(color: Colors.white),

                      //  textAlign: TextAlign.start,
                      controller: _emailController,
                      validator: (v) {
                        if (v!.isEmpty || !v.contains("@")) {
                          return " Enter valid email ";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: ' email...',
                        contentPadding: EdgeInsets.only(top: 10, left: 20),
                        border: InputBorder.none,
                        labelStyle: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 12,
                            fontStyle: FontStyle.normal),
                        hintStyle: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Color(0xff8D8989),
                            fontSize: 12,
                            fontStyle: FontStyle.normal),
                      ),
                    )),
                Container(
                    height: 60,
                    margin: EdgeInsets.only(left: 30, right: 30, top: 25),

                    //  padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: Color(0xff535353),
                      borderRadius: new BorderRadius.circular(20),
                    ),
                    // border: Border.all(color: Colors.grey,width: 0.5)

                    child: TextFormField(
                      style: TextStyle(color: Colors.white),

                      controller: _passwordController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return " Please Enter password..  ";
                        }

                        return null;
                      },
                      obscureText: true,
                      //  textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Icon(
                            Icons.visibility_off,
                            color: Color(0xff8D8989),
                          ),
                        ),
                        hintText: ' Password',
                        contentPadding: EdgeInsets.only(top: 20, left: 20),
                        border: InputBorder.none,
                        labelStyle: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 12,
                            fontStyle: FontStyle.normal),
                        hintStyle: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Color(0xff8D8989),
                            fontSize: 12,
                            fontStyle: FontStyle.normal),
                      ),
                    )),
                Container(
                  height: 60,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 25),

                  //  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: Color(0xff535353),
                    borderRadius: new BorderRadius.circular(20),
                  ),
                  // border: Border.all(color: Colors.grey,width: 0.5)

                  child: TextFormField(
                    style: TextStyle(color: Colors.white),

                    //  textAlign: TextAlign.start,
                    controller: _refreralController,
                    decoration: InputDecoration(
                      hintText: 'Referal Code(optional)',
                      contentPadding: EdgeInsets.only(top: 15, left: 20),
                      border: InputBorder.none,
                      labelStyle: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 12,
                          fontStyle: FontStyle.normal),
                      hintStyle: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Color(0xff8D8989),
                          fontSize: 12,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 33),

                  //  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: Color(0xff535353),
                    borderRadius: new BorderRadius.circular(20),
                  ),
                  // border: Border.all(color: Colors.grey,width: 0.5)

                  child: TextFormField(
                    style: TextStyle(color: Colors.white),

                    //  textAlign: TextAlign.start,
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: 'Address...',
                      contentPadding: const EdgeInsets.only(top: 10, left: 20),
                      border: InputBorder.none,
                      labelStyle: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 12,
                          fontStyle: FontStyle.normal),
                      hintStyle: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Color(0xff8D8989),
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffEB5757),
                      fixedSize: const Size(310, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23)),
                    ),
                    onPressed: signUpUser,
                    //  () {
                    //   print('this is name controller $_usernameController');

                    //   print('this is name controller $_emailController');

                    //   print('this is name controller $_passwordController');

                    //   print('this is name controller $_refreralController');

                    //   if (formKey.currentState!.validate()) ;

                    //   // Navigator.push(context,
                    //   //     MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                    // },
                    child: _isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Text(
                            'SignUp',
                            style: GoogleFonts.getFont('Montserrat',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 15,
                                fontStyle: FontStyle.normal),
                          ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Signinpage()));
                      },
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Color(0xffEB5757),
                            fontSize: 12,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
