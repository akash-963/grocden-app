import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrder {
  final String shop;
  final String buyer;
  final double totalValue;
  final Timestamp createdTimestamp;
  Timestamp? deliveredTimestamp;
  Timestamp? cancelledTimestamp;
  String? tag;
  String? status;
  List<ProductOrderDetails> products;

  MyOrder({
    required this.shop,
    required this.buyer,
    required this.totalValue,
    required this.createdTimestamp,
    required this.products,
    this.deliveredTimestamp,
    this.cancelledTimestamp,
    this.tag,
    this.status,
  });




  // Factory method to create MyOrder instance from DocumentSnapshot
  factory MyOrder.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    // Convert Timestamps to DateTime if needed
    Timestamp createdTimestamp = (data['createdTimestamp']).toDate();
    Timestamp? deliveredTimestamp = data['deliveredTimestamp'] != null
        ? (data['deliveredTimestamp']).toDate()
        : null;
    Timestamp? cancelledTimestamp = data['cancelledTimestamp'] != null
        ? (data['cancelledTimestamp']).toDate()
        : null;

    // Map products data to List<ProductOrderDetails>
    List<ProductOrderDetails> products = (data['products'] as List<dynamic>)
        .map((productData) => ProductOrderDetails.fromMap(productData))
        .toList();

    return MyOrder(
      shop: data['shop'],
      buyer: data['buyer'],
      totalValue: data['totalValue'],
      createdTimestamp: createdTimestamp,
      deliveredTimestamp: deliveredTimestamp,
      cancelledTimestamp: cancelledTimestamp,
      tag: data['tag'],
      status: data['status'],
      products: products,
    );
  }
}

class ProductOrderDetails {
  final String productName;
  final num quantity;
  final num price;

  final String productId;

  ProductOrderDetails({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });


  // Factory method to create ProductOrderDetails instance from Map
  factory ProductOrderDetails.fromMap(Map<String, dynamic> map) {
    return ProductOrderDetails(
      productId: map['productId'],
      productName: map['productName'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }
}
