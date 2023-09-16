import 'package:flutter/material.dart';
import 'package:freshbits_task/usage/app_colors.dart';
import 'package:freshbits_task/widgets/app_bar_back_button.dart';
import 'package:get/get.dart';
import 'package:freshbits_task/usage/app_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    this.title,
    this.titleWidget,
    this.bottomWidget,
    this.bottomWidgetHeight,
    this.bottomWidgetPadding,
    this.leading,
    this.isLeadingVisible = true,
    this.isActionVisible = true,
    this.isLeadingMenu = false,
    this.isPhoneAppBarVisible = true,
    this.isWebAppBarVisible = true,
    this.centerTitle,
    this.backgroundColor,
    this.titleFontWeight = FontWeight.w500,
    this.actions,
  })  : assert(title == null || titleWidget == null,
            'Cannot provide both a title and a titleWidget'),
        super(key: key);

  final String? title;
  final Widget? titleWidget;
  final Widget? bottomWidget;
  final double? bottomWidgetHeight;
  final double? bottomWidgetPadding;
  final Widget? leading;
  final bool isLeadingVisible;
  final bool isActionVisible;
  final bool isLeadingMenu;
  final bool? centerTitle;
  final bool? isPhoneAppBarVisible;
  final bool? isWebAppBarVisible;
  final Color? backgroundColor;
  final FontWeight? titleFontWeight;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leading == null
          ? isLeadingVisible
              ? isLeadingMenu
                  ? IconButton(
                      padding: EdgeInsets.all(16),
                      icon: Image.asset(
                        "AppAssets.menu",
                        color: Colors.white,
                      ),
                      tooltip: "Menu",
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      splashRadius: 25,
                    )
                  : const AppBarBackButton()
              : null
          : null,
      title: title != null
          ? Text(title ?? "",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: titleFontWeight,
                  fontSize: 17))
          : titleWidget ??
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      "AppAssets.logoAppBar",
                      height: 20,
                    ),
                    Opacity(
                      opacity: 0.59,
                      child: Text(
                        "",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: AppFontWeight.thin,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      titleSpacing: centerTitle == null || centerTitle == false ? null : 0.0,
      centerTitle: centerTitle ?? true,
      backgroundColor: backgroundColor ?? AppColors.cardBackgroundLight,
      // actions: actions,
      actions: isActionVisible
          ? actions ??
              [
                /*Obx(
                  () => AppBarActionButton(
                    asset: AppAssets.iconNotification,
                    isNetworkImage: false,
                    padding: 8,
                    onPressed: () => Get.to(() => const NotificationScreen()),
                  ),
                )*/
                // TODO: Revise
                /*AppBarActionButton(
                  asset: AppAssets.iconNotification,
                  isNetworkImage: false,
                  padding: 8,
                  onPressed: () => Get.to(
                    () => const NotificationScreen(),
                  ),
                ),*/
              ]
          : [],
      bottom: bottomWidget != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(bottomWidgetHeight ?? 0),
              child: Padding(
                padding: bottomWidgetPadding != null
                    ? EdgeInsets.all(bottomWidgetPadding!)
                    : const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                child: bottomWidget ?? Container(),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(_getAppBarHeight() + (bottomWidgetHeight ?? 0));

  double _getAppBarHeight() {
    if (GetPlatform.isWeb) {
      if (isWebAppBarVisible!) {
        return 120;
      } else {
        return 0;
      }
    } else {
      if (isPhoneAppBarVisible!) {
        return kToolbarHeight;
      } else {
        return 0;
      }
    }
  }
}
