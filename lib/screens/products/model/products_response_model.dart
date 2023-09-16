// To parse this JSON data, do
//
//     final productsResponseModel = productsResponseModelFromJson(jsonString);

import 'dart:convert';

List<ProductsResponseModel> productsResponseModelFromJson(String str) =>
    List<ProductsResponseModel>.from(
        json.decode(str).map((x) => ProductsResponseModel.fromJson(x)));

String productsResponseModelToJson(List<ProductsResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsResponseModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;
  double? qty;
  String? cartItemId;

  ProductsResponseModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating,
      this.qty,
      this.cartItemId});

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductsResponseModel(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        qty: json["qty"],
        cartItemId: json["cart_item_id"],
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "qty": qty,
        "cart_item_id": cartItemId,
        "rating": rating?.toJson(),
      };
}

class Rating {
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
