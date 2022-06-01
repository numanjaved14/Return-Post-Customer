import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? brandName;
  final String? price;
  final String? uid;
  final String? category;
  final String? arrivalTime;
  final String? address;
  final String? orderId;
  final String? courierStatus;
  final String? floor;
  final String? orderTime;

  OrderModel({
    required this.price,
    required this.uid,
    required this.brandName,
    this.category,
    this.arrivalTime,
    required this.address,
    this.courierStatus,
    this.floor,
    required this.orderId,
    required this.orderTime,
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
        'orderTime': orderTime,
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
