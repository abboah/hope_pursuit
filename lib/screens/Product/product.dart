import 'package:flutter/material.dart';
import 'package:hope_pursuit/screens/Product/product_large.dart';
import 'package:hope_pursuit/screens/Product/product_small.dart';

// ignore: must_be_immutable
class Product extends StatelessWidget {
  static const String routeName = 'product';
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth > 700) {
        return ProductLarge();
      } else {
        return ProductSmall();
      }
    }));
  }
}
