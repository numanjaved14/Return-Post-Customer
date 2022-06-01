import 'package:couriercustomer/views/screens/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:couriercustomer/views/screens/authentication/signuppage.dart';
import 'package:couriercustomer/views/screens/authentication/forgotpassword/forgotpassword.dart';
// import 'package:couriercustomer/mainscreen/mainscreen.dart';
import 'package:couriercustomer/services/database_services.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({Key? key}) : super(key: key);

  @override
  _SigninpageState createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  bool formStateLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff404040),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 237,
                    height: 88,
                    margin: EdgeInsets.only(left: 30, right: 30, top: 28),
                    child: Text(
                      'Welcome\nback',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 36,
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
                        controller: _emailController,
                        //  textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintText: ' email...',
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
                      height: 60,
                      margin:
                          const EdgeInsets.only(left: 30, right: 30, top: 28),

                      //  padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: Color(0xff535353),
                        borderRadius: new BorderRadius.circular(20),
                      ),
                      // border: Border.all(color: Colors.grey,width: 0.5)

                      child: TextFormField(
                        controller: _passwordController,
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "Please Enter password field";
                          }
                        },
                        obscureText: true,
                        //  textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                              padding: EdgeInsets.only(top: 13, right: 20),
                              child: Icon(
                                Icons.visibility_off,
                                color: Color.fromARGB(255, 77, 21, 21),
                              )),
                          hintText: 'Password',
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
                    margin: EdgeInsets.only(left: 30),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (xxx) => ForgotPassword()));
                      },
                      child: Text('Forgot your password?',
                          style: GoogleFonts.getFont('Montserrat',
                              fontWeight: FontWeight.w600,
                              color: Color(0xff8D8989),
                              fontSize: 12,
                              fontStyle: FontStyle.normal)),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffEB5757),
                  minimumSize: Size(310, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                  }
                  await DataBaseMethods()
                      .loginUser(
                        _emailController.text,
                        _passwordController.text,
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
                child: _isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Text(
                        'Sign In',
                        style: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 15,
                            fontStyle: FontStyle.normal),
                      ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const SignUpPage()));
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.getFont('Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Color(0xffEB5757),
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
