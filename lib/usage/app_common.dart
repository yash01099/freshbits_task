import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshbits_task/usage/app_form_validators.dart';
import 'package:freshbits_task/usage/app_prefs.dart';
import 'package:get/get.dart';
import 'app_strings.dart';
import 'app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool notNull<T>(T? obj) => obj != null;

bool isNull<T>(T? obj) => obj == null;

class AppCommon {
  AppCommon._();

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> userCollection =
      firestore.collection("users");

  static CollectionReference<Map<String, dynamic>> cartCollection =
      userCollection.doc(AppPrefs.userId).collection("cart");

  static showAlertDialog({required String message}) {
    Get.defaultDialog(
      title: AppStrings.alert,
      content: Text(message),
      textConfirm: AppStrings.ok,
      confirmTextColor: Colors.white,
      buttonColor: AppColors.mainThemeColour,
      titleStyle: const TextStyle(color: AppColors.mainThemeColour),
      onConfirm: () {
        Get.back();
      },
    );
  }

  static showLoadingDialog() async {
    await Get.dialog(
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const SizedBox(
          height: 50,
          width: 50,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static hideDialog() {
    Get.until((route) => !Get.isDialogOpen!);
  }

  static apiCallHandler<T>(Function() apiCallBody,
      {Function(T? data)? onApiCallSuccess,
      Function(String errorMessage)? onApiCallFail}) async {
    Get.log("apiCallHandler called");
    bool res = false;
    String errorMessage = "";
    T? model;
    showLoadingDialog();
    try {
      model = await apiCallBody();
      res = true;
    } catch (e) {
      Get.log("apiCallHandler error - $e", isError: true);
      e.printError();
      errorMessage = e.toString();
      res = false;
    } finally {
      if (res) {
        hideDialog();
      }
    }
    res
        ? onApiCallSuccess != null
            ? onApiCallSuccess(model)
            : ""
        : onApiCallFail != null
            ? onApiCallFail(errorMessage)
            : "";
  }

  static formButtonClick<T>(
      GlobalKey<FormState> _formKey, Function() onClickAction,
      {Function(T? data)? onApiCallSuccess,
      Function(String errorMessage)? onApiCallFail}) {
    AppFormValidators.validateAndSave(_formKey, () async {
      return await AppCommon.apiCallHandler<T>(
        () async {
          return await onClickAction();
        },
        onApiCallSuccess: (data) => onApiCallSuccess?.call(data),
        onApiCallFail: (errorMessage) => onApiCallFail?.call(errorMessage),
      );
    });
  }

  static cachedNetworkProvider(
      {required String url, int? maxHeight, int? maxWidth}) {
    return CachedNetworkImageProvider(
      url,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );
  }

  static showToast({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
    );
  }
}
