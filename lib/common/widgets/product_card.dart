import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String imageUrl;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double imageHeight =
                constraints.maxHeight * 0.75; // 75% of container height

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image
                Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Product Details
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth > 600) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            productPrice,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            productPrice,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                        ],
                      );
                    }
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
