import 'dart:convert';

class ProductModel {
  static final shopModel = ProductModel._internal();

  ProductModel._internal();

  factory ProductModel() => shopModel;

  static List<Product> products = [];

}

class Product {
  final int id;
  final String name;
  final String desc;
  final int price;
  final String image;
  Product({required this.id, required this.name, required this.desc, required this.price, required this.image});

  String toJson() => json.encode((toMap()));
  factory Product.fromJson(String src) => Product.fromMap(jsonDecode(src));

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'desc': this.desc,
      'price': this.price,
      'image': this.image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      desc: map['desc'] as String,
      price: map['price'] as int,
      image: map['image'] as String,
    );
  }

  Product copyWith({
    int? id,
    String? name,
    String? desc,
    int? price,
    String? image,
  }) {
    return Product(
        id: id ?? this.id,
        name: name ?? this.name,
        desc: desc ?? this.desc,
        price:  price ?? this.price,
        image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, desc: $desc, price: $price, image: $image}';
  }
}