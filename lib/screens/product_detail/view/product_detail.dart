import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:freshbits_task/screens/product_detail/model/product_detail_response_model.dart';
import 'package:freshbits_task/screens/product_detail/view_model/product_detail_view_model.dart';
import 'package:freshbits_task/usage/app_const.dart';
import 'package:freshbits_task/usage/app_strings.dart';
import 'package:freshbits_task/widgets/app_button.dart';
import 'package:freshbits_task/widgets/app_cached_network_image.dart';
import 'package:freshbits_task/widgets/app_getx_future_builder.dart';
import 'package:freshbits_task/widgets/app_text.dart';
import 'package:freshbits_task/widgets/my_app_bar.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailViewModel productDetailViewModel =
      Get.find<ProductDetailViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppStrings.productDetail,
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: AppGetXFutureBuilder<ProductDetailResponseModel>(
            controller: productDetailViewModel,
            builder: (data) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: padding16,
                              height: Get.height * 0.3,
                              width: Get.width,
                              child: AppImageWidget(
                                asset: data?.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            gap16,
                            Padding(
                              padding: padding16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(data?.title ?? "",
                                      overflow: TextOverflow.visible,
                                      style: context.textTheme.titleLarge),
                                  gap12,
                                  AppText(AppStrings.productCategory,
                                      style: context.textTheme.titleMedium),
                                  gap8,
                                  AppText(data?.category ?? "",
                                      overflow: TextOverflow.visible,
                                      style: context.textTheme.bodyLarge),
                                  gap12,
                                  AppText(AppStrings.productDescription,
                                      style: context.textTheme.titleMedium),
                                  gap8,
                                  AppText(data?.description ?? "",
                                      overflow: TextOverflow.visible,
                                      style: context.textTheme.bodyLarge),
                                  gap12,
                                  AppText(AppStrings.productRatings,
                                      style: context.textTheme.titleMedium),
                                  gap8,
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        initialRating:
                                            data?.rating?.rate ?? 0.0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: paddingH2,
                                        itemSize: 20,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                      gap8,
                                      AppText("(${data?.rating?.count})",
                                          style: context.textTheme.titleMedium)
                                    ],
                                  ),
                                  gap12,
                                  AppText(AppStrings.productPrice,
                                      style: context.textTheme.titleMedium),
                                  gap8,
                                  AppText("${data?.price?.toString()} \$",
                                      style: context.textTheme.bodyLarge)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Obx(() => Visibility(
                        visible: productDetailViewModel.isAddToCartShow.value,
                        replacement: Container(),
                        child: Container(
                          padding: padding16,
                          width: Get.width,
                          child: AppButton.text(
                            text: AppStrings.addToCart,
                            onPressed: () => productDetailViewModel.addToCart(),
                          ),
                        )))
                  ],
                )),
      ),
    );
  }
}
