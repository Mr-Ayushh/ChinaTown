import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_1/models/product_model.dart';

class Orders {
  final String id;
  final String userId;
  final List<CartProduct> products;
  final String address;
  final double totalAmount;
  final String status;

  Orders({
    required this.id,
    required this.userId,
    required this.products,
    required this.address,
    required this.totalAmount,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'products': products.map((product) => product.toJson()).toList(),
      'address': address,
      'totalAmount': totalAmount,
      'status': status,
    };
  }

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      id: '',
      userId: json['userId'],
      products: List<CartProduct>.from(json['products']
          .map((productJson) => CartProduct.fromJson(productJson))),
      address: json['address'],
      totalAmount: json['totalAmount'],
      status: json['status'],
    );
  }

  factory Orders.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Orders(
      id: doc.id,
      userId: data['userId'],
      products: List<CartProduct>.from(
          data['products'].map((product) => CartProduct.fromJson(product))),
      address: data['address'],
      totalAmount: data['totalAmount'],
      status: data['status'],
    );
  }
}
