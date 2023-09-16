import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshbits_task/screens/products/model/products_response_model.dart';
import 'package:freshbits_task/screens/products/view_model/products_view_model.dart';
import 'package:freshbits_task/usage/app_common.dart';
import 'package:freshbits_task/usage/app_prefs.dart';
import 'package:get/get.dart';

class CartViewModel extends GetxController
    with StateMixin<List<ProductsResponseModel>> {
  ProductsViewModel productsViewModel = Get.find<ProductsViewModel>();

  double cartTotal = 0.0;

  List<ProductsResponseModel>? cart;

  @override
  void onInit() {
    super.onInit();
    getCartData();
  }

  void getCartData() async {
    AppCommon.cartCollection.snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>> data = event.docs;
        List<Map<String, dynamic>> items = data.map((e) => e.data()).toList();
        cart = productsViewModel.responseModel?.where((element) {
          List<Map<String, dynamic>> item =
              items.where((e) => e["id"] == element.id).toList();
          if (item.isNotEmpty) {
            element.qty = item[0]["qty"];
            Get.log(element.qty.toString());
            element.cartItemId = item[0]["cart_id"];
            cartTotal = cartTotal + (element.qty! * element.price!);
            return true;
          } else {
            return false;
          }
        }).toList();
        getCartTotal();
        change(cart, status: RxStatus.success());
      } else {
        cart = null;
        change(null, status: RxStatus.empty());
      }
    });
  }

  void getCartTotal() {
    cartTotal = 0.0;
    cart?.forEach((element) {
      cartTotal += element.price! * element.qty!;
    });
  }

  void addQty(ProductsResponseModel data) async {
    double qty = data.qty! + 1;
    await AppCommon.cartCollection.doc(data.cartItemId).update({"qty": qty});
  }

  void removeQty(ProductsResponseModel data) async {
    bool isDelete = false;
    if (data.qty == 1) {
      isDelete = true;
    }
    double qty = data.qty! - 1;
    if (isDelete) {
      await AppCommon.cartCollection.doc(data.cartItemId).delete();
    } else {
      await AppCommon.cartCollection.doc(data.cartItemId).update({"qty": qty});
    }
  }
}
