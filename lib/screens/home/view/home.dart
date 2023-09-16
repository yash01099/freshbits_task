import 'package:flutter/material.dart';
import 'package:freshbits_task/screens/cart/view/cart.dart';
import 'package:freshbits_task/screens/home/view_model/home_view_model.dart';
import 'package:freshbits_task/screens/product_detail/view/product_detail.dart';
import 'package:freshbits_task/screens/products/view/products.dart';
import 'package:freshbits_task/screens/products/view_model/products_view_model.dart';
import 'package:freshbits_task/screens/profile/view/profile_view.dart';
import 'package:freshbits_task/usage/app_colors.dart';
import 'package:freshbits_task/usage/app_strings.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = Get.put(HomeViewModel());
  ProductsViewModel productsViewModel = Get.put(ProductsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: homeViewModel.pageController,
        children: const [ProductsScreen(), CartScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
              currentIndex: homeViewModel.activeTabIndex.value,
              onTap: (value) => homeViewModel.onTabChange(value),
              selectedItemColor: AppColors.mainThemeColour,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: const Icon(Icons.home), label: AppStrings.products),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.shopping_bag),
                    label: AppStrings.cart),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.person), label: AppStrings.profile)
              ])),
    );
  }
}
