// To parse this JSON data, do
//
//     final expenseItemModel = expenseItemModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ExpenseItemModel expenseItemModelFromJson(String str) =>
    ExpenseItemModel.fromJson(json.decode(str));

String expenseItemModelToJson(ExpenseItemModel data) =>
    json.encode(data.toJson());

class ExpenseItemModel {
  String itemName;
  int amount;

  ExpenseItemModel({
    required this.itemName,
    required this.amount,
  });

  factory ExpenseItemModel.fromJson(Map<String, dynamic> json) =>
      ExpenseItemModel(
        itemName: json["ItemName"],
        amount: json["Amount"],
      );

  Map<String, dynamic> toJson() => {
        "ItemName": itemName,
        "Amount": amount,
      };
}
