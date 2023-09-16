import 'package:flutter/material.dart';
import 'package:freshbits_task/usage/app_common.dart';
import 'package:freshbits_task/usage/app_strings.dart';
import 'package:freshbits_task/widgets/app_text.dart';
import 'package:get/get.dart';
import 'package:freshbits_task/usage/app_fonts.dart';
import 'app_cached_network_image.dart';

class AppGetXFutureBuilder<T> extends StatelessWidget {
  const AppGetXFutureBuilder({
    Key? key,
    required this.controller,
    required this.builder,
    this.emptyDataTitle,
    this.emptyDataSubtitle,
    this.isErrorInScaffold = false,
    this.isEmptyInScaffold = false,
    this.loadingWidget,
    this.emptyWidget,
    this.errorWidget,
  }) : super(key: key);
  final StateMixin<T> controller;
  final Function(T? data) builder;
  final String? emptyDataTitle;
  final String? emptyDataSubtitle;
  final bool isErrorInScaffold;
  final bool isEmptyInScaffold;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: controller.obx(
        (data) => builder(data),
        onLoading:
            Center(child: loadingWidget ?? const CircularProgressIndicator()),
        onError: (error) => notNull(errorWidget)
            ? errorWidget!
            : isErrorInScaffold
                ? Scaffold(body: Center(child: Text(error ?? "Error occurred")))
                : Center(child: Text(error ?? "Error occurred")),
        onEmpty: Center(
          child: notNull(emptyWidget)
              ? emptyWidget
              : isEmptyInScaffold
                  ? Scaffold(
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /* const AppImageWidget(
                            asset: AppAssets.icNoData,
                            height: 60,
                          ), */
                          SizedBox(height: Get.height * 0.015),
                          AppText(
                            emptyDataTitle ?? AppStrings.noDataAvailable,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: AppFontWeight.bold,
                            ),
                          ),
                          Visibility(
                            visible: notNull(emptyDataSubtitle),
                            child: Opacity(
                              opacity: 0.55,
                              child: Column(
                                children: [
                                  const SizedBox(height: 8),
                                  AppText(
                                    emptyDataSubtitle ?? "",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: AppFontWeight.medium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /* const AppImageWidget(
                          asset: AppAssets.icNoData,
                          height: 60,
                        ), */
                        SizedBox(height: Get.height * 0.015),
                        AppText(
                          emptyDataTitle ?? AppStrings.noDataAvailable,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: AppFontWeight.bold,
                          ),
                        ),
                        Visibility(
                          visible: notNull(emptyDataSubtitle),
                          child: Opacity(
                            opacity: 0.55,
                            child: Column(
                              children: [
                                const SizedBox(height: 8),
                                AppText(
                                  emptyDataSubtitle ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: AppFontWeight.medium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
