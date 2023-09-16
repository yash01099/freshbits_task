import 'package:freshbits_task/api/api.dart';
import 'package:freshbits_task/screens/cart/view_model/cart_view_model.dart';
import 'package:freshbits_task/screens/home/view_model/home_view_model.dart';
import 'package:freshbits_task/screens/product_detail/view/product_detail.dart';
import 'package:freshbits_task/screens/product_detail/view_model/product_detail_view_model.dart';
import 'package:freshbits_task/screens/products/model/products_response_model.dart';
import 'package:get/get.dart';

class ProductsViewModel extends GetxController
    with StateMixin<List<ProductsResponseModel>> {
  List<ProductsResponseModel>? responseModel;

  ProductDetailViewModel productDetailViewModel =
      Get.find<ProductDetailViewModel>();
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  void getProducts() async {
    try {
      responseModel = await Api.getProducts();
      CartViewModel cartViewModel = Get.find<CartViewModel>();
      if (responseModel?.isNotEmpty ?? false) {
        change(responseModel, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      change(null, status: RxStatus.error());
      Get.log(e.toString());
    }
  }

  void onProductTap(int index) {
    productDetailViewModel.getProductDetail(responseModel![index].id!);
    Get.to(() => const ProductDetailScreen());
  }
}
