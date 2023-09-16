import 'package:freshbits_task/api/api.dart';
import 'package:freshbits_task/screens/cart/view_model/cart_view_model.dart';
import 'package:freshbits_task/screens/product_detail/model/product_detail_response_model.dart';
import 'package:freshbits_task/usage/app_common.dart';
import 'package:get/get.dart';

class ProductDetailViewModel extends GetxController
    with StateMixin<ProductDetailResponseModel> {
  ProductDetailResponseModel? responseModel;
  int? productId;
  RxBool isAddToCartShow = true.obs;

  void getProductDetail(int id) async {
    try {
      change(null, status: RxStatus.loading());
      productId = id;
      responseModel = await Api.getProductDetail(id);
      if (responseModel != null) {
        CartViewModel cartViewModel = Get.find<CartViewModel>();
        bool? isExistInCart =
            cartViewModel.cart?.any((element) => element.id == productId);
        if (isExistInCart ?? false) {
          isAddToCartShow.value = false;
        } else {
          isAddToCartShow.value = true;
        }
        change(responseModel, status: RxStatus.success());
      } else {
        isAddToCartShow.value = false;
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      isAddToCartShow.value = false;
      change(null, status: RxStatus.error());
      Get.log(e.toString());
    }
  }

  void addToCart() async {
    await AppCommon.cartCollection
        .add({"qty": 1.0, "id": productId}).then((value) async {
      String itemCartId = value.id;
      await AppCommon.cartCollection
          .doc(itemCartId)
          .update({"cart_id": itemCartId});
      isAddToCartShow.value = false;
      AppCommon.showToast(msg: "Product added to cart.");
    });
  }
}
