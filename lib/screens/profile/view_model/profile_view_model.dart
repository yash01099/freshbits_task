import 'package:freshbits_task/usage/app_prefs.dart';
import 'package:get/get.dart';

class ProfileViewModel extends GetxController {
  void onLogout() {
    AppPrefs.logout();
  }
}
