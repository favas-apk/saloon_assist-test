// ignore_for_file: file_names

import 'dart:convert' show json;

ShopModel shopModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String shopModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
  bool status;
  String shopId;
  String shopName;
  String contact;
  String email;
  String tax;
  String regNo;
  String address;
  String salesNos;
  String salesAmt;
  String cash;
  String bank;
  String expenses;
  String result;
  String userType;
  List<Chair> chairs;
  List<Staff> staffs;
  List<Proof> proofs;
  List<Images> images;
  List<Item> items;
  String curencyName;
  String contryCode;

  ShopModel({
    required this.status,
    required this.tax,
    required this.userType,
    required this.address,
    required this.shopId,
    required this.contact,
    required this.email,
    required this.regNo,
    required this.shopName,
    required this.salesNos,
    required this.salesAmt,
    required this.cash,
    required this.bank,
    required this.expenses,
    required this.result,
    required this.chairs,
    required this.staffs,
    required this.proofs,
    required this.images,
    required this.items,
    required this.curencyName,
    required this.contryCode,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        status: json["status"],
        tax: json["Tax"],
        userType: json["UserType"],
        address: json["Address"],
        contact: json["Contact"],
        email: json["Email"],
        regNo: json["RegnNo"],
        shopId: json["ShopID"],
        shopName: json["ShopName"],
        salesNos: json["SalesNos"],
        salesAmt: json["SalesAmt"],
        cash: json["Cash"],
        bank: json["Bank"],
        expenses: json["Expenses"],
        result: json["result"],
        chairs: List<Chair>.from(json["Chairs"].map((x) => Chair.fromJson(x))),
        staffs: List<Staff>.from(json["Staffs"].map((x) => Staff.fromJson(x))),
        proofs: List<Proof>.from(json["Proofs"].map((x) => Proof.fromJson(x))),
        images:
            List<Images>.from(json["Images"].map((x) => Images.fromJson(x))),
        items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
        curencyName: json["CurencyName"],
        contryCode: json["ContryCode"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "tax": tax,
        "UserType": userType,
        "ShopID": shopId,
        "Email": email,
        "Contact": contact,
        "RegnNo": regNo,
        "ShopName": shopName,
        "Address": address,
        "SalesNos": salesNos,
        "SalesAmt": salesAmt,
        "Cash": cash,
        "Bank": bank,
        "Expenses": expenses,
        "result": result,
        "Chairs": List<dynamic>.from(chairs.map((x) => x.toJson())),
        "Staffs": List<dynamic>.from(staffs.map((x) => x.toJson())),
        "Proofs": List<dynamic>.from(proofs.map((x) => x.toJson())),
        "Images": List<dynamic>.from(images.map((x) => x.toJson())),
        "Items": List<dynamic>.from(items.map((x) => x.toJson())),
        "CurencyName": curencyName,
        "ContryCode": contryCode,
      };
}

class Chair {
  String counterId;
  String type;
  String details;
  String lastWorkTime;

  Chair({
    required this.counterId,
    required this.type,
    required this.details,
    required this.lastWorkTime,
  });

  factory Chair.fromJson(Map<String, dynamic> json) => Chair(
        counterId: json["CounterID"],
        type: json["Type"],
        details: json["Details"],
        lastWorkTime: json["LastWorkTime"],
      );

  Map<String, dynamic> toJson() => {
        "CounterID": counterId,
        "Type": type,
        "Details": details,
      };
}

class Item {
  String itemId;
  String itemname;
  String rate;
  String tax;

  Item({
    required this.itemId,
    required this.itemname,
    required this.rate,
    required this.tax,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["ItemID"],
        itemname: json["Itemname"],
        rate: json["Rate"],
        tax: json["Tax"],
      );

  Map<String, dynamic> toJson() => {
        "ItemID": itemId,
        "Itemname": itemname,
        "Rate": rate,
        "Tax": tax,
      };
}

class Proof {
  String proofId;
  String proofName;
  String proofNo;
  String proofDate;
  String expDate;
  String img;
  String staffId;
  String url;

  Proof({
    required this.proofId,
    required this.proofName,
    required this.proofNo,
    required this.proofDate,
    required this.expDate,
    required this.img,
    required this.staffId,
    required this.url,
  });

  factory Proof.fromJson(Map<String, dynamic> json) => Proof(
        proofId: json["ProofID"],
        proofName: json["ProofName"],
        proofNo: json["ProofNo"],
        proofDate: json["ProofDate"],
        expDate: json["ExpDate"],
        img: json["Img"],
        staffId: json["StaffID"],
        url: json["URL"],
      );

  Map<String, dynamic> toJson() => {
        "ProofID": proofId,
        "ProofName": proofName,
        "ProofNo": proofNo,
        "ProofDate": proofDate,
        "ExpDate": expDate,
        "Img": img,
        "StaffID": staffId,
        "URL": url,
      };
}

class Images {
  String url;

  Images({
    required this.url,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Staff {
  String staffId;
  String staffName;
  String address;
  String mobile;
  String email;
  DateTime dob;
  DateTime doj;
  String salary;
  String department;
  String img;
  String sales;
  String workStatus;

  Staff({
    required this.staffId,
    required this.staffName,
    required this.address,
    required this.mobile,
    required this.email,
    required this.dob,
    required this.doj,
    required this.salary,
    required this.department,
    required this.img,
    required this.sales,
    required this.workStatus,
  });

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        staffId: json["StaffID"],
        staffName: json["StaffName"],
        address: json["Address"],
        mobile: json["Mobile"],
        email: json["Email"],
        dob: DateTime.parse(json["DOB"]),
        doj: DateTime.parse(json["DOJ"]),
        salary: json["Salary"],
        department: json["Department"],
        img: json["Img"],
        sales: json["Sales"],
        workStatus: json["WorkStatus"],
      );

  Map<String, dynamic> toJson() => {
        "StaffID": staffId,
        "StaffName": staffName,
        "Address": address,
        "Mobile": mobile,
        "Email": email,
        "DOB":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "DOJ":
            "${doj.year.toString().padLeft(4, '0')}-${doj.month.toString().padLeft(2, '0')}-${doj.day.toString().padLeft(2, '0')}",
        "Salary": salary,
        "Department": department,
        "Img": img,
        "Sales": sales,
        "WorkStatus": workStatus,
      };
}
