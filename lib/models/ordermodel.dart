import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? brandName;
  final String? price;
  final String? uid;
  final String? category;
  final String? categoryName;
  final String? arrivalTime;
  final String? address;
  final String? orderId;
  final String? courierStatus;
  final String? floor;
  final String? orderDate;
  final String? carrier;
  final String? imageUrl;
  final double? lati;
  final double? longi;

  OrderModel({
    required this.price,
    required this.uid,
    required this.brandName,
    required this.category,
    required this.address,
    required this.floor,
    required this.orderId,
    required this.orderDate,
    required this.carrier,
    required this.imageUrl,
    required this.categoryName,
    required this.lati,
    required this.longi,
    this.courierStatus,
    this.arrivalTime,
  });

  Map<String, dynamic> toJSon() => {
        "brandName": brandName,
        "price": price,
        'id': uid,
        'category': category,
        'arrivalTime': arrivalTime,
        'address': address,
        'courierStatus': courierStatus,
        'floor': floor,
        'orderId': orderId,
        'orderTime': orderDate,
        'carrier': carrier,
        'imageUrl': imageUrl,
        'categoryName': categoryName,
        'latitude': lati,
        'longitude': longi,
      };

  // static OrderModel fromSnapshot(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //   return OrderModel(
  //     price: 'price',
  //     uid: 'id',
  //     brandName: 'brandName',
  //     category: 'category',
  //     arrivalTime: 'arrivalTime',
  //     address: 'address',
  //   );
  // }
}
