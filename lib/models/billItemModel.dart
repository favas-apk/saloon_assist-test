// To parse this JSON data, do
//
//     final billItemModel = billItemModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<BillItemModel> billItemModelFromJson(String str) =>
    List<BillItemModel>.from(
        json.decode(str).map((x) => BillItemModel.fromJson(x)));

String billItemModelToJson(List<BillItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillItemModel {
  String itemName;
  String qty;
  String rate;
  String amount;
  String type;

  BillItemModel({
    required this.itemName,
    required this.qty,
    required this.rate,
    required this.amount,
    required this.type,
  });

  factory BillItemModel.fromJson(Map<String, dynamic> json) => BillItemModel(
        itemName: json["ItemName"],
        qty: json["Qty"],
        rate: json["Rate"],
        amount: json["Amount"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "ItemName": itemName,
        "Qty": qty,
        "Rate": rate,
        "Amount": amount,
        "Type": type,
      };
}
