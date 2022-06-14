import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
    final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff404040),

       appBar:AppBar(
        elevation: 0,
        backgroundColor: Color(0xff404040),
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
      body: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
           Container(
            margin: EdgeInsets.only(left: 10,top: 15),
            child: Text('Add your address',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w600),)),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/maps.png'),
            ),
               Container(
            margin: EdgeInsets.only(left: 10,top: 15),
            child: Text('Details',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w600),)),

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
                              Container(
                      margin: EdgeInsets.only(left: 30,top: 15),
                      child: Text(
                        'Floor number, apartments',
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

                      Container(
              margin: EdgeInsets.only(bottom: 20,top: 20),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffEB5757),
                    minimumSize: Size(210, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () async {
                    
                    
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