import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couriercustomer/services/authmethods.dart';
import 'package:couriercustomer/views/screens/authentication/signinpage.dart';
import 'package:couriercustomer/views/screens/profile_edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isLoading = false;
  var userData;

  // DocumentSnapshot? snapshot;
  // @override
  // void initState() {
  //   super.initState();
  //   getUserData();
  // }

  // getUserData() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //   setState(() {
  //     snapshot = snap;
  //   });
  // }
  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // UserModel user = Provider.of<UserProvider>(context).getUser;

    return _isLoading
        ? const Center(child: CircularProgressIndicator.adaptive())
        : Drawer(
            backgroundColor: Color(0xff404040),
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xff404040),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 24),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          child: Image.asset(
                            // user.photoUrl!,
                            ("assets/pic.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          // user.username!,
                          userData['username'].toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, bottom: 30, top: 20),
                    child: Text(
                      'General',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )),
                ListTile(
                  leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/options.png'),
                      )),
                  title: const Text(
                    'Profile Settings',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const ProfileEdit(),
                      ),
                    );
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/credit-card.png'),
                      )),
                  title: const Text(
                    'Payments',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (builder) => ProfileSettings(
                    //               username: (snapshot!.data()
                    //                   as Map<String, dynamic>)['username'],
                    //               email: (snapshot!.data()
                    //                   as Map<String, dynamic>)['email'],
                    //               address: (snapshot!.data()
                    //                   as Map<String, dynamic>)['address'],
                    //               photoUrl: (snapshot!.data()
                    //                   as Map<String, dynamic>)['photoUrl'],
                    //             )));
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/chart-square-bar.png'),
                      )),
                  title: const Text(
                    'Transaction History',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (builder) => ProfileSettings(
                    //               username: (snapshot!.data()
                    //                   as Map<String, dynamic>)['username'],
                    //               email: (snapshot!.data()
                    //                   as Map<String, dynamic>)['email'],
                    //               address: (snapshot!.data()
                    //                   as Map<String, dynamic>)['address'],
                    //               photoUrl: (snapshot!.data()
                    //                   as Map<String, dynamic>)['photoUrl'],
                    //             )));
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/cog.png'),
                      )),
                  title: const Text(
                    'Settings',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (builder) => ProfileSettings(
                    //               username: (snapshot!.data()
                    //                   as Map<String, dynamic>)['username'],
                    //               email: (snapshot!.data()
                    //                   as Map<String, dynamic>)['email'],
                    //               address: (snapshot!.data()
                    //                   as Map<String, dynamic>)['address'],
                    //               photoUrl: (snapshot!.data()
                    //                   as Map<String, dynamic>)['photoUrl'],
                    //             )));
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/user-group.png'),
                      )),
                  title: const Text(
                    'Support',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (builder) => ProfileSettings(
                    //               username: (snapshot!.data()
                    //                   as Map<String, dynamic>)['username'],
                    //               email: (snapshot!.data()
                    //                   as Map<String, dynamic>)['email'],
                    //               address: (snapshot!.data()
                    //                   as Map<String, dynamic>)['address'],
                    //               photoUrl: (snapshot!.data()
                    //                   as Map<String, dynamic>)['photoUrl'],
                    //             )));
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/users.png'),
                      )),
                  title: const Text(
                    'Refer a friend and earn',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (builder) => ProfileSettings(
                    //               username: (snapshot!.data()
                    //                   as Map<String, dynamic>)['username'],
                    //               email: (snapshot!.data()
                    //                   as Map<String, dynamic>)['email'],
                    //               address: (snapshot!.data()
                    //                   as Map<String, dynamic>)['address'],
                    //               photoUrl: (snapshot!.data()
                    //                   as Map<String, dynamic>)['photoUrl'],
                    //             )));
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/download.png'),
                      )),
                  title: InkWell(
                    onTap: () => AuthMethods().signOutUser(context),
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
  }

  void getData() async {
    userData = await FirebaseFirestore.instance
        .collection('customers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      _isLoading = false;
    });
  }
}
