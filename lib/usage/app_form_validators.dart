import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_strings.dart';

class AppFormValidators {
  static String? emptyFieldValidator(String value) {
    if (value.trim().isEmpty) {
      return AppStrings.enterValidData;
    } else {
      return null;
    }
  }

  static String? validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern as String);
    // if (!regex.hasMatch(value) || value == null) {
    if (!GetUtils.isEmail(value)) {
      return AppStrings.enterValidEmail;
    } else {
      return null;
    }
  }

  static String? validateEmpty(String value) {
    if (value.toString().trim() == "") {
      return AppStrings.enterValidData;
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    if (value.toString().trim() == "") return AppStrings.enterPassword;

    if (value.length < 8 || value.length > 30) {
      return AppStrings.mustBe830Characters;
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      return AppStrings.mustIncludeALetter;
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return AppStrings.mustIncludeNumbers;
    } else if (!value.contains(RegExp(r"[!@#$&*~]"))) {
      return AppStrings.mustIncludeASpecialCharacter;
    } else if (value.contains(RegExp(r"[ ]"))) {
      return AppStrings.mustNotIncludeSpaces;
    } else {
      return null;
    }
  }

  static String? validateEmptyPassword(String value) {
    if (value.toString().trim() == "") {
      return AppStrings.enterPassword;
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String value, String password) {
    if (value.toString().trim() == "") return AppStrings.enterConfirmPassword;
    String? resultOfPasswordValidation = validatePassword(value);
    if (resultOfPasswordValidation == null) {
      if (value != password) {
        return AppStrings.confirmPasswordNotMatch;
      } else {
        return null;
      }
    } else {
      return resultOfPasswordValidation;
    }
  }

  static String? validateMobile(String value) {
    Get.log("validateMobile - value = $value");
    if (!GetUtils.isPhoneNumber(value)) {
      return AppStrings.enterValidMobileNumber;
    } else {
      return null;
    }
  }

  static String? validateLength(String value, int length) {
    if (value.toString().trim().length != length) {
      return AppStrings.enterValidData;
    } else {
      return null;
    }
  }

  static validateAndSave(
      GlobalKey<FormState> _formKey, Function() onValid) async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      await onValid();
    } else {
      print('Form is invalid');
    }
  }
}
