import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  PageController pageController = PageController();
  RxInt activeTabIndex = 0.obs;

  void onTabChange(int index) {
    activeTabIndex.value = index;
    pageController.jumpToPage(index);
  }
}
