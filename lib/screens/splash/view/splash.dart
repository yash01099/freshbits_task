import 'package:flutter/material.dart';
import 'package:freshbits_task/screens/splash/view_model/splash_view_model.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashViewModel splashViewModel = Get.put(SplashViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: const Center(
          child: FlutterLogo(
            size: 100,
          ),
        ),
      ),
    );
  }
}
