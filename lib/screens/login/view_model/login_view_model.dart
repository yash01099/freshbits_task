import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshbits_task/screens/home/view/home.dart';
import 'package:freshbits_task/screens/register/view/register.dart';
import 'package:freshbits_task/usage/app_common.dart';
import 'package:freshbits_task/usage/app_prefs.dart';
import 'package:freshbits_task/usage/app_strings.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
  String? phoneNumber, password;

  void onLogin() {
    AppCommon.formButtonClick<bool>(
      formKey,
      () async {
        bool flag = false;
        await AppCommon.userCollection.get().then((value) async {
          List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
              value.docs;
          String userId = "";
          List<QueryDocumentSnapshot<Map<String, dynamic>>> userData =
              documents.where(
            (element) {
              Map<String, dynamic> user = element.data();
              if (user["phone"] == phoneNumber) {
                userId = element.id;
                return true;
              } else {
                return false;
              }
            },
          ).toList();
          if (userData.isNotEmpty) {
            if (userData[0].data()["password"] == password) {
              AppPrefs.setIsLoggedIn(true);
              AppPrefs.setEmail(userData[0].data()["email"]);
              AppPrefs.setPhoneNumber(userData[0].data()["phone"]);
              AppPrefs.setUserId(userId);
              flag = true;
            } else {
              flag = false;
            }
          } else {
            flag = false;
          }
        });
        return flag;
      },
      onApiCallSuccess: (data) {
        if (data ?? false) {
          Get.offAll(() => const HomeScreen());
        } else {
          AppCommon.showToast(msg: AppStrings.invalidPasswordOrPhone);
        }
      },
      onApiCallFail: (errorMessage) =>
          AppCommon.showToast(msg: AppStrings.somethingWentWrong),
    );
  }

  void onTapRegister() {
    Get.to(() => const RegisterScreen());
  }
}
