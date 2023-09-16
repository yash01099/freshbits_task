import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshbits_task/usage/app_const.dart';
import 'package:freshbits_task/usage/app_form_validators.dart';
import 'package:freshbits_task/usage/app_strings.dart';
import 'package:freshbits_task/widgets/app_button.dart';
import 'package:freshbits_task/widgets/app_text_filed.dart';
import 'package:freshbits_task/widgets/app_text.dart';
import 'package:freshbits_task/screens/login/view_model/login_view_model.dart';
import 'package:freshbits_task/widgets/app_text_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel loginScreenViewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: padding16,
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Form(
            key: loginScreenViewModel.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.1,
                        ),
                        AppText(AppStrings.welcomeBack,
                            style: context.textTheme.titleLarge),
                        gap24,
                        AppTextFiled(
                          isPrefixCountryCodePicker: true,
                          initialCountryCode: "+91",
                          horizontalContentPadding: 16,
                          hintText: AppStrings.phoneHint,
                          validator: (value, countryCode) =>
                              AppFormValidators.validateMobile(value),
                          onSaved: (newValue, countryCode) {
                            return loginScreenViewModel.phoneNumber =
                                countryCode!.dialCode! + " " + newValue;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        gap16,
                        AppTextFiled(
                          horizontalContentPadding: 16,
                          hintText: AppStrings.passwordHint,
                          validator: (value, countryCode) =>
                              AppFormValidators.validateEmptyPassword(value),
                          onSaved: (newValue, countryCode) =>
                              loginScreenViewModel.password = newValue,
                          suffixIconObscured: const Icon(Icons.visibility),
                          suffixIcon: const Icon(Icons.visibility_off),
                          obscureText: true,
                        ),
                        gap16,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(AppStrings.dontHaveAccount),
                            AppTextButton(
                              onTap: () => loginScreenViewModel.onTapRegister(),
                              title: AppStrings.register,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                AppButton.text(
                  onPressed: () => loginScreenViewModel.onLogin(),
                  text: AppStrings.login,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
