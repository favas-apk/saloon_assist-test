// ignore_for_file: file_names

/* // ignore_for_file: file_names, use_build_context_synchronously

// import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloon_assist/api/apiController.dart';
import 'package:saloon_assist/models/chairModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:saloon_assist/database/database.dart';

class ChairController extends ChangeNotifier {
// AppDB appDB = AppDB();
//test
  String? chairName;
  String? type;
  bool activated = false;
  bool deactivated = false;
  String? startedTime;

  /*  await appDB.addchairTable(
      ChairTableCompanion(
        chiarid: Value(DateTime.now().millisecondsSinceEpoch.toString()),
        currentStatus: Value(false.toString()),
        startedTime: Value(null.toString()),
        inWork: const Value(false),
      ),
    );

    List<Chairs> chairsLocal = await appDB.getchairTable();
    print(chairsLocal); */

  // List<Map<String, dynamic>> chairs = [];
  /* Future updateChair(
      {required String id,
      required String? activeStaffs,
      bool? currentStatus = true,
      required bool inWork}) async {
    String time = DateFormat("hh:mm").format(DateTime.now());

    var target = chairs.firstWhere(
      (item) => item["chairid"] == int.parse(id),
    );

    target['active_staff'] = activeStaffs;
    target['currentStatus'] = currentStatus;
    target['startedTime'] = time;
    target['inWork'] = inWork;
    // print(chairs);

    notifyListeners();
  }
 */
  Future addNewChair(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
    if (chairName != null || type != null) {
      var data = await ApiController()
          .addNewChair(
        context,
        ChairModel(
          charirName: chairName ?? "",
          shopId: id.toString(),
          type: type ?? '',
        ),
      )
          .then((value) {
        chairName;
        type;
      });
      if (data['status']) {
        Fluttertoast.showToast(msg: 'Chair Added');
      } else {
        Fluttertoast.showToast(msg: data['message']);
      }
    } else {
      Fluttertoast.showToast(msg: 'Invalid Data');
    }
  }

  setchairName(value) {
    chairName = value;
    notifyListeners();
  }

  setchairType(value) {
    type = value;
    notifyListeners();
  }

  /*  setchairName(value) {
    chairName = value;
    notifyListeners();
  } */

/*   setactiveStaff(value) {
    activeStaff = value;
    notifyListeners();
  } */

/*   activate(value) {
    activated = value;
    deactivated = false;
    notifyListeners();
  } */

  /*  deactivate(value) {
    deactivated = value;
    activated = false;

    notifyListeners();
  } */

  /*  setstartedTime(value) {
    startedTime = value;
    notifyListeners();
  } */
}
 */