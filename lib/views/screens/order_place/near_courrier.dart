import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couriercustomer/services/database_services.dart';
import 'package:couriercustomer/views/screens/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class NearCourrier extends StatefulWidget {
  const NearCourrier({Key? key}) : super(key: key);

  @override
  State<NearCourrier> createState() => _NearCourrierState();
}

class _NearCourrierState extends State<NearCourrier> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<Map> cPosin1km = <Map>[];
  Map userLocation = {};
  bool marked = false;

  void _addMerker(String id, double lat, long) {
    // creating a new MARKER
    final Marker marker = Marker(
      markerId: MarkerId('c $id'),
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: id, snippet: '*'),
      onTap: () {
        showBotomSheet(context, int.parse(id));
      },
    );

    // setState(() {
    //   // adding a new marker to map
    //   markers[MarkerId(id)] = marker;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snap) {
            if (snap.hasData) {
              List<Map> cPos = <Map>[];

              //Create list of courier Co-ordinates
              for (int i = 0; i < snap.data!.docs.length; i++) {
                cPos.add({
                  'uid': snap.data!.docs[i].data()['id'],
                  'latitude': snap.data!.docs[i].data()['latitude'],
                  'longitude': snap.data!.docs[i].data()['longitude'],
                });
              }

              debugPrint('Courrier' + cPos.toString());

              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .doc('ordersList')
                    .collection(FirebaseAuth.instance.currentUser!.uid)
                    .orderBy('orderTime', descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    List<Map> position = <Map>[];

                    for (int i = 0; i <= snapshot.data!.docs.length - 1; i++) {
                      if (snapshot.data!.docs[i].data()['courierStatus'] ==
                          'Acceptance pending') {
                        position.add(snapshot.data!.docs[i].data());
                      }
                    }
                    debugPrint(position.toString());
                    userLocation['latitude'] = position[0]['latitude'];
                    userLocation['longitude'] = position[0]['longitude'];

                    debugPrint("C.............." + cPosin1km.toString());

                    for (int i = 0; i < cPos.length; i++) {
                      var p = 0.017453292519943295;
                      var a = 0.5 -
                          cos((cPos[i]['latitude'] - userLocation['latitude']) *
                                  p) /
                              2 +
                          cos(userLocation['latitude'] * p) *
                              cos(cPos[i]['latitude'] * p) *
                              (1 -
                                  cos((cPos[i]['longitude'] -
                                          userLocation['longitude']) *
                                      p)) /
                              2;
                      var b = 12742 * asin(sqrt(a));
                      debugPrint(b.toString());
                      if (b <= 1.0) {
                        cPosin1km.add({
                          'uid': cPos[i]['uid'],
                          'latitude': cPos[i]['latitude'],
                          'longitude': cPos[i]['longitude'],
                        });
                        // cPosin1km[i]['latitude'] = cPos[i]['latitude'];
                        // cPosin1km[i]['longitude'] = cPos[i]['longitude'];
                      }
                    }

                    debugPrint("C.............." + cPosin1km.toString());

                    for (int i = 0; i < cPosin1km.length; i++) {
                      _addMerker(i.toString(), cPosin1km[i]['latitude'],
                          cPosin1km[i]['longitude']);
                      debugPrint('Marker Added');
                      if (i == cPosin1km.length - 1) {
                        marked = true;
                      }
                    }

                    return marked
                        ? Column(
                            children: [
                              SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(userLocation['latitude'],
                                        userLocation['longitude']),
                                    zoom: 15,
                                  ),
                                  mapType: MapType.normal,
                                  compassEnabled: true,
                                  zoomControlsEnabled: false,
                                  myLocationEnabled: true,
                                  myLocationButtonEnabled: true,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                  markers: Set<Marker>.of(markers.values),
                                  zoomGesturesEnabled: true,
                                  circles: Set.from(
                                    [
                                      Circle(
                                        circleId: CircleId('1'),
                                        center: LatLng(userLocation['latitude'],
                                            userLocation['longitude']),
                                        radius: 400,
                                        fillColor: Colors.blue.withOpacity(0.3),
                                        strokeColor: Colors.blue,
                                        strokeWidth: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    showBotomSheet(context, 0);
                                  },
                                  child: Text('show'))
                            ],
                          )
                        : Center(
                            child: Text('Loading...'),
                          );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  showBotomSheet(BuildContext context, int id) {
    debugPrint('D............' + id.toString());
    debugPrint('E............' + cPosin1km[id]['uid'].toString());
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              child: Container(
                color: const Color(0xff404040),
                height: 410,
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(cPosin1km[id]['uid'].toString())
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return const Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Column(
                        children: [
                          Text("Name: ${data['username']} ${data['email']}"),
                          ElevatedButton(
                            onPressed: () async {
                              String res = await DataBaseMethods()
                                  .startNavigaion(
                                      clientId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      courierId:
                                          cPosin1km[id]['uid'].toString(),
                                      clientLongi: userLocation['longitude'],
                                      clientLati: userLocation['latitude'],
                                      courierLati: data['latitude'],
                                      courierLongi: data['longitude']);
                              if (res == 'success') {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => MyNavigationBar(),
                                ));
                              }
                            },
                            child: Text('Create'),
                          ),
                        ],
                      );
                    }

                    return const Text("loading");
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
