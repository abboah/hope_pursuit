import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope_pursuit/providers/product_provider.dart';
import 'package:hope_pursuit/screens/Product/product.dart';
import 'package:hope_pursuit/screens/home/home.dart';
import 'package:hope_pursuit/utils/Constants/app_constants.dart';
import 'package:hope_pursuit/utils/app_colors.dart';
import 'package:hope_pursuit/utils/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA-MyQY5S1isF4IzxcuYbFJSUeyqZ1m68g",
        appId: "1:873008769804:web:6d4b3f4a0f422720ba3729",
        messagingSenderId: "873008769804",
        projectId: "hope-pursuit",
      ),
    );

    print('Firebase initialized successfully');

    runApp(const MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider())
      ],
      child: ScreenUtilInit(
        builder: (BuildContext context, Widget? widget) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.dmSansTextTheme(
              Theme.of(context).textTheme,
            ),
            colorScheme: AppTheme.light,
            scaffoldBackgroundColor: AppColors.white,
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: AppColors.white,
              shape: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
          ),
          initialRoute: Product.routeName,
          routes: AppConstants.appRoutes,
        ),
        designSize: const Size(375, 812),
      ),
    );
  }
}
