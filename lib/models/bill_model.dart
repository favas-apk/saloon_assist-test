/* // To parse this JSON data, do
//
//     final billModel = billModelFromJson(jsonString);

import 'dart:convert';

List<BillModel> billModelFromJson(String str) => List<BillModel>.from(json.decode(str).map((x) => BillModel.fromJson(x)));

String billModelToJson(List<BillModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillModel {
    String bid;
    String billNo;
    DateTime entryDate;
    String amount;
    String cash;
    String card;
    String customer;
    String mobile;

    BillModel({
        required this.bid,
        required this.billNo,
        required this.entryDate,
        required this.amount,
        required this.cash,
        required this.card,
        required this.customer,
        required this.mobile,
    });

    factory BillModel.fromJson(Map<String, dynamic> json) => BillModel(
        bid: json["BID"],
        billNo: json["BillNo"],
        entryDate: DateTime.parse(json["EntryDate"]),
        amount: json["Amount"],
        cash: json["Cash"],
        card: json["Card"],
        customer: json["Customer"],
        mobile: json["Mobile"],
    );

    Map<String, dynamic> toJson() => {
        "BID": bid,
        "BillNo": billNo,
        "EntryDate": "${entryDate.year.toString().padLeft(4, '0')}-${entryDate.month.toString().padLeft(2, '0')}-${entryDate.day.toString().padLeft(2, '0')}",
        "Amount": amount,
        "Cash": cash,
        "Card": card,
        "Customer": customer,
        "Mobile": mobile,
    };
}
 */