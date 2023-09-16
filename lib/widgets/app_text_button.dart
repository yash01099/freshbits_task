import 'package:flutter/material.dart';
import 'package:freshbits_task/usage/app_colors.dart';
import 'package:freshbits_task/usage/app_fonts.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({Key? key, this.onTap, this.title}) : super(key: key);
  final Function()? onTap;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          title ?? "",
          style: TextStyle(
            fontSize: 14,
            fontWeight: AppFontWeight.medium,
            color: AppColors.buttonColor,
          ),
        ),
      ),
    );
  }
}
