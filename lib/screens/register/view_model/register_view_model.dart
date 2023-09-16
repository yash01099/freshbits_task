import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshbits_task/usage/app_common.dart';
import 'package:freshbits_task/usage/app_strings.dart';
import 'package:get/get.dart';

class RegisterViewModel extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password, phone;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void onSignUp() {
    AppCommon.formButtonClick<bool>(formKey, () async {
      bool flag = false;
      await AppCommon.userCollection.get().then((value) async {
        List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
            value.docs;
        bool isExist = documents.any((element) {
          Map<String, dynamic> user = element.data();
          if (user["email"] == email || user["phone"] == phone) {
            return true;
          } else {
            return false;
          }
        });
        if (isExist) {
          flag = false;
        } else {
          await AppCommon.userCollection
              .add({"email": email, "password": password, "phone": phone});
          flag = true;
        }
      });
      return flag;
    }, onApiCallSuccess: (data) {
      if (data ?? false) {
        Get.back();
      } else {
        AppCommon.showToast(msg: AppStrings.emailOrPhoneExists);
      }
    },
        onApiCallFail: (errorMessage) =>
            AppCommon.showToast(msg: AppStrings.somethingWentWrong));
  }

  void onTapLogin() {
    Get.back();
  }
}
