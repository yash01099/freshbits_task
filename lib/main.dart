import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freshbits_task/screens/home/view/home.dart';
import 'package:freshbits_task/screens/login/view/login_screen.dart';
import 'package:freshbits_task/screens/products/view/products.dart';
import 'package:freshbits_task/screens/splash/view/splash.dart';
import 'package:freshbits_task/usage/app_colors.dart';
import 'package:freshbits_task/usage/app_initial_bindings.dart';
import 'package:freshbits_task/usage/app_prefs.dart';
import 'package:freshbits_task/usage/app_strings.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      color: AppColors.mainThemeColour,
      supportedLocales: const [Locale("en")],
      initialBinding: AppInitialBinding(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: AppColors.mainThemeColour)),
      home: const SplashScreen(),
    );
  }
}
