import 'package:freshbits_task/screens/home/view/home.dart';
import 'package:freshbits_task/screens/login/view/login_screen.dart';
import 'package:freshbits_task/usage/app_prefs.dart';
import 'package:get/get.dart';

class SplashViewModel extends GetxController {
  @override
  void onInit() {
    super.onInit();
    if (AppPrefs.isUserLoggedIn) {
      Future.delayed(const Duration(seconds: 2),
          () => Get.offAll(() => const HomeScreen()));
    } else {
      Future.delayed(const Duration(seconds: 2),
          () => Get.offAll(() => const LoginScreen()));
    }
  }
}
