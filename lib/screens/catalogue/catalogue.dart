import 'package:flutter/material.dart';
import 'package:hope_pursuit/common/widgets/cart_button.dart';
import 'package:hope_pursuit/common/widgets/drawer.dart';
import 'package:hope_pursuit/common/widgets/footer.dart';
import 'package:hope_pursuit/common/widgets/product_card.dart';
import 'package:hope_pursuit/models/product_model.dart';
import 'package:hope_pursuit/providers/product_provider.dart';
import 'package:hope_pursuit/screens/Product/product.dart';
import 'package:hope_pursuit/screens/home/home.dart';
import 'package:hope_pursuit/utils/app_colors.dart';
import 'package:provider/provider.dart';

class Catalogue extends StatefulWidget {
  static const String routeName = 'catalogue';
  final String selectedCategory;

  const Catalogue({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue>
    with SingleTickerProviderStateMixin {
  ProductProvider? productProvider;
  TabController? _tabController;
  Future<void>? _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    // Initialize productProvider here
    productProvider = Provider.of<ProductProvider>(context, listen: false);

    // Fetch data from the ProductProvider when the widget is created
    await productProvider!.fetchProductsData().then((_) {
      print('Categories loaded: ${productProvider!.categories.length}');

      if (productProvider!.categories.isNotEmpty) {
        print(
            'First category products: ${productProvider!.categories[0].products.length}');
      }
      // Initialize the TabController after fetching the data
      _tabController = TabController(
        length: productProvider?.categories.length ?? 1,
        vsync: this,
      );
    });
    // Other asynchronous tasks if needed
  }

  @override
  Widget build(BuildContext context) {
    print("Number of categories: ${productProvider?.categories.length ?? 0}");
    print("Selected Category: ${widget.selectedCategory}");
    return FutureBuilder<void>(
      future: _fetchDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return _buildErrorWidget();
        } else if (snapshot.connectionState == ConnectionState.done) {
          return _buildScaffold(context);
        } else {
          return _buildScaffold(context);
        }
      },
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return DefaultTabController(
      length: _tabController?.length ?? 1,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: _buildAppBar(),
        ),
        drawer: const CustomDrawer(isLoggedIn: true),
        body: _buildBody(context),
        floatingActionButton: const CartButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        resizeToAvoidBottomInset: true,
        extendBody: true,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        if (productProvider.categories.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                    'Error Loading Data, Please Check Your Internet Connection or Refresh to try again'),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _fetchDataFuture = _fetchData();
                      });
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: AppColors.blueBlack,
                    )),
              ],
            ),
          );
        }

        return TabBarView(
          controller: _tabController,
          children: productProvider.categories.map((category) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGridBody(context, category.products),
                  const SizedBox(
                    height: 340,
                  ),
                  const CustomFooter(),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
              'Error Loading Data, Please Check Your Internet Connection or Refresh to try again'),
          IconButton(
              onPressed: () {
                setState(() {
                  _fetchDataFuture = _fetchData();
                });
              },
              icon: const Icon(
                Icons.refresh,
                color: AppColors.blueBlack,
              )),
        ],
      ),
    );
  }

  Widget _buildGridBody(BuildContext context, List<ProductModel> products) {
    int gridAxis = MediaQuery.of(context).size.width > 600 ? 4 : 2;
    return SizedBox(
      child: Expanded(
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          controller: ScrollController(),
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridAxis,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.8,
          ),
          itemCount: products.length,
          itemBuilder: (BuildContext context, index) {
            ProductModel product = products[index];
            return ProductCard(
              productName: product.name,
              productPrice: "GHC ${product.price}",
              imageUrl: product.imageUrl,
              onTap: () {
                Navigator.pushNamed(context, Product.routeName,
                    arguments: product);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 5,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, Home.routeName);
              },
              child: Image.asset(
                'assets/images/hp.png',
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('Products'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Settings'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('About'),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_rounded),
              ),
            ],
            bottom: _tabController != null ? _buildTabBar() : null,
          );
        } else {
          return AppBar(
            scrolledUnderElevation: 5,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, Home.routeName);
              },
              child: Image.asset(
                'assets/images/hp.png',
                fit: BoxFit.cover,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
            bottom: _tabController != null ? _buildTabBar() : null,
          );
        }
      },
    );
  }

  PreferredSizeWidget _buildTabBar() {
    return TabBar(
      tabAlignment: TabAlignment.fill,
      isScrollable: false,
      controller: _tabController,
      tabs: productProvider?.categories
              .map(
                (category) => Tab(
                  text: category.name,
                ),
              )
              .toList() ??
          [],
    );
  }
}
