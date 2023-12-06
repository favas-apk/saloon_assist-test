// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  String itemId;
  String type;
  String itemName;
  String category;
  String rate;
  String tax;
  String details;
  String shopId;

  ProductModel({
    required this.itemId,
    required this.type,
    required this.itemName,
    required this.category,
    required this.rate,
    required this.tax,
    required this.details,
    required this.shopId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        itemId: json["ItemID"],
        type: json["Type"],
        itemName: json["ItemName"],
        category: json["Category"],
        rate: json["Rate"],
        tax: json["Tax"],
        details: json["Details"],
        shopId: json["ShopID"],
      );

  Map<String, dynamic> toJson() => {
        "ItemID": itemId,
        "Type": type,
        "ItemName": itemName,
        "Category": category,
        "Rate": rate,
        "Tax": tax,
        "Details": details,
        "ShopID": shopId,
      };
}
