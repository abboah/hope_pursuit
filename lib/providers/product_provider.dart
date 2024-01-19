import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hope_pursuit/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Category> categories = [];
  List<ProductModel> latestProducts = [];

  Future<void> fetchLatestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> productsSnapshot =
          await FirebaseFirestore.instance
              .collectionGroup('products')
              .orderBy('uploadTime', descending: true)
              .limit(4)
              .get();

      latestProducts = productsSnapshot.docs
          .map((productsSnapshot) =>
              ProductModel.fromFirestore(productsSnapshot.data()))
          .toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching latest products: $e');
      rethrow;
    }
  }

  Future<void> fetchProductsData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> categoriesSnapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      List<Category> fetchedCategories = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> categorySnapshot
          in categoriesSnapshot.docs) {
        String categoryName = categorySnapshot.id;

        QuerySnapshot<Map<String, dynamic>> productsSnapshot =
            await categorySnapshot.reference.collection('products').get();

        List<ProductModel> products = productsSnapshot.docs
            .map((productSnapshot) =>
                ProductModel.fromFirestore(productSnapshot.data()))
            .toList();

        String categoryImage = categorySnapshot['imageUrl'];

        fetchedCategories.add(Category(
            name: categoryName, products: products, imageUrl: categoryImage));

        print('Products for category $categoryName fetched successfully.');
      }

      categories = fetchedCategories;
      notifyListeners();
    } catch (e) {
      print('Error fetching products data: $e');
    }
    notifyListeners();
  }
}
