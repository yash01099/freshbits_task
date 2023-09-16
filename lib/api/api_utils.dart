import 'package:dio/dio.dart';
import 'package:freshbits_task/usage/app_common.dart';
import 'package:freshbits_task/usage/app_prefs.dart';
import 'package:freshbits_task/usage/app_strings.dart';

enum UserAlertType { none, toast, alertDialog }

class ApiUtils {
  static void handleApiError(DioError? dioError,
      {UserAlertType userAlertType = UserAlertType.toast,
      bool allowForceLogout = true}) {
    AppCommon.hideDialog();
    switch (userAlertType) {
      case UserAlertType.none:
        break;
      case UserAlertType.toast:
        if (DioErrorType.other == dioError?.type) {
          if (dioError?.message.contains('SocketException') ?? false) {
            AppCommon.showToast(msg: AppStrings.verifyConnectionAndTryAgain);
          } else {
            AppCommon.showToast(
                msg: dioError?.response?.data.toString() ??
                    AppStrings.somethingWentWrong);
          }
        } else {
          AppCommon.showToast(
              msg: dioError?.response?.data.toString() ??
                  AppStrings.somethingWentWrong);
        }
        break;
      case UserAlertType.alertDialog:
        if (DioErrorType.other == dioError?.type) {
          if (dioError?.message.contains('SocketException') ?? false) {
            AppCommon.showAlertDialog(
                message: AppStrings.verifyConnectionAndTryAgain);
          } else {
            AppCommon.showAlertDialog(
                message: dioError?.response?.data.toString() ??
                    AppStrings.somethingWentWrong);
          }
        } else {
          AppCommon.showAlertDialog(
              message: dioError?.response?.data.toString() ??
                  AppStrings.somethingWentWrong);
        }
        break;
    }
    switch (dioError?.response?.statusCode) {
      case 401:
        AppPrefs.logout();
        break;
      case 302:
        AppPrefs.logout();
        break;
    }
  }
}
