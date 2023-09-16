class ApiList {
  static const String baseUrl = "https://fakestoreapi.com/";

  static String products = "products";
  static String productDetail(int productId) {
    return "products/$productId";
  }
}
