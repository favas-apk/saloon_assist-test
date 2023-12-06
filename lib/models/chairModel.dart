// To parse this JSON data, do
//
//     final chairModel = chairModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<ChairModel> chairModelFromJson(String str) =>
    List<ChairModel>.from(json.decode(str).map((x) => ChairModel.fromJson(x)));

String chairModelToJson(List<ChairModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChairModel {
  String charirName;
  String shopId;
  String type;
  String? chairId;

  ChairModel({
    required this.charirName,
    required this.shopId,
    required this.type,
    this.chairId,
  });

  factory ChairModel.fromJson(Map<String, dynamic> json) => ChairModel(
        charirName: json["CharirName"],
        shopId: json["ShopID"],
        type: json["Type"],
        chairId: json["ChairID"],
      );

  Map<String, dynamic> toJson() => {
        "CharirName": charirName,
        "ShopID": shopId,
        "Type": type,
        "ChairID": chairId,
      };
}
