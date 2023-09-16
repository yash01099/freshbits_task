import 'package:flutter/material.dart';
import 'package:freshbits_task/screens/product_detail/view_model/product_detail_view_model.dart';
import 'package:freshbits_task/screens/products/model/products_response_model.dart';
import 'package:freshbits_task/screens/products/view_model/products_view_model.dart';
import 'package:freshbits_task/usage/app_colors.dart';
import 'package:freshbits_task/usage/app_const.dart';
import 'package:freshbits_task/usage/app_strings.dart';
import 'package:freshbits_task/widgets/app_cached_network_image.dart';
import 'package:freshbits_task/widgets/app_getx_future_builder.dart';
import 'package:freshbits_task/widgets/app_text.dart';
import 'package:freshbits_task/widgets/my_app_bar.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductsViewModel productsViewModel = Get.find<ProductsViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppStrings.products,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: padding16,
        child: AppGetXFutureBuilder<List<ProductsResponseModel>>(
          controller: productsViewModel,
          builder: (data) => GridView.builder(
            itemCount: data?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
                childAspectRatio: 1.0),
            itemBuilder: (context, index) => GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => productsViewModel.onProductTap(index),
              child: Column(
                children: [
                  Container(
                    padding: padding16,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.mainThemeColour),
                        borderRadius: BorderRadius.circular(10)),
                    height: Get.width * 0.35,
                    width: Get.width * 0.5,
                    child: AppImageWidget(
                      asset: data?[index].image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  gap8,
                  AppText(data?[index].title ?? "",
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleSmall)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
