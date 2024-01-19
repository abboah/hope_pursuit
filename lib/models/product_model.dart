import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String name;
  String imageUrl;
  String price;
  final String uploadTime;
  String category;

  ProductModel(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.uploadTime,
      required this.category});

  // Create a factory constructor to convert Firestore data to a ProductModel
  factory ProductModel.fromFirestore(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: data['price']?.toString() ?? '0.0',
      uploadTime: data['uploadTime'] ?? Timestamp.now().toString(),
      category: data['category'] ?? '',
    );
  }
}

class Category {
  final String name;
  final List<ProductModel> products;
  final String imageUrl;

  Category({
    required this.name,
    required this.products,
    required this.imageUrl,
  });
}
