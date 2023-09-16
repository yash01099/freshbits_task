import 'package:flutter/material.dart';
import 'package:freshbits_task/screens/profile/view_model/profile_view_model.dart';
import 'package:freshbits_task/usage/app_const.dart';
import 'package:freshbits_task/usage/app_prefs.dart';
import 'package:freshbits_task/usage/app_strings.dart';
import 'package:freshbits_task/widgets/app_button.dart';
import 'package:freshbits_task/widgets/app_text.dart';
import 'package:freshbits_task/widgets/my_app_bar.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewModel profileViewModel = Get.put(ProfileViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppStrings.profile,
      ),
      body: Padding(
        padding: padding16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              AppPrefs.email,
              style: context.textTheme.titleLarge,
            ),
            gap16,
            AppText(
              AppPrefs.phoneNumber,
              style: context.textTheme.titleLarge,
            ),
            gap24,
            AppButton.text(
              text: AppStrings.logout,
              onPressed: () => profileViewModel.onLogout(),
            )
          ],
        ),
      ),
    );
  }
}
