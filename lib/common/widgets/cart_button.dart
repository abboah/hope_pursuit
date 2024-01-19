import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope_pursuit/screens/cart/cart.dart';
import 'package:hope_pursuit/utils/app_colors.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, Cart.routeName, arguments: [true, true]);
      },
      backgroundColor: AppColors.blueBlack.withOpacity(0.9),
      mouseCursor: MaterialStateMouseCursor.clickable,
      elevation: 20,
      child: const Center(
        child: Icon(CupertinoIcons.shopping_cart),
      ),
    );
  }
}
