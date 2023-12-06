// To parse this JSON data, do
//
//     final billModel = billModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

BillModel billModelFromJson(String str) => BillModel.fromJson(json.decode(str));

String billModelToJson(BillModel data) => json.encode(data.toJson());

class BillModel {
  String chairId;
  String staffId;
  String entryDate;
  String billAmount;
  String net;
  String tax;
  String cash;
  String card;
  String customer;
  String place;
  String mobile;

  BillModel({
    required this.chairId,
    required this.staffId,
    required this.entryDate,
    required this.billAmount,
    required this.net,
    required this.tax,
    required this.cash,
    required this.card,
    required this.customer,
    required this.place,
    required this.mobile,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) => BillModel(
        chairId: json["ChairID"],
        staffId: json["StaffID"],
        entryDate: json["EntryDate"], //DateTime.parse(json["EntryDate"]),
        billAmount: json["BillAmount"],
        net: json["Net"],
        tax: json["Tax"],
        cash: json["Cash"],
        card: json["Card"],
        customer: json["Customer"],
        place: json["Place"],
        mobile: json["Mobile"],
      );

  Map<String, dynamic> toJson() => {
        "ChairID": chairId,
        "StaffID": staffId,
        "EntryDate": entryDate,
        // "${entryDate.year.toString().padLeft(4, '0')}-${entryDate.month.toString().padLeft(2, '0')}-${entryDate.day.toString().padLeft(2, '0')}",
        "BillAmount": billAmount,
        "Net": net,
        "Tax": tax,
        "Cash": cash,
        "Card": card,
        "Customer": customer,
        "Place": place,
        "Mobile": mobile,
      };
}
