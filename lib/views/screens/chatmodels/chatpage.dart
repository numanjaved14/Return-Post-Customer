import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couriercustomer/views/screens/chatmodels/chatmodels.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:couriercustomer/views/screens/chatmodels/chatpage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '/utils/constants.dart';
import '/utils/customdialog.dart';

class ChatPage extends StatefulWidget {
  String receiverId;
  // String receiverimageLink;
  String receiverName;
  ChatPage({
    Key? key,
    required this.receiverName,
    // required this.receiverimageLink,
    required this.receiverId,
  }) : super(key: key);
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String groupChatId = "";
  ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  File? imageUrl;
  TextEditingController messageController = TextEditingController();
  String? imageLink;
  void addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
    Customdialog.showDialogBox(context);
    await uploadImageToFirebase().then((value) {
      var documentReference = firebaseFirestore
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());
      firebaseFirestore.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            "senderId": firebaseAuth.currentUser!.uid,
            "receiverId": widget.receiverId,
            // "content": messageController.text,
            "time": DateTime.now(),
            'image': imageLink,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            // 'content': content,
            'type': 1
          },
        );
      });
    }).then((value) {
      Customdialog.closeDialog(context);
      FocusScope.of(context).unfocus();
      messageController.clear();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (firebaseAuth.currentUser!.uid.hashCode <= widget.receiverId.hashCode) {
      groupChatId = "${firebaseAuth.currentUser!.uid}-${widget.receiverId}";
    } else {
      groupChatId = "${widget.receiverId}-${firebaseAuth.currentUser!.uid}";
    }
    // firebaseFirestore.collection("users").doc(widget.receiverId).get().then((value) {
    //   setState(() {
    //     receiverimageLink= value.get("imageLink");
    //     receiverName=value.get("UserName");
    //   });
    // });
    var a = firebaseFirestore.collection("collectionPath");
    firebaseFirestore
        .collection("users")
        .doc(widget.receiverId)
        .get()
        .then((value) {
      setState(() {
        myStatus = value.get("status");
        // receiverName=value.get("UserName");
      });
    });
    super.initState();
  }

  String myStatus = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff404040),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              color: Color(0xff404040),
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    // backgroundImage: NetworkImage(widget.receiverimageLink),
                    maxRadius: 20,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.receiverName,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          myStatus,
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              StreamBuilder(
                  stream: firebaseFirestore
                      .collection("messages")
                      .doc(groupChatId)
                      .collection(groupChatId)
                      .orderBy("timestamp", descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.docs == 0
                          ? Center(child: Text("Empty "))
                          : ListView.builder(
                              controller: scrollController,
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var ds = snapshot.data!.docs[index];
                                return ds.get("type") == 0
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            left: 14,
                                            right: 14,
                                            top: 10,
                                            bottom: 10),
                                        child: Align(
                                          alignment: (ds.get("senderId") ==
                                                  firebaseAuth.currentUser!.uid
                                              ? Alignment.bottomRight
                                              : Alignment.bottomLeft),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: (ds.get("senderId") ==
                                                      firebaseAuth
                                                          .currentUser!.uid
                                                  ? Colors.grey.shade200
                                                  : Colors.blue[200]),
                                            ),
                                            padding: EdgeInsets.all(16),
                                            child: Text(
                                              ds.get("content"),
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      )
                                    : ds.get("type") == 1
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                left: 14,
                                                right: 14,
                                                top: 10,
                                                bottom: 10),
                                            child: Align(
                                              alignment: (ds.get("senderId") ==
                                                      firebaseAuth
                                                          .currentUser!.uid
                                                  ? Alignment.bottomRight
                                                  : Alignment.bottomLeft),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        ds.get("image"),
                                                      ),
                                                      fit: BoxFit.fill),
                                                  // color: (ds.get("senderId") == firebaseAuth.currentUser!.uid?Colors.grey.shade200:Colors.blue[200]),
                                                ),
                                                // padding: EdgeInsets.all(16),
                                              ),
                                            ),
                                          )
                                        : Container();
                              },
                            );
                    } else if (snapshot.hasError) {
                      return Center(child: Icon(Icons.error_outline));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: addImage,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          sendMessage(messageController.text.trim(), 0);
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: Colors.red,
                        elevation: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void sendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      messageController.clear();

      var documentReference = firebaseFirestore
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      firebaseFirestore.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            "senderId": firebaseAuth.currentUser!.uid,
            "receiverId": widget.receiverId,
            "time": DateTime.now(),
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      // Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  Future uploadImageToFirebase() async {
    File? fileName = imageUrl;
    var uuid = Uuid();
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('messages/images+${uuid.v4()}');
    firebase_storage.UploadTask uploadTask =
        firebaseStorageRef.putFile(fileName!);
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() async {
      print(fileName);
      String img = await uploadTask.snapshot.ref.getDownloadURL();
      setState(() {
        imageLink = img;
      });
    });
  }
}
