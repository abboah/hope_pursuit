import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hope_pursuit/common/Widgets/shimmer_effect.dart';

class CatalogueWidget extends StatelessWidget {
  const CatalogueWidget({
    this.style,
    this.height,
    this.width,
    this.index,
    Key? key,
    required this.imageUrl,
    required this.text,
  }) : super(key: key);

  final TextStyle? style;
  final double? height, width;
  final int? index;
  final String? imageUrl;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0.w, top: 17.h),
      child: Column(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.fitWidth,
              width: width,
              color: const Color.fromRGBO(29, 35, 50, 0.2),
              colorBlendMode: BlendMode.srcOver,
              height: height,
              placeholder: (context, error) {
                return ShimmerEffect(
                    borderRadius: 10.0, height: height, width: height);
              },
              errorWidget: (context, errorName, error) {
                return ShimmerEffect(
                    borderRadius: 10.0, height: height, width: width);
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(text!, style: style
              // const TextStyle(
              //   fontSize: 18,
              //   color: Colors.black,
              // ),
              ),
        ],
      ),
    );
  }
}
