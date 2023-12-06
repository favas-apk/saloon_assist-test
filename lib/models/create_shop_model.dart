// To parse this JSON data, do
//
//     final createShopModel = createShopModelFromJson(jsonString);

import 'dart:convert';

CreateShopModel createShopModelFromJson(String str) =>
    CreateShopModel.fromJson(json.decode(str));

String createShopModelToJson(CreateShopModel data) =>
    json.encode(data.toJson());

class CreateShopModel {
  String address;
  String category;
  String closingTime;
  String companyId;
  String contact;
  String contryCode;
  String curencyName;
  String email;
  String holyDays;
  String img1;
  String img2;
  String img3;
  String password;
  String pinCode;
  String regnNo;
  String shopName;
  String startTime;
  String userName;
  String latitude;
  String longitude;

  CreateShopModel({
    required this.address,
    required this.category,
    required this.closingTime,
    required this.companyId,
    required this.contact,
    required this.contryCode,
    required this.curencyName,
    required this.email,
    required this.holyDays,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.password,
    required this.pinCode,
    required this.regnNo,
    required this.shopName,
    required this.startTime,
    required this.userName,
    required this.latitude,
    required this.longitude,
  });

  factory CreateShopModel.fromJson(Map<String, dynamic> json) =>
      CreateShopModel(
        address: json["Address"],
        category: json["Category"],
        closingTime: json["ClosingTime"],
        companyId: json["CompanyID"],
        contact: json["Contact"],
        contryCode: json["ContryCode"],
        curencyName: json["CurencyName"],
        email: json["Email"],
        holyDays: json["HolyDays"],
        img1: json["Img1"],
        img2: json["Img2"],
        img3: json["Img3"],
        password: json["Pwd"],
        pinCode: json["PinCode"],
        regnNo: json["RegnNo"],
        shopName: json["ShopName"],
        startTime: json["StartTime"],
        userName: json["UserName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "Address": address,
        "Category": category,
        "ClosingTime": closingTime,
        "CompanyID": companyId,
        "Contact": contact,
        "ContryCode": contryCode,
        "CurencyName": curencyName,
        "Email": email,
        "HolyDays": holyDays,
        "Img1": img1,
        "Img2": img2,
        "Img3": img3,
        "Pwd": password,
        "PinCode": pinCode,
        "RegnNo": regnNo,
        "ShopName": shopName,
        "StartTime": startTime,
        "UserName": userName,
        "latitude": latitude,
        "longitude": longitude,
      };
}
