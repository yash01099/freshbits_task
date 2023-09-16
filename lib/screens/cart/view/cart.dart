import 'package:flutter/material.dart';
import 'package:freshbits_task/screens/cart/view_model/cart_view_model.dart';
import 'package:freshbits_task/usage/app_const.dart';
import 'package:freshbits_task/usage/app_strings.dart';
import 'package:freshbits_task/widgets/app_cached_network_image.dart';
import 'package:freshbits_task/widgets/app_getx_future_builder.dart';
import 'package:freshbits_task/widgets/app_text.dart';
import 'package:freshbits_task/widgets/my_app_bar.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartViewModel cartViewModel = Get.find<CartViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppStrings.cart,
      ),
      body: AppGetXFutureBuilder(
        controller: cartViewModel,
        builder: (data) => Padding(
          padding: padding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                "${AppStrings.cartTotal} :  ${cartViewModel.cartTotal} \$",
                style: context.textTheme.titleMedium,
              ),
              gap8,
              Expanded(
                child: ListView.separated(
                  itemCount: data?.length ?? 0,
                  separatorBuilder: (context, index) => gap8,
                  itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: padding8,
                      child: Row(
                        children: [
                          AppImageWidget(
                            asset: data?[index].image,
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                          ),
                          gap8,
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        data?[index].title ?? "",
                                        overflow: TextOverflow.visible,
                                        style: context.textTheme.titleMedium,
                                      ),
                                      gap2,
                                      AppText(data?[index].description ?? "",
                                          overflow: TextOverflow.visible,
                                          style: context.textTheme.labelMedium)
                                    ],
                                  ),
                                ),
                                gap8,
                                Column(
                                  children: [
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () =>
                                          cartViewModel.addQty(data![index]),
                                      child: const Icon(
                                        Icons.add,
                                        size: 35,
                                      ),
                                    ),
                                    gap4,
                                    AppText(
                                      data?[index].qty.toString() ?? "",
                                      overflow: TextOverflow.visible,
                                    ),
                                    gap4,
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () =>
                                          cartViewModel.removeQty(data![index]),
                                      child: const Icon(
                                        Icons.remove,
                                        size: 35,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
