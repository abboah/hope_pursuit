import 'package:flutter/material.dart';
import 'package:hope_pursuit/models/product_model.dart';
import 'package:hope_pursuit/screens/Product/product_large.dart';
import 'package:hope_pursuit/screens/Product/product_small.dart';

// ignore: must_be_immutable
class Product extends StatelessWidget {
  static const String routeName = 'product';
  ProductModel product;

  Product({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth > 700) {
        return ProductLarge(
          product: product,
        );
      } else {
        return ProductSmall(
          product: product,
        );
      }
    }));
  }
}
