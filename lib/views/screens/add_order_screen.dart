import 'package:couriercustomer/services/geo_locator.dart';
import 'package:couriercustomer/views/screens/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/database_services.dart';

class AddOrderScreen extends StatefulWidget {
  String brand;
  AddOrderScreen({Key? key, required this.brand}) : super(key: key);

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  bool formStateLoading = false;
  @override
  void initState() {
    super.initState();
    getLocation().getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:  Color(0xff404040),
        leading: InkWell(
          onTap: (){
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
                          border: Border.all(
                            color: Colors.grey
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/back.png'),
                        )
                      ),
          ),
        ),
      ),
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
                children: [
                  Container(
                   
                    margin: EdgeInsets.only(left: 30,top: 20),
                    child: Text(
                      'Create order',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 28,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  Container(
                    width: 237,
                    height: 30,
                    margin: EdgeInsets.only(left: 30, top: 28),
                    child: Text(
                      'Details',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                    Container(
                      margin: EdgeInsets.only(left: 30,top: 25),
                      child: Text(
                        'Name',
                        style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color:Color(0xff8D8989))
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
                        controller: _nameController,
                        //  textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintText: ' Hoodie, T-shirt',
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
                      margin: EdgeInsets.only(left: 30,top: 15),
                      child: Text(
                        'Categories',
                        style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color:Color(0xff8D8989))
                      ),
                    ),
                  Container(
                      height: 55,
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),

                      //  padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: Color(0xff535353),
                        borderRadius: new BorderRadius.circular(20),
                      ),
                      // border: Border.all(color: Colors.grey,width: 0.5)

                      child: TextFormField(
                        
                        controller: _categoryController,
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "Please Enter field";
                          }
                        },
                        obscureText: false,
                        //  textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          suffixIcon:Padding(
                            padding: EdgeInsets.only(top: 13, right: 10),
                            child: Icon(Icons.arrow_forward_ios,color: Color(0xff8D8989),),
                          ),
                          // suffixIcon: Padding(
                          //     padding: EdgeInsets.only(top: 13, right: 20),
                          //     child: Icon(
                          //       Icons.visibility_off,
                          //       color: Color.fromARGB(255, 77, 21, 21),
                          //     )),
                          hintText: ' Choose categories',
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
                      margin: EdgeInsets.only(left: 30,top: 15),
                      child: Text(
                        'Date',
                        style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color:Color(0xff8D8989))
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
                        
                        controller: _dateController,
                        //  textAlign: TextAlign.start,
                        decoration: InputDecoration(
                         
                          hintText: ' 02.04.2021',
                          contentPadding: const EdgeInsets.only(
                            top:15,
                            left: 20,
                          ),
                           suffixIcon:Padding(
                            padding: EdgeInsets.only(top: 13, right: 10),
                            child: Icon(Icons.date_range,color: Color(0xff8D8989),),
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
                      margin: EdgeInsets.only(left: 30,top: 15),
                      child: Text(
                        'Address',
                        style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color:Color(0xff8D8989))
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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffEB5757),
                    minimumSize: Size(210, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                    }
                    await DataBaseMethods()
                        .createOrder(
                          address: _addressController.text,
                          brandName: widget.brand,
                          category: _categoryController.text,
                          price: '\$12',
                          orderTime: DateTime.now().toString(),
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
                  child: _isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : Text(
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
        ),
      ),
    );
  }
}
