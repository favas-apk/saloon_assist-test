// ignore_for_file: file_names, use_build_context_synchronously
import 'package:ftoast/ftoast.dart' as myToast;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/api/apiController.dart';
import 'package:saloon_assist/bottomNavigation.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/models/expenseDetailsModel.dart';
import 'package:saloon_assist/models/expenseItemModel.dart';
import 'package:saloon_assist/views/staff/staff_home_page.dart';
import 'package:saloon_assist/widgets/progressDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportController extends ChangeNotifier {
  bool today = true;
  bool thisMonth = false;
  bool thisWeek = false;
  bool thisYear = false;
  bool overall = false;
  selectToday(value) {
    today = value;
    thisMonth = false;
    thisWeek = false;
    thisYear = false;
    overall = false;

    notifyListeners();
  }

  selectThisMonth(value) {
    thisMonth = value;
    today = false;
    thisWeek = false;
    thisYear = false;
    overall = false;

    notifyListeners();
  }

  selectThisWeek(value) {
    thisWeek = value;
    today = false;
    thisMonth = false;
    thisYear = false;
    overall = false;

    notifyListeners();
  }

  selectThisYear(value, BuildContext context) async {
    // ProgressDialog.show(context: context);
    thisYear = value;
    today = false;
    thisMonth = false;
    thisWeek = false;
    overall = false;
    // ProgressDialog.hide(context);
    notifyListeners();
  }

  selectOverall(value) {
    overall = value;
    today = false;
    thisMonth = false;
    thisWeek = false;
    thisYear = false;

    notifyListeners();
  }

  Future addExpense(
      {required date,
      required reason,
      required amount,
      required BuildContext context}) async {
    ProgressDialog.show(context: context, status: "Adding Expense");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
/* details ={"ShopID":6,"EntryDate":"2023-09-13","Note":" Expenses"}

items=[{"ItemName":"Food Exoenses","Amount":100}] */

    var result = await ApiController().addExpenses(
      itemModel: ExpenseItemModel(itemName: reason, amount: int.parse(amount)),
      detailsModel: ExpenseDetailsModel(
          shopId: int.parse(id.toString()), entryDate: date, note: "Expenses"),
    );
    if (result[0]["status"]) {
      if (Provider.of<ShopController>(context, listen: false).model!.userType ==
          "SHOP-ADMIN") {

        myToast.FToast.toast(context, msg: 'Expense Added');
           Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ct) => BottomNavigation(page: 3),
            ),
          );

      } else {
        myToast.FToast.toast(context, msg: 'Expense Added').

 Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ct) => StaffHomeScreen(
                page: 1,
              ),
            ),
          );

      }
    } else {
      Fluttertoast.showToast(msg: result[0]['result']);
    }
  }

  int billCount = 0;
  int totalAmount = 0;
  Future getIndividualReport(
      {required startDate, required endDate, required staffId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
    var result = await ApiController().getReport(
        startDate: startDate, endDate: endDate, shopId: id, staffId: staffId);
    if (result != null) {
      /*   for (int i = 0; i <= result.length - 1; i++) {
        billCount = billCount + int.parse(result[i]["BillCount"]);
        totalAmount = totalAmount + int.parse(result[i]["Amount"]);
      } */

      return result;
    }
    // notifyListeners();
  }

  Future getExpenseReport({required startDate, required endDate}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');

    var result = await ApiController()
        .getExpenseReport(startDate: startDate, endDate: endDate, shopId: id);
    if (result != null) {
      return result;
    }
  }

  Future getBillingReport({required startDate, required endDate}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');

    var result = await ApiController()
        .getBillingReports(startDate: startDate, endDate: endDate, shopId: id);
    if (result != null) {
      return result;
    }
  }

  Future dayCloseReport() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');

    var result = await ApiController().getDayCloseReport(
        startDate: DateFormat('yyyy-MM-dd').format(DateTime.now()), shopId: id);
    // closework = result;

    //notifyListeners();
    return result;
  }

  Future closeDay(BuildContext context) async {
    ProgressDialog.show(context: context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
    bool isAdmin = preferences.getBool('isAdmin') ?? false;

    var result = await ApiController().closeDay(
        startDate: DateFormat('yyyy-MM-dd').format(DateTime.now()), shopId: id);

    if (result[0]['status'] == true) {
      context.mounted ? ProgressDialog.hide(context) : "";
      Fluttertoast.showToast(msg: result[0]["result"].toString().toUpperCase());
      isAdmin
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (ctx) => BottomNavigation(
                  page: 0,
                ),
              ),
              (route) => false)
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (ctx) => StaffHomeScreen(
                  page: 0,
                ),
              ),
              (route) => false);
    } else {
      context.mounted ? ProgressDialog.hide(context) : "";
      Fluttertoast.showToast(
          msg: "Please close the works befor closing the day");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (ctx) => BottomNavigation(
              page: 1,
            ),
          ),
          (route) => false);
    }
  }

  Future getTimeSheetReports({required startDate, required id}) async {
    /*   SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
 */
    var result = await ApiController()
        .getTimeSheetReport(startDate: startDate, staffId: id);
    if (result != null) {
      return result;
    }
  }

  Future getEmployeeOverallReport(
      {required startDate,
      required endDate,
      required shopId,
      required staffId}) async {
    var result = await ApiController().getStaffSummaryReport(
        startDate: startDate,
        endDate: endDate,
        shopId: shopId,
        staffId: staffId);
    if (result != null) {
      return result;
    }
  }
}
