import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hope_pursuit/common/Widgets/shimmer_effect.dart';
import 'package:hope_pursuit/common/widgets/appbar.dart';
import 'package:hope_pursuit/common/widgets/cart_button.dart';
import 'package:hope_pursuit/common/widgets/catalogue_widget.dart';
import 'package:hope_pursuit/common/widgets/drawer.dart';
import 'package:hope_pursuit/common/widgets/featured_card.dart';
import 'package:hope_pursuit/common/widgets/footer.dart';
import 'package:hope_pursuit/common/widgets/product_card.dart';
import 'package:hope_pursuit/dummy/dummy_data.dart';
import 'package:hope_pursuit/models/product_model.dart';
import 'package:hope_pursuit/providers/product_provider.dart';
import 'package:hope_pursuit/screens/catalogue/catalogue.dart';
import 'package:hope_pursuit/screens/Product/product.dart';
import 'package:hope_pursuit/utils/app_colors.dart';
import 'package:hope_pursuit/utils/font_styles.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String routeName = 'home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  ProductProvider? productProvider;
  Future<void>? _fetchLatest;
  Future<void>? _fetchHomeDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchHomeDataFuture = _fetchData();
    _fetchLatest = _fetchNewArrivalsData();
  }

  Future<void> _fetchNewArrivalsData() async {
    try {
      await productProvider?.fetchLatestProducts();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching new arrivals data: $e');
      }
      rethrow; // Rethrow the error to be caught by the FutureBuilder
    }
  }

  Future<void> _fetchData() async {
    // Initialize productProvider here
    productProvider = Provider.of<ProductProvider>(context, listen: false);

    // Fetch data from the ProductProvider when the widget is created
    await productProvider!.fetchProductsData().then((_) {
      if (kDebugMode) {
        print('Categories loaded: ${productProvider!.categories.length}');
      }
    });

    // Fetch latest uploaded products from ProductProvider for New Arrivals section
    await productProvider!.fetchLatestProducts().then((_) {
      if (kDebugMode) {
        print(
            'Latest products loaded: ${productProvider!.latestProducts.length}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Number of categories: ${productProvider?.categories.length ?? 0}");
    }

    return Scaffold(
      backgroundColor: Colors.white,
      key: _key,
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(isLoggedIn: false),
      body: _buildBody(context),
      floatingActionButton: const CartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      resizeToAvoidBottomInset: true,
      extendBody: true,
    );
  }

  Widget _buildErrorWidget() {
    return const Center(
      child: Text(
        'Error loading data, please check your internet connection and try again',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSellerCard(context),
          _buildCatalogue(context),
          _buildFeatured(context),
          _buildNewArrivals(context),
          const CustomFooter(),
        ],
      ),
    );
  }

  Widget _buildSellerCard(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1,
          width: MediaQuery.of(context).size.width,
          child: makeSlider(),
        );
      } else {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          child: makeSlider(),
        );
      }
    });
  }

  Widget _buildCatalogue(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return _buildCatalogueLayout(constraints);
        },
      ),
    );
  }

  Widget _buildCatalogueLayout(BoxConstraints constraints) {
    if (constraints.maxWidth > 600) {
      return _buildWideCatalogue();
    } else {
      return _buildNarrowCatalogue();
    }
  }

  Widget _buildWideCatalogue() {
    return Column(
      children: [
        _buildCategoriesHeader(),
        _buildCatalogueContent(),
      ],
    );
  }

  Widget _buildNarrowCatalogue() {
    return Column(
      children: [
        _buildCatalogueHeader(),
        _buildCatalogueContent(),
      ],
    );
  }

  Widget _buildCategoriesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Categories',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        _buildSeeAllText(),
      ],
    );
  }

  Widget _buildCatalogueHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Categories', style: FontStyles.montserratBold19()),
        _buildSeeAllText(),
      ],
    );
  }

  Widget _buildSeeAllText() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Catalogue.routeName,
        );
      },
      child: const Text(
        'See All ',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCatalogueContent() {
    return FutureBuilder(
      future: _fetchHomeDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return _buildErrorWidget();
        } else {
          return _buildCatalogueList();
        }
      },
    );
  }

  Widget _buildCatalogueList() {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: double.infinity,
        height: constraints.maxWidth > 600
            ? MediaQuery.of(context).size.height / 2.3
            : MediaQuery.of(context).size.height / 3.5,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productProvider?.categories.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final category = productProvider!.categories[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Catalogue.routeName,
                  arguments: category.name,
                );
              },
              child: CatalogueWidget(
                key: Key(index.toString()),
                height: _calculateCatalogueItemHeight(context),
                width: _calculateCatalogueItemWidth(context),
                index: index,
                style: _calculateCatalogueItemTextStyle(),
                imageUrl: category.imageUrl,
                text: category.name,
              ),
            );
          },
        ),
      );
    });
  }

  double _calculateCatalogueItemHeight(BuildContext context) {
    return _isWideLayout() ? 200 : MediaQuery.of(context).size.height / 6;
  }

  double _calculateCatalogueItemWidth(BuildContext context) {
    return _isWideLayout() ? 180 : MediaQuery.of(context).size.width / 3;
  }

  TextStyle _calculateCatalogueItemTextStyle() {
    return _isWideLayout()
        ? const TextStyle(fontSize: 18, color: Colors.black)
        : FontStyles.montserratRegular10().copyWith(color: Colors.black);
  }

  bool _isWideLayout() {
    return MediaQuery.of(context).size.width > 600;
  }

  Widget _buildFeatured(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0.h),
          LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return GridView.builder(
                scrollDirection: Axis.vertical,
                controller: ScrollController(),
                shrinkWrap: true,
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (_, index) {
                  final imageUrl = DummyData.featured.length > index
                      ? DummyData.featured[index]
                      : null;
                  return FeaturedCard(
                    key: Key(index.toString()), // Add a unique key
                    imageUrl: imageUrl!,
                  );
                },
              );
            } else {
              return GridView.builder(
                shrinkWrap: true,
                itemCount: 2,
                scrollDirection: Axis.vertical,
                controller: ScrollController(),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (_, index) {
                  final imageUrl = DummyData.featured.length > index
                      ? DummyData.featured[index]
                      : null;
                  return FeaturedCard(
                    key: Key(index.toString()), // Add a unique key
                    imageUrl: imageUrl!,
                  );
                },
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildNewArrivals(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          SizedBox(height: 10.0.h),
          _buildProductGrid(),
          SizedBox(height: 10.0.h),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Text(
          'New Arrivals',
          style: constraints.maxWidth > 600
              ? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              : FontStyles.montserratBold12().copyWith(
                  color: const Color(0xFF9B9B9B),
                ),
        );
      },
    );
  }

  Widget _buildProductGrid() {
    return FutureBuilder<void>(
      future: _fetchLatest,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return _buildErrorWidget();
        } else {
          return LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                scrollDirection: Axis.vertical,
                controller: ScrollController(),
                shrinkWrap: true,
                itemCount: productProvider?.latestProducts.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth > 600 ? 4 : 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (_, index) {
                  ProductModel product = productProvider!.latestProducts[index];
                  return ProductCard(
                    productName: product.name,
                    productPrice: "\$${product.price}",
                    imageUrl: product.imageUrl,
                    onTap: () {
                      // Navigate to product details screen with product data
                      Navigator.pushNamed(context, Product.routeName,
                          arguments: product);
                    },
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  Widget makeSlider() {
    return CarouselSlider.builder(
        unlimitedMode: true,
        autoSliderDelay: const Duration(seconds: 5),
        enableAutoSlider: true,
        slideBuilder: (index) {
          return CachedNetworkImage(
            imageUrl: DummyData.sellerImagesLink[index],
            color: const Color.fromRGBO(42, 3, 75, 0.35),
            colorBlendMode: BlendMode.srcOver,
            fit: BoxFit.fill,
            placeholder: (context, name) {
              return ShimmerEffect(
                borderRadius: 10.0.r,
                height: 88.h,
                width: double.infinity,
              );
            },
            errorWidget: (context, error, child) {
              return ShimmerEffect(
                borderRadius: 10.0.r,
                height: 88.h,
                width: double.infinity,
              );
            },
          );
        },
        slideTransform: const DefaultTransform(),
        slideIndicator: CircularSlideIndicator(
          currentIndicatorColor: AppColors.lightGray,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10.h, left: 20.0.w),
        ),
        itemCount: DummyData.sellerImagesLink.length);
  }
}
