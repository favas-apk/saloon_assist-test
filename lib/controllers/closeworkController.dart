// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/api/apiController.dart';
import 'package:saloon_assist/bottomNavigation.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/models/billItemModel.dart';
import 'package:saloon_assist/models/billModel.dart';
import 'package:saloon_assist/widgets/pdf.dart';
import 'package:saloon_assist/widgets/progressDialog.dart';

class CloseWorkController extends ChangeNotifier {
  String? customerName;
  String? customerPhone;
  String? customerPlace;
  String? billAmount;
  String? paymentType;
  //payments
/*   bool cash = false;
  bool creditCard = false;
  bool debitCard = false;
  bool mobilePayment = false; */
  double cash = 0;
  double others = 0;
  int itemRate = 0;
  String serviceCharge = "";
  String setCashAmount(value) {
    cash = value;

    others =
        cash < double.parse(grandTotal) ? (double.parse(grandTotal) - cash) : 0;
    return cash < double.parse(grandTotal)
        ? (double.parse(grandTotal) - cash).toString()
        : "0";
    // paymentType = 'cash';
    // notifyListeners();
  }

  // bool showWarning = false;
  String setOtherPayAmount(value) {
    others = value;
    cash = others < double.parse(grandTotal)
        ? (double.parse(grandTotal) - others)
        : 0;
    // paymentType = 'credit card';
    /* if ((cash + others) > double.parse(grandTotal)) {
      showWarning = true;
      notifyListeners();
    } else {
      showWarning = false;
      notifyListeners();
    } */
    return others < double.parse(grandTotal)
        ? (double.parse(grandTotal) - others).toString()
        : "0";
    // notifyListeners();
  }

  /* setPaymentdebitCard(value) {
    debitCard = value;
    /* cash = false;
    creditCard = false;
    mobilePayment = false; */
    paymentType = 'debit card';

    notifyListeners();
  }

  setPaymentmobilePayment(value) {
    mobilePayment = value;
    /*  cash = false;
    creditCard = false;
    debitCard = false; */
    paymentType = 'mobile payment';

    notifyListeners();
  }
 */
  setCustomerName(value) {
    customerName = value;
    notifyListeners();
  }

  setCustomerPhone(value) {
    customerPhone = value;
    notifyListeners();
  }

  setcustomerPlace(value) {
    customerPlace = value;
    notifyListeners();
  }

  String grandTotal = "0";
  String taxAmount = "0";
  findGrandTotal(int taxPercentage, int rate) {
    var taxrate = rate + (rate * (taxPercentage / 100));
    double taxamount = rate * (taxPercentage / 100);
    taxAmount = taxamount.toStringAsFixed(2);
    grandTotal = taxrate.toStringAsFixed(2);
    cash = double.parse(grandTotal);
    others = 0;
    notifyListeners();
  }

  setBillAmount(
      {required String value,
      required String productRate,
      required BuildContext context}) {
    serviceCharge = value;
    billAmount = "0";
    int tax = context.read<ShopController>().model!.tax == ""
        ? 0
        : int.parse(context.read<ShopController>().model!.tax);
    var bill = value == ""
        ? int.parse(productRate)
        : int.parse(value) + int.parse(productRate);
    billAmount = bill.toString();
    findGrandTotal(tax,
        int.parse(billAmount.toString() != "" ? billAmount.toString() : "0"));
    notifyListeners();
  }

  setPaymentType(value) {
    paymentType = value;

    notifyListeners();
  }

  List<String> products = [];

  prints() {
    log(customerName.toString() +
        customerPhone.toString() +
        billAmount.toString());
  }

  List<String> val = [];
  chooseProduct({required String id, required String productName}) {
    if (val.toString().contains(id)) {
      if (selectedProducts.contains(productName)) {
        val.removeWhere((element) => element == id);
        selectedProducts.removeWhere((element) => element == productName);
      }
    } else {
      val.add(id);
      selectedProducts.add(productName);
    }

    // print(val);
    // print(selectedProducts);

    notifyListeners();
  }

  List<String> selectedProducts = [];
  closeWork() {
    selectedProducts = [];
    val = [];
    notifyListeners();
  }

  List<String> services = [];
  chooseService({required String id, required String service}) {
    if (services.toString().contains(id)) {
      if (selectedService.contains(service)) {
        services.removeWhere((element) => element == id);
        selectedService.removeWhere((element) => element == service);
      }
    } else {
      services.add(id);
      selectedService.add(service);
    }

    // print(val);
    // print(selectedProducts);

    notifyListeners();
  }

  // Future billClose() async {}

  List<BillItemModel> items = [];
  void deleteItem(String itemName, BuildContext context) {
    BillItemModel itemToRemove = items.firstWhere(
      (element) => element.itemName == itemName,
      orElse: () => BillItemModel(
        itemName: '',
        qty: '0',
        rate: '0.0',
        amount: '0.0',
        type: '',
      ),
    );

    if (itemToRemove.itemName.isNotEmpty) {
      int currentQty = int.parse(itemToRemove.qty);

      if (currentQty > 1) {
        // If the quantity is greater than 1, decrement it by 1
        itemToRemove.qty = (currentQty - 1).toString();
        itemToRemove.amount =
            (int.parse(itemToRemove.qty) * double.parse(itemToRemove.rate))
                .toString();
      } else {
        // If the quantity is 1, remove the item
        items.remove(itemToRemove);
      }

      // Recalculate total amount
      double totalAmount = items.fold(
        0,
        (double sum, BillItemModel item) => sum + double.parse(item.amount),
      );
      itemRate = totalAmount.toInt();

      // Update bill amount
      setBillAmount(
        value: serviceCharge,
        productRate: itemRate.toString(),
        context: context,
      );

      notifyListeners();
    }
  }

  Future addBillItem(String itemName, String qty, String rate, String amount,
      String type, BuildContext context) async {
    // Check if an item with the same name already exists in the list
    BillItemModel existingItem = items.firstWhere(
      (item) => item.itemName == itemName,
      orElse: () => BillItemModel(
        itemName: '',
        qty: '0',
        rate: '0.0',
        amount: '0.0',
        type: '',
      ),
    );

    if (existingItem.itemName.isNotEmpty) {
      // If the item exists, increase its quantity
      int newQty = int.parse(existingItem.qty) + int.parse(qty);
      existingItem.qty = newQty.toString();
      existingItem.amount = (newQty * double.parse(rate)).toString();
    } else {
      // If the item doesn't exist, add a new item
      BillItemModel billItemModel = BillItemModel(
        itemName: itemName,
        qty: qty,
        rate: rate,
        amount: amount,
        type: type,
      );
      items.add(billItemModel);
    }

    // Recalculate total amount
    double totalAmount = items.fold(
      0,
      (double sum, BillItemModel item) => sum + double.parse(item.amount),
    );
    itemRate = totalAmount.toInt();

    // Update bill amount
    setBillAmount(
      value: serviceCharge,
      productRate: itemRate.toString(),
      context: context,
    );

    notifyListeners();
  }

  Future billClose(
    BuildContext context, {
    required String chairId,
    required String staffId,
    required String entryDate,
    required String startTime,
    required String endTime,
  }) async {
    ProgressDialog.show(context: context, status: "Saving Bill");
    /* 
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId'); */
    var result = await ApiController().addBill(
        billModel: BillModel(
            tax: taxAmount,
            net: billAmount.toString(),
            chairId: chairId,
            staffId: staffId,
            entryDate: entryDate,
            billAmount: grandTotal.toString(),
            cash: cash.toString(),
            card: others.toString(),
            customer: customerName ?? "",
            place: customerPlace ?? "",
            mobile: customerPhone ?? ""),
        billItemModel: items.isEmpty ? null : items);
    print("bill added  frm close-work-controller ${ result.toString() }");
    if (result != null) {
      if (result[0]['status']) {
        var path = await Pdf.getPdf(
            companyName: context.read<ShopController>().model!.shopName,
            customer: customerName ?? "",
            address: context.read<ShopController>().model!.address,
            register: context.read<ShopController>().model!.regNo,
            grandTotal: grandTotal,
            mobile: "${context.read<ShopController>().model!.contryCode} "
                "${context.read<ShopController>().model!.contact}",
            taxAmount: taxAmount,
            cashAmount: "$cash",
            cardAmount: "$others",
            billAmount: "$billAmount.0",
            starttime: startTime,
            endTime: endTime,
            staffId: staffId,
            time: DateFormat('HH.mm:ss').format(
              DateTime.now(),
            ),
            date: DateFormat('dd MMM yyyy').format(
              DateTime.now(),
            ));
        OpenFile.open(path);
        ProgressDialog.hide(context);

        await Fluttertoast.showToast(msg: 'Bill Added')
            .then((value) => clear())
            .then((value) => Provider.of<ShopController>(context, listen: false)
                .changeChairStatus(
                    context: context,
                    chairid: chairId,
                    status: "1",
                    date: DateFormat('yyyy-MM-dd').format(
                      DateTime.now(),
                    ),
                    staffId: staffId))
            .then(
              (value) => OpenFile.open(path).then(
                (value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => BottomNavigation(
                        page: 1,
                      ),
                    ),
                    (route) => false),
              ),
            );
        ProgressDialog.hide(context);
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(
            msg: result[0]['result'], gravity: ToastGravity.CENTER);
      }
    } else {
      ProgressDialog.hide(context);
      Fluttertoast.showToast(
          msg: "Failed to add Bill", gravity: ToastGravity.CENTER);
    }

    ProgressDialog.hide(context);
  }

  List<String> selectedService = [];
  Future clear() async {
    customerName;
    customerPhone;
    customerPlace;
    billAmount = "0";
    paymentType;
    cash = 0;
    others = 0;
    grandTotal = "0";
    taxAmount = "0";
    itemRate = 0;
    serviceCharge = "";
    //payments
    // cash = false;
    // creditCard = false;
    // debitCard = false;
    // mobilePayment = false;
    services = [];
    selectedProducts = [];
    val = [];
    items = [];
    notifyListeners();
  }

  String getTotalWorkTime({
    required String startedTime,
    required String endedTime,
  }) {
    int totalMinutes = 0;
    int totalHours = 0;

    // Function to convert time in AM/PM format to 24-hour format
    String convertTo24HourFormat(String timeString) {
      List<String> parts = timeString.split(' ');
      List<String> timeParts = parts[0].split(':');
      int hours = int.parse(timeParts[0]);
      int minutes = int.parse(timeParts[1]);

      if (parts[1] == 'PM' && hours < 12) {
        hours += 12;
      } else if (parts[1] == 'AM' && hours == 12) {
        hours = 0;
      }

      return '$hours:$minutes';
    }

    String convertedStartedTime = convertTo24HourFormat(startedTime);
    String convertedEndedTime = convertTo24HourFormat(endedTime);

    int startTimeHour =
        int.parse(splitTimeHours(timeString: convertedStartedTime));
    int startTimeMinutes =
        int.parse(splitTimeMinutes(timeString: convertedStartedTime));
    int endTimeHour = int.parse(splitTimeHours(timeString: convertedEndedTime));
    int endTimeMinutes =
        int.parse(splitTimeMinutes(timeString: convertedEndedTime));
    totalHours = endTimeHour - startTimeHour;
    totalMinutes = endTimeMinutes - startTimeMinutes;
    if (totalMinutes < 0) {
      totalMinutes += 60;
      totalHours--;
    }
    log('$totalHours hours $totalMinutes minutes');
    int p = totalHours.abs();
    return '$p hours $totalMinutes minutes';
  }

  String splitTimeHours({required String timeString}) {
    List<String> parts = timeString.split(':');
    return parts[0];
  }

  String splitTimeMinutes({required String timeString}) {
    List<String> parts = timeString.split(':');
    return parts[1].split(' ')[0]; // Remove 'AM' or 'PM'
  }
}
