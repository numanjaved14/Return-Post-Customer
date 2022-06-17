import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couriercustomer/views/screens/addreess/add_address.dart';
import 'package:couriercustomer/views/widgets/order_history_widget.dart';
import 'package:couriercustomer/widgets/mydrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _dataRecieved = false;
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
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    var size = MediaQuery.of(context).size;
    return Scaffold(
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
        actions: [
          InkWell(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/search.png'),
            ),
          )
        ],
      ),
      key: scaffoldKey,
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
                    'My Orders',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    'Today',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.grey),
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
                            if (snapshot.data!.docs.length < 1) {
                              return  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/no_data.svg',
                                        semanticsLabel: 'No Data'),
                                    Text('No Orders',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18,)),
                                    SizedBox(height: 5,),
                                    Text('Your order history is empty',style: TextStyle(color: Color(0xff8D8989),fontWeight: FontWeight.w600,fontSize: 14,))    
                                  ],
                                
                              );
                            } 
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) =>
                                  OrderHistoryWidget(
                                snap: snapshot.data!.docs[index].data(),
                              ),
                            );
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
}
