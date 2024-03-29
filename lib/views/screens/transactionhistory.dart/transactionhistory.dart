import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couriercustomer/services/geo_locator.dart';
import 'package:couriercustomer/views/screens/addreess/add_address.dart';
import 'package:couriercustomer/views/widgets/order_history_widget.dart';
import 'package:couriercustomer/widgets/mydrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  bool _dataRecieved = false;
  bool _userdataRecieved = false;
  String _address = 'Address';
  var userData;
  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  getData() async {
    var data = await FirebaseFirestore.instance
        .collection('orders')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('ordersList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print("Initail data fetching " + data.toString());
  }

  @override
  void initState() {
    getAddress();
    getUserData();
    // TODO: implement initState
    super.initState();
  }

  void getAddress() async {
    await getLocation()
        .getCurrentLocation(true)
        .then((value) => _address = value);
    setState(() {
      _address;
    });
    // _addressController.text = _address.toString();
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          _address,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff404040),
        leading:  Container(
                  margin: EdgeInsets.only(left: 20,bottom: 10),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/backbutton.png',width: 49,height: 49,))),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child:Image.asset('assets/search.png'),
                  
              // child: Image.asset('assets/pic.png'),
            ),
          
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            color: const Color(0xff404040),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transactions History',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: size.height * 0.78,
                    width: double.infinity,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('orders')
                            .doc('ordersList')
                            .collection(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data!.docs.toString());
                            if (snapshot.data!.docs.length < 1) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/no_data.svg',
                                      semanticsLabel: 'No Data'),
                                  Text('No Orders',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Your order history is empty',
                                      style: TextStyle(
                                        color: Color(0xff8D8989),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ))
                                ],
                              );
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) =>
                                    OrderHistoryWidget(
                                  snap: snapshot.data!.docs[index].data(),
                                ),
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getUserData() async {
    setState(() {
      _userdataRecieved = false;
    });
    userData = await FirebaseFirestore.instance
        .collection('customers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      _userdataRecieved = true;
      userData;
    });
  }
}
