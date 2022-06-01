import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? username;
  final String? email;
  final String? uid;
  final String? referal;
  final String? photoUrl;
  final String? address;

  UserModel({
    required this.email,
    required this.uid,
    required this.username,
    this.referal,
    this.photoUrl,
    required this.address,
  });

  Map<String, dynamic> toJSon() => {
        "username": username,
        "email": email,
        'id': uid,
        'referal': referal,
        'photoUrl': photoUrl,
        'address': address,
      };

  static UserModel fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: 'email',
      uid: 'id',
      username: 'username',
      referal: 'referal',
      photoUrl: 'photoUrl',
      address: 'address',
    );
  }
}
