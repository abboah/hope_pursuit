import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hope_pursuit/common/Widgets/item_widget.dart';
import 'package:hope_pursuit/common/widgets/appbar.dart';
import 'package:hope_pursuit/screens/Product/product.dart';
import 'package:hope_pursuit/utils/app_colors.dart';
import 'package:hope_pursuit/utils/font_styles.dart';

class Favorite extends StatefulWidget {
  static const String routeName = 'filter';
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      appBar: const CustomAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0.w, right: 20.0.w, bottom: 50.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItemAndSortTile(context),
          _buildFavoriteItems(context),
        ],
      ),
    );
  }

  Widget _buildItemAndSortTile(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          '5 Items',
          style: FontStyles.montserratBold19(),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort by:',
              style: FontStyles.montserratBold12()
                  .copyWith(color: AppColors.textLightColor),
            ),
            Text(
              'Price:Lowest to high',
              style: FontStyles.montserratBold12()
                  .copyWith(color: AppColors.primaryDark),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.primaryDark,
            )
          ],
        ));
  }

  Widget _buildFavoriteItems(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 3,
        physics: const ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 260.0.w,
            crossAxisSpacing: 10.0.h),
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Product.routeName, arguments: index);
            },
            child: ItemWidget(
              index: index,
              favoriteIcon: true,
            ),
          );
        },
      ),
    );
  }
}
