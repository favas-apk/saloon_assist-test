// To parse this JSON data, do
//
//     final closeWorkModel = closeWorkModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

CloseWorkModel closeWorkModelFromJson(String str) =>
    CloseWorkModel.fromJson(json.decode(str));

String closeWorkModelToJson(CloseWorkModel data) => json.encode(data.toJson());

class CloseWorkModel {
  String billCount;
  String amount;
  String cash;
  String card;
  String expenses;
  String expCount;
  List<Staff> staff;
  String result;

  CloseWorkModel({
    required this.billCount,
    required this.amount,
    required this.cash,
    required this.card,
    required this.expenses,
    required this.expCount,
    required this.staff,
    required this.result,
  });

  factory CloseWorkModel.fromJson(Map<String, dynamic> json) => CloseWorkModel(
        billCount: json["BillCount"],
        amount: json["Amount"],
        cash: json["Cash"],
        card: json["Card"],
        expenses: json["Expenses"],
        expCount: json["ExpCount"],
        staff: List<Staff>.from(json["Staff"].map((x) => Staff.fromJson(x))),
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "BillCount": billCount,
        "Amount": amount,
        "Cash": cash,
        "Card": card,
        "Expenses": expenses,
        "ExpCount": expCount,
        "Staff": List<dynamic>.from(staff.map((x) => x.toJson())),
        "result": result,
      };
}

class Staff {
  String staffId;
  String staffName;
  String amount;
  String billcount;

  Staff({
    required this.staffId,
    required this.staffName,
    required this.amount,
    required this.billcount,
  });

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        staffId: json["StaffID"],
        staffName: json["StaffName"],
        amount: json["Amount"],
        billcount: json["Billcount"],
      );

  Map<String, dynamic> toJson() => {
        "StaffID": staffId,
        "StaffName": staffName,
        "Amount": amount,
        "Billcount": billcount,
      };
}
