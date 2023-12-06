// To parse this JSON data, do
//
//     final staffModel = staffModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<StaffModel> staffModelFromJson(String str) =>
    List<StaffModel>.from(json.decode(str).map((x) => StaffModel.fromJson(x)));

String staffModelToJson(List<StaffModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffModel {
  String? staffId;
  String staffName;
  String address;
  String mobile;
  String email;
  String shopId;
  DateTime dob;
  DateTime doj;
  String salary;
  String department;
  String img;

  StaffModel({
    this.staffId,
    required this.staffName,
    required this.address,
    required this.mobile,
    required this.email,
    required this.shopId,
    required this.dob,
    required this.doj,
    required this.salary,
    required this.department,
    required this.img,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
        staffId: json["StaffID"],
        staffName: json["StaffName"],
        address: json["Address"],
        mobile: json["Mobile"],
        email: json["Email"],
        shopId: json["ShopID"],
        dob: DateTime.parse(json["DOB"]),
        doj: DateTime.parse(json["DOJ"]),
        salary: json["Salary"],
        department: json["Department"],
        img: json["Img"],
      );

  Map<String, dynamic> toJson() => {
        "StaffID": staffId,
        "StaffName": staffName,
        "Address": address,
        "Mobile": mobile,
        "Email": email,
        "ShopID": shopId,
        "DOB":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "DOJ":
            "${doj.year.toString().padLeft(4, '0')}-${doj.month.toString().padLeft(2, '0')}-${doj.day.toString().padLeft(2, '0')}",
        "Salary": salary.toString(),
        "Department": department,
        "Img": img,
      };
}
