// To parse this JSON data, do
//
//     final timeSheetReportModel = timeSheetReportModelFromJson(jsonString);

import 'dart:convert';

List<TimeSheetReportModel> timeSheetReportModelFromJson(String str) =>
    List<TimeSheetReportModel>.from(
        json.decode(str).map((x) => TimeSheetReportModel.fromJson(x)));

String timeSheetReportModelToJson(List<TimeSheetReportModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeSheetReportModel {
  String entryDate;
  String staffId;
  String shopId;
  String checkInTime;
  String checkoutTime;
  String chair;
  String billNo;
  String amount;
  String cash;
  String card;

  TimeSheetReportModel({
    required this.entryDate,
    required this.staffId,
    required this.shopId,
    required this.checkInTime,
    required this.checkoutTime,
    required this.chair,
    required this.billNo,
    required this.amount,
    required this.cash,
    required this.card,
  });

  factory TimeSheetReportModel.fromJson(Map<String, dynamic> json) =>
      TimeSheetReportModel(
        entryDate: json["EntryDate"],
        staffId: json["StaffID"],
        shopId: json["ShopID"],
        checkInTime: json["CheckInTime"],
        checkoutTime: json["CheckoutTime"],
        chair: json["Chair"],
        billNo: json["BillNo"],
        amount: json["Amount"],
        cash: json["Cash"],
        card: json["Card"],
      );

  Map<String, dynamic> toJson() => {
        "EntryDate": entryDate,
        "StaffID": staffId,
        "ShopID": shopId,
        "CheckInTime": checkInTime,
        "CheckoutTime": checkoutTime,
        "Chair": chair,
        "BillNo": billNo,
        "Amount": amount,
        "Cash": cash,
        "Card": card,
      };
}
