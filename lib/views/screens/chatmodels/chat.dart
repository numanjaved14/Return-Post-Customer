import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:couriercustomer/views/screens/chatmodels/chatpage.dart';
import '/utils/constants.dart';

class Chat extends StatefulWidget {
  Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff404040),
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text(
      //     'Your Messages',
      //     style: TextStyle(color: Colors.black),
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: const Text(
                  'Your Messages',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Colors.white),
                ),
                // child: TextField(
                //   decoration: InputDecoration(
                //     hintText: "Search...",
                //     hintStyle: TextStyle(color: Colors.grey.shade600),
                //     prefixIcon: Icon(
                //       Icons.search,
                //       color: Colors.grey.shade600,
                //       size: 20,
                //     ),
                //     filled: true,
                //     // fillColor: Colors.grey.shade100,
                //     contentPadding: EdgeInsets.all(8),
                //     enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(20),
                //         borderSide: BorderSide(color: Colors.grey.shade100)),
                //   ),
                // ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Color(0xff404040)),
                child: StreamBuilder(
                    stream: firebaseFirestore
                        .collection("users")
                        .where("id",
                            isNotEqualTo: firebaseAuth.currentUser!.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var ds = snapshot.data!.docs[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          this.context,
                                          MaterialPageRoute(
                                            builder: (builder) => ChatPage(
                                              receiverName: ds.get("username"),
                                              receiverId: ds.id,
                                              // receiverimageLink:
                                              //     ds.get("imageLink"),
                                            ),
                                          ),
                                        );
                                        // Navigator.pushNamed(this.context, MaterialPageRoute(builder: (builder) => ChatPage()));
                                      },
                                      leading: CircleAvatar(
                                          radius: 30,
                                          backgroundImage:
                                              NetworkImage(ds.get("photoUrl"))),
                                      title: Text(
                                        ds.get("username"),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.white),
                                      ),
                                      // trailing: Text('2 hrs ago'),
                                    ),
                                    Divider()
                                  ],
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Icon(Icons.error_outline);
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
