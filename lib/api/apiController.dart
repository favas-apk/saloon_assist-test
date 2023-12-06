// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:saloon_assist/apiLinks/apiLinks.dart';
import 'package:saloon_assist/models/billItemModel.dart';
import 'package:saloon_assist/models/billModel.dart';
import 'package:saloon_assist/models/chairModel.dart';
import 'package:saloon_assist/models/create_Shop_Model.dart';
import 'package:saloon_assist/models/expenseDetailsModel.dart';
import 'package:saloon_assist/models/expenseItemModel.dart';
import 'package:saloon_assist/models/itemModel.dart';
import 'package:saloon_assist/models/productModel.dart';
import 'package:saloon_assist/models/staffModel.dart';
import 'package:saloon_assist/widgets/progressDialog.dart';

class ApiController {
  //completed
  Future login({required String username, required String password}) async {
    var url = Uri.parse('${shopLogin}username=$username&password=$password');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return data;
      } else {
        return Future.error("Network error");
      }
      /*  } on SocketException {
      return Future.error("Socket error"); */
    } catch (e) {
      if (e is SocketException) {
        //treat SocketException
        if (kDebugMode) {
          print("Socket exception: ${e.toString()}");
        }
      } else if (e is TimeoutException) {
        //treat TimeoutException
        if (kDebugMode) {
          print("Timeout exception: ${e.toString()}");
        }
      } else if (kDebugMode) {
        print("Unhandled exception: ${e.toString()}");
      }
    }
  }

  Future addNewStaff(
      {required StaffModel staffModel, required String proofModel}) async {
    var url = Uri.parse(addStaff);
    try {
      Map params = {
        "staff": jsonEncode(staffModel.toJson()),
        'ProofDetails': proofModel,
      };
      //  {"staff": jsonEncode(staffModel.toJson())};
      // log(params.toString());
      var response = await http.post(url, body: params);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future updateStaffDetails(
      {required StaffModel staffModel, required String proofModel}) async {
    var url = Uri.parse(updateStaff);
    try {
      Map params = {
        "staff": jsonEncode(staffModel.toJson()),
        'ProofDetails':
            proofModel /*  [jsonEncode(proofModel.toJson())].toString() */,
      };
      // log(params.toString());
      var response = await http.post(url, body: params);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        return {'error': "Network error"};
      }
    } on SocketException {
      return {'error': "Connection timeout"};
    } catch (e) {
      return {'error': e};
    }
  }

  Future getAllitems(String shopid) async {
    try {
      var response = await http.get(
        Uri.parse('${allItems}ShopID=$shopid'),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var products = productModelFromJson(jsonEncode(data));
        // log(products);
        return products;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future addNewChair(BuildContext context, ChairModel chairModel) async {
    ProgressDialog.show(context: context, status: 'Adding..');
    var url = Uri.parse(addChair);
    try {
      Map params = {"chair": jsonEncode(chairModel.toJson())};
      var response = await http.post(url, body: params);
      // log(params.toString());
      // log(response.body);
      ProgressDialog.hide(context);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');

        //Future.error("Network error");
      }
    } on SocketException {
      return {'status': false, 'message': 'Connection lost'};
    } catch (e) {
      return {'status': false, 'message': e.toString()};
    }
  }

  Future updateChairs(BuildContext context, ChairModel chairModel) async {
    ProgressDialog.show(context: context, status: 'Updating..');
    var url = Uri.parse(updateChair);
    try {
      Map params = {"chair": jsonEncode(chairModel.toJson())};
      var response = await http.post(url, body: params);
      // log(params.toString());
      // log(response.body);
      ProgressDialog.hide(context);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');

        //Future.error("Network error");
      }
    } on SocketException {
      return {'status': false, 'message': 'Connection lost'};
    } catch (e) {
      return {'status': false, 'message': e.toString()};
    }
  }
/* 
  Future addNewChair(BuildContext context, ChairModel chairModel) async {
    ProgressDialog.show(context: context, status: 'Adding item');
    var url = Uri.parse(addChair);
    try {
      Map params = {"chair": jsonEncode(chairModel.toJson())};
      var response = await http.post(url, body: params);
      // log(params.toString());
      // log(response.body);
      ProgressDialog.hide(context);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  } */

  Future addProduct(BuildContext context, ItemModel itemModel) async {
    ProgressDialog.show(context: context, status: 'Adding item');
    try {
      Map params = {"item": jsonEncode(itemModel.toJson())};
      var response = await http.post(Uri.parse(additem), body: params);
      // log(params.toString());
      // log(response.body);
      ProgressDialog.hide(context);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future updateProduct(ItemModel itemModel) async {
    Map params = {"item": jsonEncode(itemModel.toJson())};
    try {
      var response = await http.post(Uri.parse(updateItem), body: params);
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        return {'status': result[0]['status'], 'message': 'success'};
      } else {
        return {'status': false, 'message': 'Network error'};
        //return Future.error("Network error");
      }
    } on SocketException {
      // return Future.error("Socket error");
      return {'status': false, 'message': 'Socket error'};
    } catch (e) {
      //return Future.error(e);
      return {'status': false, 'message': e.toString()};
    }
  }

  Future getChairStatus({
    required shopid,
  }) async {
    try {
      var response = await http.get(
        Uri.parse("${chairStatus}ShopID=$shopid"),
      );
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        return result;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future changeChairStatus(
      {required chairid,
      required staffid,
      required status,
      required date}) async {
    try {
      var url = Uri.parse(
          "${changeStatus}ChairID=$chairid&StaffID=$staffid&Status=$status&EntryDate=$date");
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        return result;
      } else {
        var data = [
          {"status": false, 'result': "Network error"}
        ];
        return data;
      }
    } on SocketException {
      var data = [
        {"status": false, 'result': "Connection timeout"}
      ];
      return data;
    } catch (e) {
      var data = [
        {"status": false, 'result': e.toString()}
      ];
      return data;
    }
  }

  Future addBill(
      {required BillModel billModel,
      required List<BillItemModel>? billItemModel}) async {
    Map params = {
      "details": jsonEncode(billModel.toJson()),
      "items":
          billItemModel == null ? "null" : billItemModelToJson(billItemModel),
    };
    try {
      var url = Uri.parse(addBills);

      http.Response response = await http.post(url, body: params);
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        return result;
      } else {
        return null;
      }
    } on SocketException {
      return [
        {'status': false, "result": "Failed"}
      ];
    } catch (e) {
      return [
        {'status': false, "result": e.toString()}
      ];
    }
  }

  Future addExpenses(
      {required ExpenseDetailsModel detailsModel,
      required ExpenseItemModel itemModel}) async {
    Map params = {
      "details": jsonEncode(detailsModel.toJson()),
      "items": jsonEncode([itemModel.toJson()]),
    };
    try {
      var url = Uri.parse(addExpense);

      http.Response response = await http.post(url, body: params);
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        return result;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getReport(
      {required startDate,
      required endDate,
      required shopId,
      required staffId}) async {
    try {
      var url = Uri.parse(
          "${staffReport}SDate=$startDate&EDate=$endDate&ShopID=$shopId&StaffID=$staffId");

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);

        return result;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getExpenseReport(
      {required startDate, required endDate, required shopId}) async {
    try {
      var url = Uri.parse(
          "${expenseReport}SDate=$startDate&EDate=$endDate&ShopID=$shopId");

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        return result;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getBillingReports(
      {required startDate, required endDate, required shopId}) async {
    try {
      var url = Uri.parse(
          "${billingReport}SDate=$startDate&EDate=$endDate&ShopID=$shopId");

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        return result;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getDayCloseReport({required startDate, required shopId}) async {
    try {
      var url =
          Uri.parse("${closingReport}EntryDate=$startDate&ShopID=$shopId");

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;

        //return shops;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future closeDay({required startDate, required shopId}) async {
    try {
      var url = Uri.parse("${dayClose}ShopID=$shopId&EntryDate=$startDate");

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;

        //return shops;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future createShops({required CreateShopModel createShopModel}) async {
    Map params = {
      "shops": jsonEncode(createShopModel.toJson()),
    };
    try {
      var url = Uri.parse(createShop);

      http.Response response = await http.post(url, body: params);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  deleteShops({required String shopid}) async {
    try {
      var url = Uri.parse("${deleteShop}ShopID=$shopid");

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  } //

  Future getTimeSheetReport({required startDate, required staffId}) async {
    try {
      var url =
          Uri.parse("${timeSheetReport}EntryDate=$startDate&StaffID=$staffId");

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;

        //return shops;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getStaffSummaryReport(
      {required startDate,
      required endDate,
      required shopId,
      required staffId}) async {
    //SDate=2023-10-20&EDate=2023-10-21&ShopID=3&StaffID=10
    try {
      var url = Uri.parse(
          "${staffSummaryReport}SDate=$startDate&EDate=$endDate&ShopID=$shopId&StaffID=$staffId");

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;

        //return shops;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getAllBills({required shopId, required staffId, required date}) async {
    //SDate=2023-10-20&EDate=2023-10-21&ShopID=3&StaffID=10
    try {
      var url = Uri.parse(
          "${getstaffAllBills}StaffID=$staffId&EntryDate=$date&ShopID=$shopId");

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future updateBill({
    required bid,
    required cash,
    required amount,
    required card,
    required name,
    required number,
    required net,
    required tax,
  }) async {
    try {
      var url = Uri.parse(
          "${updateBills}BID=$bid&Amount=$amount&Cash=$cash&Card=$card&Customer=$name&Mobile=$number&Tax=$tax&Net=$net");

      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        return Future.error("Network error");
      }
    } on SocketException {
      return Future.error("Socket error");
    } catch (e) {
      return Future.error(e);
    }
  }
}
