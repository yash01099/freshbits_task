import 'package:freshbits_task/screens/cart/view_model/cart_view_model.dart';
import 'package:freshbits_task/screens/product_detail/view_model/product_detail_view_model.dart';
import 'package:freshbits_task/screens/products/view_model/products_view_model.dart';
import 'package:get/get.dart';

class AppInitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsViewModel());
    Get.lazyPut(() => ProductDetailViewModel());
    Get.lazyPut(() => CartViewModel());
  }
}
