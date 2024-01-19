import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hope_pursuit/common/Widgets/app_button.dart';
import 'package:hope_pursuit/common/Widgets/item_widget.dart';
import 'package:hope_pursuit/common/Widgets/shimmer_effect.dart';
import 'package:hope_pursuit/common/widgets/appbar.dart';
import 'package:hope_pursuit/common/widgets/cart_button.dart';
import 'package:hope_pursuit/common/widgets/toggle_text_buttons.dart';
import 'package:hope_pursuit/dummy/dummy_data.dart';
import 'package:hope_pursuit/models/product_model.dart';
import 'package:hope_pursuit/screens/cart/cart.dart';
import 'package:hope_pursuit/utils/app_colors.dart';

// ignore: must_be_immutable
class ProductLarge extends StatelessWidget {
  ProductLarge({Key? key}) : super(key: key);
  int index = 0;
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final ProductModel product =
          ModalRoute.of(context)!.settings.arguments as ProductModel;
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(),
      body: _buildBody(context, index),
      floatingActionButton: const CartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      extendBody: true,
    );
  }
}

Widget _buildBody(BuildContext context, index) {
  var screenHeight = MediaQuery.of(context).size.height / 1.1;
  var screenWidth = MediaQuery.of(context).size.width;
  return Row(
    children: [
      Expanded(
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: DummyData.featured[index],
              // color: const Color.fromRGBO(42, 3, 75, 0.35),
              // colorBlendMode: BlendMode.srcOver,
              fit: BoxFit.fitHeight, height: screenHeight, width: screenWidth,
              placeholder: (context, name) {
                return ShimmerEffect(
                  borderRadius: 0.0.r,
                  height: screenHeight,
                  width: screenWidth,
                );
              },
              errorWidget: (context, error, child) {
                return ShimmerEffect(
                  borderRadius: 0.0.r,
                  height: screenHeight,
                  width: screenWidth,
                );
              },
            ),
            Positioned(
              bottom: 10,
              child: _buildBottomSheet(
                  context: context,
                  onTap: () {
                    Navigator.pushNamed(context, Cart.routeName,
                        arguments: index);
                  }),
            )
          ],
        ),
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAboutProduct(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildColorAndSizeSelection(context),
                    SizedBox(height: 10.0.h),
                    _buildProductDetail(context),
                    SizedBox(height: 10.0.h),
                    _buildReviews(context),
                    SizedBox(height: 10.0.h),
                    _buildRelatedProduct(context)
                  ],
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}

Widget _buildAboutProduct(BuildContext context) {
  return Container(
    color: AppColors.white,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRatings(context),
              const Text('In Stock',
                  style: TextStyle(color: AppColors.green, fontSize: 15)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: const Text(
            'Astylish Women Open Front Long Sleeve Chunky Knit Cardigan',
            style: TextStyle(fontSize: 18),
          ),
        ),
        _buildPrice(context, '\$89.99'),
      ],
    ),
  );
}

Widget _buildRatings(BuildContext context) {
  return SizedBox(
    height: 20.0.h,
    child: Row(
      children: [
        ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const Icon(
                Icons.star,
                color: AppColors.secondary,
                size: 14.0,
              );
            }),
        const Text(
          ' 8 reviews',
          style: TextStyle(fontSize: 15),
        ),
      ],
    ),
  );
}

Widget _buildColorAndSizeSelection(BuildContext context) {
  return Container(
    color: AppColors.white,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.h, vertical: 20.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildColorSelection(context),
          SizedBox(height: 20.0.h),
          _buildSizes(context),
        ],
      ),
    ),
  );
}

Widget _buildPrice(BuildContext context, String price) {
  return Padding(
    padding: EdgeInsets.only(left: 20.0.w, top: 10.0.h),
    child: Text(
      price,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _buildColorSelection(BuildContext context) {
  List<String> colors = [
    'assets/product/pic1.png',
    'assets/product/pic2.png',
    'assets/product/pic3.png',
    'assets/product/pic4.png',
    'assets/product/pic5.png',
    'assets/product/pic6.png',
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      const Text(
        'Colors',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 20.0.h),
      Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 47.0.h,
          child: ListView.separated(
            itemCount: colors.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 8);
            },
            itemBuilder: (context, index) {
              return Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(colors[index])),
                    borderRadius: BorderRadius.circular(10.0.r)),
              );
            },
          ),
        ),
      ),
    ],
  );
}

Widget _buildSizes(BuildContext context) {
  return ToggleTextBtnsFb1(
    texts: const [
      Text("S"),
      Text("M"),
      Text("L"),
      Text("XL"),
      Text("XXL"),
    ],
    selected: (i) => print(i),
  );
}

Widget _buildProductDetail(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10.0.r),
    ),
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Detail',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0.h),
        const Text(
          'Women\'s Casual V-Neck Pullover Sweater Long Sleeved Sweater Top with High Low Hemline is going to be the newest staple in your wardrobe! Living up to its namesake, this sweater is unbelievably soft, li...',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ],
    ),
  );
}

Widget _buildReviews(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.white, borderRadius: BorderRadius.circular(10.0.r)),
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Reviews',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF34283E)),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, Catalogue.routeName);
              },
              child: const Text(
                'See All',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9B9B9B)),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0.h),
        const Text(
          'Olha Chabanova',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0.h),
        _buildReviewRatings(context),
        SizedBox(height: 10.0.h),
        const Text(
          'I’m old (rolling through my 50’s). But, this is my daughter in law’s favorite color right now.❤️ So I wear it whenever we hang out! She’s my fashion consultant who keeps me on trend🤣',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 10.0.h),
        const Text(
          '835 people found this helpful',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Comment',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            Row(
              children: [
                const Text(
                  'Helpful',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10.0.w),
                const Icon(Icons.thumb_up)
              ],
            )
          ],
        ),
      ],
    ),
  );
}

Widget _buildReviewRatings(BuildContext context) {
  return SizedBox(
    height: 20.0.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const Icon(
                Icons.star,
                color: AppColors.secondary,
                size: 14.0,
              );
            }),
        const Text(
          'June 5,2021',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
      ],
    ),
  );
}

Widget _buildRelatedProduct(BuildContext context) {
  final ScrollController scrollController = ScrollController(
    onAttach: (position) {
      // print('on attach');
    },
  );
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product related to this item',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF34283E)),
        ),
        SizedBox(height: 10.0.h),
        SizedBox(
          // color: Colors.red,
          height: 300.h,
          // width: 200,
          child: Scrollbar(
            thumbVisibility: true,
            trackVisibility: true,
            interactive: true,
            controller: scrollController,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 8,
                );
              },
              itemCount: 4,
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ItemWidget(
                    index: index,
                    favoriteIcon: true,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBottomSheet({BuildContext? context, Function()? onTap}) {
  return Container(
    width: MediaQuery.of(context!).size.width / 2,
    height: 70.0,
    decoration: const BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        AppButton.button(
          text: 'Add to Cart',
          color: AppColors.blueBlack,
          style: const TextStyle(color: AppColors.white),
          height: 48.0.h,
          width: MediaQuery.of(context).size.width / 4,
          onTap: onTap,
        ),
        const Icon(Icons.favorite_border),
      ],
    ),
  );
}
