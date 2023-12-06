// To parse this JSON data, do
//
//     final expenseDetailsModel = expenseDetailsModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

ExpenseDetailsModel expenseDetailsModelFromJson(String str) =>
    ExpenseDetailsModel.fromJson(json.decode(str));

String expenseDetailsModelToJson(ExpenseDetailsModel data) =>
    json.encode(data.toJson());

class ExpenseDetailsModel {
  int shopId;
  String entryDate;
  String note;

  ExpenseDetailsModel({
    required this.shopId,
    required this.entryDate,
    required this.note,
  });

  factory ExpenseDetailsModel.fromJson(Map<String, dynamic> json) =>
      ExpenseDetailsModel(
        shopId: json["ShopID"],
        entryDate: json["EntryDate"], // DateTime.parse(json["EntryDate"]),
        note: json["Note"],
      );

  Map<String, dynamic> toJson() => {
        "ShopID": shopId,
        "EntryDate": entryDate,
        //"${entryDate.year.toString().padLeft(4, '0')}-${entryDate.month.toString().padLeft(2, '0')}-${entryDate.day.toString().padLeft(2, '0')}",
        "Note": note,
      };
}
