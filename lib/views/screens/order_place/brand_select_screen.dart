import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';

class BrandSelectScreen extends StatefulWidget {
  const BrandSelectScreen({Key? key}) : super(key: key);

  @override
  State<BrandSelectScreen> createState() => _BrandSelectScreenState();
}

class _BrandSelectScreenState extends State<BrandSelectScreen> {
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
      backgroundColor: const Color(0xff404040),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book return',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.white),
            ),
            Text(
              'Choose retailer ',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
            ),
            Text(
              'Store',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: StreamBuilder(
                  stream: null,
                  builder: (context, snapshot) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(child: Text('amazon')),
                        ),
                      ),
                    );
                  }),
            ),
            Text(
              'Upload Image',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.3,
              child: InkWell(
                onTap: _selectImage,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: _image == null
                        ? Center(child: Icon(Icons.add))
                        : Image.memory(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffEB5757),
                  fixedSize: const Size(202, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23)),
                ),
                onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
