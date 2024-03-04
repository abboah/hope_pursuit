import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hope_pursuit/models/product_model.dart';
import 'package:hope_pursuit/screens/cart/cart.dart';
import 'package:hope_pursuit/screens/catalogue/catalogue.dart';
import 'package:hope_pursuit/screens/checkout/check_out.dart';
import 'package:hope_pursuit/screens/favorite/favorite.dart';
import 'package:hope_pursuit/screens/Filter/filter.dart';
import 'package:hope_pursuit/screens/home/home.dart';
import 'package:hope_pursuit/screens/login/phone_screen.dart';
import 'package:hope_pursuit/screens/login/verification_screen.dart';
import 'package:hope_pursuit/screens/notifications/notifications.dart';
import 'package:hope_pursuit/screens/Orders/order.dart';
import 'package:hope_pursuit/screens/PrivacyPolicy/privacy_policy.dart';
import 'package:hope_pursuit/screens/Product/product.dart';
import 'package:hope_pursuit/screens/Settings/settings.dart';
import 'package:hope_pursuit/screens/ShippingAddress/shipping_address.dart';
import 'package:hope_pursuit/screens/SignUp/sign_up.dart';

class AppConstants {
  static Map<String, Widget Function(dynamic)> appRoutes = {
    '/': (_) => const Home(),
    Login.routeName: (_) => const Login(),
    Verification.routeName: (_) => const Verification(),
    Home.routeName: (_) => const Home(),
    Catalogue.routeName: (_) => const Catalogue(
          selectedCategory: '',
        ),
    Filter.routeName: (_) => const Filter(),
    Product.routeName: (context) {
      final product =
          ModalRoute.of(context)!.settings.arguments as ProductModel;
      return Product(product: product);
    },
    Favorite.routeName: (_) => const Favorite(),
    Cart.routeName: (_) => const Cart(),
    CheckOut.routeName: (_) => const CheckOut(),
    SignUp.routeName: (_) => const SignUp(),
    Settings.routeName: (_) => const Settings(),
    Orders.routeName: (_) => const Orders(),
    PrivacyPolicy.routeName: (_) => const PrivacyPolicy(),
    NotificationScreen.routeName: (_) => const NotificationScreen(),
    ShippingAddress.routeName: (_) => const ShippingAddress(),
  };

  static setSystemStyling() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
  }

  static const privacyPolicyTxt =
      'Give your E-Commerce app an outstanding look.It\'s a small but attractive and beautiful design template for your E-Commerce App.Contact us for more amazing and outstanding designs for your apps.Do share this app with your Friends and rate us if you like this.Also check your other apps';
}
