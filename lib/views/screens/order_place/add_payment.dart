import 'dart:convert';
import 'dart:typed_data';

import 'package:couriercustomer/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../add_order_screen.dart';
import 'add_new_card.dart';
import 'package:http/http.dart' as http;

class Add_Payment extends StatefulWidget {
  String? brand, carrier, price, aName, address, floor, catName, category, date;
  double? lati, longi;
  Uint8List? image;

  Add_Payment({
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
  State<Add_Payment> createState() => _Add_PaymentState();
}

class _Add_PaymentState extends State<Add_Payment> {
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff404040),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/back1.png',
                    width: 45,
                    height: 46,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/edit button.png',
                        width: 45,
                        height: 46,
                      ))
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  'Payments',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffEB5757),
                    minimumSize: Size(310, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23)),
                  ),
                  onPressed: () {
                    makePayment();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (builder) => AddewCard()));
                  },
                  child: Text(
                    'Add new payment',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent(
          widget.price!, 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet

      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) async {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        // String res = await DataBaseMethods().createTransaction(
        //     brandName: widget.brand!,
        //     catgory: widget.category!,
        //     price: widget.price!,
        //     cardNum: paymentIntentData!['client_secret'].toString());
        // if(res == 'success'){Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => AddOrderScreen(
        //       aName: widget.aName,
        //       address: widget.address,
        //       brand: widget.brand,
        //       carrier: widget.carrier,
        //       floor: widget.floor,
        //       image: widget.image,
        //       price: widget.price,
        //       lati: widget.lati,
        //       longi: widget.longi,
        //     ),
        //   ),
        // );}
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddOrderScreen(
              aName: widget.aName,
              address: widget.address,
              brand: widget.brand,
              carrier: widget.carrier,
              floor: widget.floor,
              image: widget.image,
              price: widget.price,
              lati: widget.lati,
              longi: widget.longi,
            ),
          ),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(widget.price!),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KxapZBmHAwiQPYIeGYaKoAnhFCuSlvK0nwXz1WKwPWBFZtsM9AHa2qPyXgc5NbQ1kYAR7pJZpJg6a7qFxQKtQ5400E2r0jzdX',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
