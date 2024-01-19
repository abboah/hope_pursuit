import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hope_pursuit/common/Widgets/appbar.dart';
import 'package:hope_pursuit/common/Widgets/item_widget.dart';
import 'package:hope_pursuit/utils/app_colors.dart';
import 'package:hope_pursuit/utils/font_styles.dart';

class Orders extends StatefulWidget {
  static const String routeName = 'orders';
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      appBar: const CustomAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _buildOrdersCard();
          }),
    );
  }

  Widget _buildOrdersCard() {
    return Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: AppColors.lightGray),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID# 236666',
              style: FontStyles.montserratBold17().copyWith(fontSize: 22.0),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price \$300',
                  style: FontStyles.montserratBold17().copyWith(fontSize: 14.0),
                ),
                const Text('Date 12/8/2021'),
              ],
            ),
            const SizedBox(height: 10.0),
            _buildOrderItemsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemsList(BuildContext context) {
    return SizedBox(
      height: 255.h,
      child: ListView.builder(
          itemCount: 5,
          itemExtent: 190.0,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: ItemWidget(
                index: index,
                favoriteIcon: false,
              ),
            );
          }),
    );
  }
}
