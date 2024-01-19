import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hope_pursuit/common/Widgets/app_button.dart';
import 'package:hope_pursuit/common/Widgets/cart_tile.dart';
import 'package:hope_pursuit/common/Widgets/appbar.dart';
import 'package:hope_pursuit/screens/checkout/check_out.dart';
import 'package:hope_pursuit/utils/app_colors.dart';
import 'package:hope_pursuit/utils/font_styles.dart';

class Cart extends StatefulWidget {
  static const String routeName = 'cart';
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int? carttile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      appBar: const CustomAppBar(),
      body: _buildBody(context),
      bottomSheet: _buildBottomSheet(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: ListView.separated(
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            color: AppColors.white,
            margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
            child: CartTile(
              defaultValue: 1,
              onChangeValue: (v) {
                setState(() {
                  carttile = v;
                });
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0.r),
          topRight: Radius.circular(20.0.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total price', style: FontStyles.montserratBold19()),
                Text('\$239.98', style: FontStyles.montserratBold19()),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0.h),
            child: AppButton.button(
              text: 'Check Out',
              color: AppColors.blueBlack,
              height: 48.h,
              width: size.width - 20.w,
              style: const TextStyle(color: AppColors.white),
              onTap: () {
                Navigator.pushNamed(context, CheckOut.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
