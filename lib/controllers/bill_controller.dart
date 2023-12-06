import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:saloon_assist/api/apiController.dart';
import 'package:saloon_assist/widgets/progressDialog.dart';

class BillController extends ChangeNotifier {
  void setDetails({required data, required int taxPercentage}) {
    // Calculate tax amount
    /*   double taxAmount = (productValue * taxPercentage) / 100;
    var fractionBill = (productValue - taxAmount);
    // double roundedValue = (fractionBill / 100).ceil() * 100;
    billAmount = fractionBill.toStringAsFixed(2);
    var abc = double.parse(productValue.toString()) -
        double.parse(billAmount.toString()); */
    taxAmounts = data["Tax"];
    billAmount = data["Net"];
    // var tota = fractionBill + abc;
    grandTotal = data["Amount"];
  }

  String grandTotal = "0";
  String taxAmounts = "0";
/*   findGrandTotal(int taxPercentage, int rate) {
    var taxrate = rate + (rate * (taxPercentage / 100));
    double taxamount = rate * (taxPercentage / 100);
    taxAmounts = taxamount.toStringAsFixed(2);
    grandTotal = taxrate.toStringAsFixed(2);
    notifyListeners();
  } */
  findGrandTotal(int taxPercentage, int rate) {
    var taxrate = rate + (rate * (taxPercentage / 100));
    double taxamount = rate.toDouble() * (taxPercentage.toDouble() / 100);
    taxAmounts = taxamount.toStringAsFixed(2);
    grandTotal = taxrate.toStringAsFixed(2);

    notifyListeners();
  }

  Future getBillDetails(
      {required String shopId, required String staffId}) async {
    var data = await ApiController().getAllBills(
      shopId: shopId,
      staffId: staffId,
      date: DateFormat('yyyy-MM-dd').format(
        DateTime.now(),
      ),
    );

    if (data != null) {
      return data;
    }
  }

  String? billAmount;
  String? cash;
  String? card;
  String? customer;
  String? number;
  setBillAmount(value, taxPercentage) {
    billAmount = value.isEmpty ? "0.0" : value;
    findGrandTotal(
      taxPercentage,
      int.parse(value.isEmpty ? "0.0" : value),
    );
    cash = grandTotal;
    card = "0";
    notifyListeners();
  }

  String setCashAmount(value) {
    cash = value;

    card = double.parse(cash!) < double.parse(grandTotal)
        ? (double.parse(grandTotal) - double.parse(cash!)).toStringAsFixed(2)
        : "0";
    return double.parse(cash!) < double.parse(grandTotal)
        ? (double.parse(grandTotal) - double.parse(cash!)).toStringAsFixed(2)
        : "0";
    // paymentType = 'cash';
    // notifyListeners();
  }

  String setOtherPayAmount(value) {
    card = value;
    cash = double.parse(card!) <= double.parse(grandTotal)
        ? (double.parse(grandTotal) - double.parse(card!)).toStringAsFixed(2)
        : "0";
    // paymentType = 'credit card';
    return double.parse(card!) < double.parse(grandTotal)
        ? (double.parse(grandTotal) - double.parse(card!)).toStringAsFixed(2)
        : "0";
    // notifyListeners();
  }

  setCustomer(value) {
    customer = value;
    notifyListeners();
  }

  setNumber(value) {
    number = value;
    notifyListeners();
  }

  Future updateBill(
      {required String staffid,
      required BuildContext context,
      required String bid,
      required String amount,
      required String cash,
      required String card,
      required String name,
      required String number}) async {
    ProgressDialog.show(context: context);
    var data = await ApiController().updateBill(
        bid: bid,
        cash: cash,
        net: amount,
        card: card,
        name: name,
        number: number,
        tax: taxAmounts,
        amount: grandTotal);
    if (data != null) {
      if (data[0]['Status']) {
        context.mounted ? ProgressDialog.hide(context) : "";
        reset().then(
            (value) => Fluttertoast.showToast(msg: data[0]['result']).then(
                  (value) => Navigator.of(context).pop(staffid),
                ));
      } else {
        context.mounted ? ProgressDialog.hide(context) : "";
        Fluttertoast.showToast(msg: data[0]['result']);
      }
    }
    context.mounted ? ProgressDialog.hide(context) : "";
  }

  Future reset() async {
    billAmount = null;
    cash = null;
    card = null;
    customer = null;
    number = null;
    grandTotal = "0";
    taxAmounts = "0";
    notifyListeners();
  }
}
