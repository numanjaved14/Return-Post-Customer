import 'dart:typed_data';

import 'package:couriercustomer/views/screens/authentication/signinpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couriercustomer/models/usermodel.dart' as model;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // StorageMethods _storageMethods = StorageMethods();
  // Future<model.User> getUserDetails() async {
  //   User currentUser = _auth.currentUser!;

  //   DocumentSnapshot snap =
  //       await _firebaseFirestore.collection('users').doc(currentUser.uid).get();

  //   return model.User.fromSnap(snap);
  // }

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String userName,
      required String address,
      required String referal,
      required Uint8List file}) async {
    String res = 'Some error occured.';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          address.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('userProfilePics', file);

        model.UserModel user = model.UserModel(
          email: email,
          username: userName,
          uid: _auth.currentUser!.uid,
          // password: password,
          address: address,
          referal: referal,
          photoUrl: photoUrl,
        );

        _firebaseFirestore
            .collection('customers')
            .doc(_auth.currentUser!.uid)
            .set(
              user.toJSon(),
            );
        res = 'Success';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
      } else {
        res = 'Please enter all the Fields';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<String> signOutUser(BuildContext context) async {
    String res = 'Some error occured';
    try {
      await _auth.signOut();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Signinpage(),
        ),
      );
      res = 'Success';
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
