import 'package:freshbits_task/screens/login/view/login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class AppPrefs {
  static final GetStorage _getStorage = GetStorage();

  static const String _keyIsLoggedIn = "isLoggedIn";
  static const String _keyEmail = "email";
  static const String _keyPhoneNumber = "phoneNumber";
  static const String _keyCountryCode = "countryCode";
  static const String _keyUserId = "userId";

  static bool get isUserLoggedIn =>
      _getStorage.read<bool>(_keyIsLoggedIn) ?? false;

  static String get email => _getStorage.read(_keyEmail) ?? "";
  static String get phoneNumber => _getStorage.read(_keyPhoneNumber) ?? "";
  static String get countryCode => _getStorage.read(_keyCountryCode) ?? "";
  static String get userId => _getStorage.read(_keyUserId) ?? "";

  static Future<void> setIsLoggedIn(bool loginStatus) async {
    return await _getStorage.write(_keyIsLoggedIn, loginStatus);
  }

  static Future<void> setEmail(String? value) async {
    return await _getStorage.write(_keyEmail, value);
  }

  static Future<void> setPhoneNumber(String? value) async {
    return await _getStorage.write(_keyPhoneNumber, value);
  }

  static Future<void> setCountryCode(String? value) async {
    return await _getStorage.write(_keyCountryCode, value);
  }

  static Future<void> setUserId(String? value) async {
    return await _getStorage.write(_keyUserId, value);
  }

  static logout() async {
    await _getStorage.erase();
    Get.offAll(() => const LoginScreen());
    return;
  }
}
