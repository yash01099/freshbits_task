import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshbits_task/screens/register/view_model/register_view_model.dart';
import 'package:freshbits_task/usage/app_const.dart';
import 'package:freshbits_task/usage/app_form_validators.dart';
import 'package:freshbits_task/usage/app_strings.dart';
import 'package:freshbits_task/widgets/app_text.dart';
import 'package:freshbits_task/widgets/app_text_filed.dart';
import 'package:get/get.dart';
import 'package:freshbits_task/widgets/app_text_button.dart';
import 'package:freshbits_task/widgets/app_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterViewModel registerViewModel = Get.put(RegisterViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Form(
          key: registerViewModel.formKey,
          child: Padding(
            padding: padding16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                        AppText(AppStrings.welcome,
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
                            return registerViewModel.phone =
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
                          hintText: AppStrings.emailHint,
                          validator: (value, countryCode) =>
                              AppFormValidators.validateEmail(value),
                          onSaved: (newValue, countryCode) =>
                              registerViewModel.email = newValue,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        gap16,
                        AppTextFiled(
                          horizontalContentPadding: 16,
                          hintText: AppStrings.passwordHint,
                          validator: (value, countryCode) =>
                              AppFormValidators.validatePassword(value),
                          onSaved: (newValue, countryCode) =>
                              registerViewModel.password = newValue,
                          suffixIconObscured: const Icon(Icons.visibility),
                          suffixIcon: const Icon(Icons.visibility_off),
                          obscureText: true,
                        ),
                        gap16,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(AppStrings.alreadyHaveAnAccount),
                            AppTextButton(
                              title: AppStrings.login,
                              onTap: () => registerViewModel.onTapLogin(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                AppButton.text(
                  onPressed: () => registerViewModel.onSignUp(),
                  text: AppStrings.register,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
