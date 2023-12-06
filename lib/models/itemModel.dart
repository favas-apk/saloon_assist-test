// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<ItemModel> itemModelFromJson(String str) =>
    List<ItemModel>.from(json.decode(str).map((x) => ItemModel.fromJson(x)));

String itemModelToJson(List<ItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemModel {
  String itemName;
  String type;
  String category;
  String rate;
  String tax;
  String details;
  String shopId;
  String? itemId;

  ItemModel({
    required this.itemName,
    required this.type,
    required this.category,
    required this.rate,
    required this.tax,
    required this.details,
    required this.shopId,
    this.itemId,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        itemName: json["ItemName"],
        type: json["Type"],
        category: json["Category"],
        rate: json["Rate"],
        tax: json["Tax"],
        details: json["Details"],
        shopId: json["ShopID"],
        itemId: json["ItemID"],
      );

  Map<String, dynamic> toJson() => {
        "ItemName": itemName,
        "Type": type,
        "Category": category,
        "Rate": rate,
        "Tax": tax,
        "Details": details,
        "ShopID": shopId,
        "ItemID": itemId,
      };
}
