// To parse this JSON data, do
//
//     final staffProofModel = staffProofModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

import 'package:saloon_assist/models/shopModel.dart';

List<StaffProofModel> staffProofModelFromJson(String str) =>
    List<StaffProofModel>.from(
        json.decode(str).map((x) => StaffProofModel.fromJson(x)));

String staffProofModelToJson(List<StaffProofModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffProofModel {
  String proofName;
  String proofNo;
  DateTime proofDate;
  DateTime expDate;
  String img;

  StaffProofModel({
    required this.proofName,
    required this.proofNo,
    required this.proofDate,
    required this.expDate,
    required this.img,
  });

  factory StaffProofModel.fromJson(Map<String, dynamic> json) =>
      StaffProofModel(
        proofName: json["ProofName"],
        proofNo: json["ProofNo"],
        proofDate: DateTime.parse(json["ProofDate"]),
        expDate: DateTime.parse(json["ExpDate"]),
        img: json["Img"],
        //  staffID: json["StaffID"],
      );

  factory StaffProofModel.fromJson2(Proof proofL) => StaffProofModel(
        proofName: proofL.proofName,
        proofNo: proofL.proofNo,
        proofDate: DateTime.parse(proofL.proofDate),
        expDate: DateTime.parse(proofL.expDate),
        img: proofL.img,
        //  staffID: json["StaffID"],
      );

  Map<String, dynamic> toJson() => {
        "ProofName": proofName,
        "ProofNo": proofNo,
        "ProofDate":
            "${proofDate.year.toString().padLeft(4, '0')}-${proofDate.month.toString().padLeft(2, '0')}-${proofDate.day.toString().padLeft(2, '0')}",
        "ExpDate":
            "${expDate.year.toString().padLeft(4, '0')}-${expDate.month.toString().padLeft(2, '0')}-${expDate.day.toString().padLeft(2, '0')}",
        "Img": img,
        // "StaffId": staffID,
      };
}
