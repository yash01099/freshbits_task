import 'package:flutter/material.dart';
import 'package:freshbits_task/usage/app_colors.dart';
import 'package:freshbits_task/usage/app_fonts.dart';
import 'package:freshbits_task/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton.text(
      {Key? key,
      this.text,
      this.fontWeight,
      this.onPressed,
      this.textColor,
      this.backgroundColor,
      this.elevation,
      this.fontSize,
      this.borderColor,
      this.isFullScreenWidth = true,
      this.isFAB = false,
      this.isDisabled = false,
      this.verticalMargin = 5,
      this.horizontalMargin = 0,
      this.horizontalPadding = 0,
      this.height,
      this.disabledButtonColor})
      : assert(
          text != null,
          'A non-null `text` must be provided to a  AppButton.text widget.',
        ),
        prefixIcon = null,
        child = null,
        super(key: key);

  const AppButton.widget(
      {Key? key,
      this.child,
      this.fontWeight,
      this.prefixIcon,
      this.onPressed,
      this.textColor,
      this.backgroundColor,
      this.elevation,
      this.fontSize,
      this.borderColor,
      /*this.width,*/
      this.isFullScreenWidth = true,
      this.isFAB = false,
      this.isDisabled = false,
      this.verticalMargin = 5,
      this.horizontalMargin = 0,
      this.horizontalPadding = 0,
      this.height,
      this.disabledButtonColor})
      : assert(
          child != null,
          'A non-null `child` must be provided to a  AppButton.widget widget.',
        ),
        assert(
          prefixIcon != null,
          'A non-null `prefixIcon` must be provided to a  AppButton.widget widget.',
        ),
        text = null,
        super(key: key);

  final String? text;
  final FontWeight? fontWeight;
  final double? height;

  // final double? width;
  final Widget? prefixIcon;
  final Widget? child;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? elevation;
  final double? fontSize;
  final VoidCallback? onPressed;
  final bool isFullScreenWidth;
  final bool isFAB;
  final bool? isDisabled;
  final double verticalMargin;
  final double horizontalMargin;
  final double horizontalPadding;
  final Color? disabledButtonColor;

  @override
  Widget build(BuildContext context) {
    if (text != null) {
      /// Text Button
      return Container(
        margin: isFAB
            ? EdgeInsets.only(
                top: verticalMargin / 2,
                bottom: verticalMargin / 2,
                left: 32,
                right: horizontalMargin / 2,
              )
            : EdgeInsets.symmetric(
                vertical: verticalMargin, horizontal: horizontalMargin),
        width: isFullScreenWidth ? double.infinity : null,
        height: height ?? 50,
        child: ElevatedButton(
          onPressed: !isDisabled! ? onPressed : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              !isDisabled!
                  ? backgroundColor ?? AppColors.buttonColor
                  : disabledButtonColor ?? AppColors.disabledButtonColor,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: !isDisabled!
                      ? borderColor ?? AppColors.buttonColor
                      : disabledButtonColor ?? AppColors.disabledButtonColor,
                  width: 1,
                ),
              ),
            ),
            elevation: MaterialStateProperty.all<double>(elevation ?? 0.0),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding == 0 ? 8 : horizontalPadding),
            child: AppText(
              text ?? "Button Text",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: !isDisabled! ? textColor ?? Colors.white : Colors.white,
                fontWeight: fontWeight ?? AppFontWeight.medium,
                fontSize: fontSize ?? 15,
              ),
            ),
          ),
        ),
      );
    }
    if (child != null) {
      /// Widget Button
      return Container(
        margin: isFAB
            ? EdgeInsets.only(
                top: verticalMargin / 2,
                bottom: verticalMargin / 2,
                left: 32,
                right: horizontalMargin / 2,
              )
            : EdgeInsets.symmetric(
                vertical: verticalMargin, horizontal: horizontalMargin),
        width: isFullScreenWidth ? double.infinity : null,
        height: height ?? 50,
        child: ElevatedButton.icon(
          onPressed: !isDisabled! ? onPressed : null,
          style: ElevatedButton.styleFrom(
            primary: !isDisabled!
                ? backgroundColor ?? AppColors.buttonColor
                : disabledButtonColor ?? AppColors.disabledButtonColor,
            onSurface: !isDisabled!
                ? backgroundColor ?? AppColors.buttonColor
                : disabledButtonColor ?? AppColors.disabledButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(
                  color: !isDisabled!
                      ? borderColor ?? AppColors.buttonColor
                      : disabledButtonColor ?? AppColors.disabledButtonColor,
                  width: 0.7),
            ),
            elevation: elevation ?? 0,
            textStyle: TextStyle(
              fontWeight: fontWeight ?? AppFontWeight.bold,
              fontSize: fontSize ?? 14,
            ),
          ),
          /*style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor ?? AppColors.buttonColorRed),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                    color: borderColor ?? AppColors.buttonColorRed, width: 0.7),
              ),
            ),
            elevation: MaterialStateProperty.all<double>(elevation ?? 0.0),
            textStyle: TextStyle()
          ),*/
          icon: prefixIcon!,
          label: child!,
        ),
      );
    }
    return Container();
  }
}
