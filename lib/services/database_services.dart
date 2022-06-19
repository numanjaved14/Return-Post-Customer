import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couriercustomer/models/ordermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:couriercustomer/models/usermodel.dart';
import 'package:couriercustomer/models/usermodel.dart' as model;
import 'package:couriercustomer/services/storage_methods.dart';

class DataBaseMethods {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    User currentUser = _firebaseAuth.currentUser!;

    DocumentSnapshot snap = await _firestore
        .collection('user')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();

    return UserModel.fromSnapshot(snap);
  }

  Future<String> registerUser(
      {required String email,
      required String password,
      required String username,
      String? referalCode,
      Uint8List? file,
      String? address,
      String res = "Some Error Occured"}) async {
    try {
      if (email.isNotEmpty || password.isNotEmpty || file != null) {
        UserCredential cred =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // saving profile image

        String photoUrl =
            await StorageMethods().uploadImageToStorage('ProfilePics', file!);

        UserModel user = UserModel(
          email: email,
          uid: cred.user!.uid,
          username: username,
          photoUrl: photoUrl,
          referal: referalCode,
          address: address,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJSon(),
            );
        return res = 'added successfully';
      }
    } catch (e) {
      return res = e.toString();
    }
    return res;

    // _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)
  }

  Future<String> UpdateCustomerUser({
    required String key,
    required String value,
    Uint8List? file,
  }) async {
    String res = "Some Error Occured";
    try {
      String? photoUrl;
      if (key == 'photoUrl') {
        photoUrl =
            await StorageMethods().uploadImageToStorage('ProfilePics', file!);
      }
      // if (key == 'email') {
      //   await _firebaseAuth.currentUser!.updateEmail(value);
      // }
      await _firestore
          .collection('customers')
          .doc(_firebaseAuth.currentUser!.uid)
          .update(
        {key: key == 'photoUrl' ? photoUrl : value},
      );
      return res = 'updated successfully';
    } on FirebaseException catch (e) {
      print(e.message.toString());
      return res = e.toString();
    }
    return res;
  }

  Future loginUser(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<String> resetPawwordUser({String? email}) async {
    String res = "email sent";

    try {
      _firebaseAuth.sendPasswordResetEmail(email: email!);
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  singnOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> createOrder({
    required String addressName,
    required String address,
    required String brand,
    required String carrier,
    required String floor,
    required String price,
    required Uint8List image,
    required String catName,
    required String category,
    required String date,
    required String orderId,
  }) async {
    String res = "Some Error Occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('OrderPics', image);

      OrderModel user = OrderModel(
        uid: FirebaseAuth.instance.currentUser!.uid,
        brandName: brand,
        price: price,
        orderId: orderId,
        orderDate: date,
        address: address,
        category: category,
        carrier: carrier,
        categoryName: catName,
        imageUrl: photoUrl,
        floor: floor,
      );

      await _firestore
          .collection('orders')
          .doc('ordersList')
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(orderId)
          .set(
            user.toJSon(),
          );
      return res = 'added successfully';
    } catch (e) {
      return res = e.toString();
    }
    return res;

    // _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)
  }
}
