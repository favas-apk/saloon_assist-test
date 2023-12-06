// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saloon_assist/api/apiController.dart';
import 'package:saloon_assist/apiLinks/apiLinks.dart';
import 'package:saloon_assist/bottomNavigation.dart';
import 'package:saloon_assist/models/chairModel.dart';
import 'package:saloon_assist/models/shopModel.dart';
import 'package:saloon_assist/models/staffModel.dart';
import 'package:saloon_assist/models/staffProofModel.dart';
import 'package:saloon_assist/widgets/progressDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopController extends ChangeNotifier {
  List<Images> defaultimages = [];
  bool isBottomSheetOpened = false;

  Future openBottomSheet(bool value) async {
    isBottomSheetOpened = true;
    notifyListeners();
  }

  ShopModel? model;
  String? chairName;
  String? type;
  bool isAdmin = false;

  // String? activeStaff;
  bool activated = false;
  bool deactivated = false;
  String? startedTime;

  /*  setchairId(value) {
    chairId = value;
    notifyListeners();
  } */
  Future addNewChair(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
    if (chairName != null || type != null) {
      var data = await ApiController().addNewChair(
        context,
        ChairModel(
          charirName: chairName ?? "",
          shopId: id.toString(),
          type: type ?? '',
        ),
      );
      if (data[0]['status']) {
        Fluttertoast.showToast(msg: 'Chair Added');
      } else {
        Fluttertoast.showToast(msg: data[0]['result']);
      }
    } else {
      Fluttertoast.showToast(msg: 'Invalid Data');
    }
  }

  Future updateChair(
    BuildContext context, {
    required newChairName,
    required newChairType,
    required chairId,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
    if (newChairName != null || newChairType != null) {
      var data = await ApiController().updateChairs(
        context,
        ChairModel(
          charirName: newChairName,
          shopId: id.toString(),
          type: newChairType ?? '',
          chairId: chairId ?? '',
        ),
      );
      if (data[0]['status']) {
        Fluttertoast.showToast(msg: 'Chair updated');
      } else {
        Fluttertoast.showToast(msg: data[0]['result']);
      }
    } else {
      Fluttertoast.showToast(msg: 'Invalid Data');
    }
    notifyListeners();
  }

  setchairName(value) {
    chairName = value;
    notifyListeners();
  }

  setchairType(value) {
    type = value;
    notifyListeners();
  }

  initShopModel(ShopModel shopModel) {
    model = shopModel;
    notifyListeners();
  }

  List<DropDownValueModel> staffs = [];

  Future setIsAdmin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isAdmin = preferences.getBool('isAdmin') ?? false;
    notifyListeners();
  }

  Future getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username').toString();
    String password = preferences.getString('password').toString();
    var data =
        await ApiController().login(username: username, password: password);

    if (data != null) {
      if (data[0]["status"]) {
        ShopModel shopModel = shopModelFromJson(jsonEncode(data[0]));
        await preferences.setString('ShopId', shopModel.shopId);
        model = shopModel;
        staffs = [];
        var staffData = data[0]["Staffs"];
        for (int i = 0; i < data[0]["Staffs"].length; i++) {
          staffs.add(
            DropDownValueModel(
              name: staffData[i]['StaffName'],
              value: staffData[i]['StaffID'],
            ),
          );
        }
      }
    }
    return data;
  }

  Future getModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username').toString();
    String password = preferences.getString('password').toString();
    var data =
        await ApiController().login(username: username, password: password);

    if (data != null) {
      if (data[0]["status"]) {
        ShopModel shopModel = shopModelFromJson(jsonEncode(data[0]));
        await preferences.setString('ShopId', shopModel.shopId);
        model = shopModel;
        staffs = [];
        var staffData = data[0]["Staffs"];
        for (int i = 0; i < data[0]["Staffs"].length; i++) {
          staffs.add(
            DropDownValueModel(
              name: staffData[i]['StaffName'],
              value: staffData[i]['StaffID'],
            ),
          );
        }
      }
    }
    notifyListeners();
  }

  Future getChairs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username').toString();
    String password = preferences.getString('password').toString();
    var data =
        await ApiController().login(username: username, password: password);

    ShopModel shopModel = shopModelFromJson(jsonEncode(data[0]));
    await preferences.setString('ShopId', shopModel.shopId);
    model = shopModel;
    return shopModel.chairs;
  }

/*   List<Chair> chairsList = [];
  getChairList() {
    chairsList = model!.chairs;
    notifyListeners();
  } */

  /*  setactiveStaff(value) {
    activeStaff = value;
    notifyListeners();
  } */

  activate(value) {
    activated = value;
    deactivated = false;
    notifyListeners();
  }

  deactivate(value) {
    deactivated = value;
    activated = false;

    notifyListeners();
  }

  setstartedTime(value) {
    startedTime = value;
    notifyListeners();
  }

  //staff

  File? imageFile;
  DateTime? dateofBirth;
  DateTime? dateofjoining;
  String? staffId;
  String? staffName;
  String? address;
  String? mobileNumber;
  String? shopId;
  String? email;
  String? dateofbirth;
  String? doj;
  String? salary;

  // String? department;
  String? staffImage;

  //satff proof
  File? proofImageFile;
  String? proofName;
  DateTime? proofDate;
  DateTime? expairyDate;
  String? proofID;
  String? proofNumber;
  String? remindDays;
  String? proofImage;

  setdateofBirth(value) {
    dateofbirth = value;
    notifyListeners();
  }

  setdateofjoining(value) {
    dateofjoining = value;
    notifyListeners();
  }

  setstaffId(value) {
    staffId = value;
    notifyListeners();
  }

  setstaffName(value) {
    staffName = value;
    notifyListeners();
  }

  setaddress(value) {
    address = value;
    notifyListeners();
  }

  setmobileNumber(value) {
    mobileNumber = value;
    notifyListeners();
  }

  setshopId(value) {
    shopId = value;
    notifyListeners();
  }

  setemail(value) {
    email = value;
    notifyListeners();
  }

  setdateofbirth(value) {
    dateofBirth = value;
    notifyListeners();
  }

  setdoj(value) {
    doj = value;
    notifyListeners();
  }

  setsalary(String? value) {
    salary = value ?? "0";
    notifyListeners();
  }

/*   setdepartment(value) {
    department = value;
    notifyListeners();
  } */

  setstaffImage(value) {
    staffImage = value;
    notifyListeners();
  }

//proof page
  setproofName(value) {
    proofName = value;
    notifyListeners();
  }

  setproofDate(value) {
    proofDate = value;
    notifyListeners();
  }

  setproofID(value) {
    proofID = value;
    notifyListeners();
  }

  setproofNumber(value) {
    proofNumber = value;
    notifyListeners();
  }

  setremindDays(value) {
    remindDays = value;
    notifyListeners();
  }

  setproofImage(value) {
    proofImage = value;
    notifyListeners();
  }

  Future pickImage(ImageSource source, BuildContext context) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    await ProgressDialog.show(context: context, status: 'Please wait');
    if (pickedImage != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 50,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
      );
      if (cropped != null) {
        final selected = File(cropped.path);
        imageFile = File(selected.path);
        staffImage = base64Encode(selected.readAsBytesSync());
        ProgressDialog.hide(context);
      } else {
        Fluttertoast.showToast(msg: "Failed to add image");
      }
    } else {
      Fluttertoast.showToast(msg: "Failed to add image");
    }

    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future pickProofImage(ImageSource source, BuildContext context) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 50,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
      );
      if (cropped != null) {
        final selected = File(cropped.path);

        proofImageFile = File(selected.path);
        proofImage = base64Encode(selected.readAsBytesSync());
      } else {
        Fluttertoast.showToast(msg: "Failed to add image");
      }
    } else {
      Fluttertoast.showToast(msg: "Failed to add image");
    }

    ProgressDialog.hide(context);
    notifyListeners();
  }

  /*  saveStaffDetails() async {
    log(staffName.toString());
    log(address.toString());
    log(mobileNumber.toString());
    log(email.toString());
    log(salary.toString());
    log(dateofjoining.toString());
    log(dateofBirth.toString());
    log(department.toString());
    log(staffImage.toString());
    log(proofName.toString());
    log(proofDate.toString());
    log(proofID.toString());
    log(proofNumber.toString());
    log(expairyDate.toString());
    log(remindDays.toString());
    log(proofImage.toString());
    await clear();
    notifyListeners();
  }
 */
  Future getAllStaffs() async {}

  Future addStaff(
    BuildContext context,
  ) async {
    ProgressDialog.show(context: context, status: 'Adding new staff');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
    late dynamic result;
    if (staffProofs.isNotEmpty) {
      List<Map<String, dynamic>> staffProofsMapList =
          staffProofs.map((staffProof) => staffProof.toJson()).toList();

      var proofDetails = jsonEncode(staffProofsMapList);

      result = await ApiController().addNewStaff(
          staffModel: StaffModel(
            staffName: staffName.toString(),
            address: address.toString(),
            mobile: mobileNumber.toString(),
            email: email.toString(),
            shopId: id.toString(),
            //
            dob: DateTime.parse(dateofBirth.toString()),
            doj: DateTime.parse(dateofjoining.toString()),
            salary: salary.toString(),
            department: "" /* department.toString() */,
            img: staffImage.toString(),
          ),
          proofModel: proofDetails);
    } else {
      var proof = StaffProofModel(
          proofName: proofName.toString(),
          proofNo: proofNumber.toString(),
          proofDate: DateTime.parse(proofDate.toString()),
          expDate: DateTime.parse(
            expairyDate.toString(),
          ),
          img: proofImage.toString());
      var proofDetails = [jsonEncode(proof.toJson())].toString();
      result = await ApiController().addNewStaff(
          staffModel: StaffModel(
            staffName: staffName ?? "",
            address: address ?? "",
            mobile: mobileNumber ?? "",
            email: email ?? "",
            shopId: id.toString(),
            //
            dob: DateTime.parse(dateofBirth.toString()),
            doj: DateTime.parse(dateofjoining.toString()),
            salary: salary ?? "",
            department: "" /* department.toString() */,
            img: staffImage.toString(),
          ),
          proofModel: proofDetails);
    }

    ProgressDialog.hide(context);
    if (result[0]['status']) {
      staffProofs = [];
      Fluttertoast.showToast(msg: 'Added $staffName')
          .then((value) => getData())
          .then(
            (value) => clearProofDetails().then(
              (value) => clearStaffDetails(),
            ),
          )
          .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (ctx) => BottomNavigation(
                  page: 2,
                ),
              ),
              (route) => false));
      ProgressDialog.hide(context);
    } else {
      staffProofs = [];
      ProgressDialog.hide(context);
      Fluttertoast.showToast(msg: result[0]['result']);
    }

    ProgressDialog.hide(context);
  }

  Future updateStaffDetails(
    BuildContext context, {
    required String newstaffName,
    required String newaddress,
    required String newmobile,
    required String newemail,
    required DateTime newdob,
    required DateTime newdoj,
    required String newsalary,
    required String? newimg,
    required String staffid,
  }) async {
    ProgressDialog.show(context: context, status: 'Updating details');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
    dynamic result;
    // updateImagesInTempProoTable(tempProoTable);
    List<Map<String, dynamic>> staffProofsMapList =
        tempProoTable.map((tempProoTable) => tempProoTable.toJson()).toList();

    var proofDetails = jsonEncode(staffProofsMapList);

    result = await ApiController().updateStaffDetails(
        staffModel: StaffModel(
          staffId: staffid,
          staffName: newstaffName.toString(),
          address: newaddress.toString(),
          mobile: newmobile.toString(),
          email: newemail.toString(),
          shopId: id.toString(),
          //
          dob: newdob,
          doj: newdoj,
          salary: newsalary,
          department: "",
          img: newimg ?? '',
        ),
        proofModel: proofDetails);

    ProgressDialog.hide(context);
    if (result[0]['status']) {
      staffProofs = [];
      Fluttertoast.showToast(msg: 'updated $newstaffName')
          .then((value) async => await getData())
          .then(
            (value) => clearProofDetails().then(
              (value) => clearStaffDetails(),
            ),
          )
          .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (ctx) => BottomNavigation(
                  page: 2,
                ),
              ),
              (route) => false));
      ProgressDialog.hide(context);
    } else {
      staffProofs = [];
      ProgressDialog.hide(context);
      Fluttertoast.showToast(msg: result[0]['result']);
    }

    ProgressDialog.hide(context);
    notifyListeners();
  }

  /* void updateImagesInTempProoTable(List<StaffProofModel> tempProoTable) {
    for (var staffProof in tempProoTable) {
      if (staffProof.img.contains('.png') ||
          staffProof.img.contains('.jpg') ||
          staffProof.img.contains('.jpeg')) {
        // Update the img field as needed
        staffProof.img = ""; // Replace with your new value
      }
    }
  }*/

  Future getChairsStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
    var data = await ApiController().getChairStatus(shopid: id);

    return data;
  }

  Future changeChairStatus(
      {required chairid,
      required status,
      required date,
      required staffId,
      required BuildContext context}) async {
    ProgressDialog.show(context: context);
    var data = await ApiController().changeChairStatus(
        chairid: chairid, staffid: staffId, status: status, date: date);
    if (data[0]['status']) {
      await getChairsStatus().then((value) => getData().then(
            (value) => ProgressDialog.hide(context).then(
              (value) => Navigator.pop(context),
            ),
          ));
      Fluttertoast.showToast(msg: 'Success');
    } else {
      Fluttertoast.showToast(
          msg: data[0]['result'], gravity: ToastGravity.CENTER);
    }
    // ProgressDialog.hide(context);
    notifyListeners();
  }

  Future clearChairData() async {
    chairName = null;
    type = null;
    notifyListeners();
  }

  Future clearStaffDetails() async {
    imageFile = null;
    dateofBirth = null;
    dateofjoining = null;
    staffId = null;
    staffName = null;
    address = null;
    mobileNumber = null;
    shopId = null;
    email = null;
    dateofbirth = null;
    doj = null;
    salary = null;
    // department = null;
    staffImage = null;
//satff proof
    notifyListeners();
  }

  Future clearProofDetails() async {
    proofImageFile = null;
    proofName = null;
    proofDate = null;
    expairyDate = null;
    proofID = null;
    proofNumber = null;
    remindDays = null;
    proofImage = null;
    notifyListeners();
  }

  @override
  notifyListeners();

  bool isAllChairs = true;
  bool isInworkChairs = false;
  bool isActiveChairs = false;
  bool isInactiveChairs = false;

  changeFilterOptions(value) {
    if (value == "all") {
      isAllChairs = true;
      isInworkChairs = false;
      isActiveChairs = false;
      isInactiveChairs = false;
    } else if (value == 'inwork') {
      isAllChairs = false;
      isInworkChairs = true;
      isActiveChairs = false;
      isInactiveChairs = false;
    } else if (value == 'active') {
      isAllChairs = false;
      isInworkChairs = false;
      isActiveChairs = true;
      isInactiveChairs = false;
    } else {
      isAllChairs = false;
      isInworkChairs = false;
      isActiveChairs = false;
      isInactiveChairs = true;
    }
    notifyListeners();
  }

  List<StaffProofModel> staffProofs = [];

  deleteItem(String proofNumber) {
    staffProofs.removeWhere((element) => element.proofNo == proofNumber);
    notifyListeners();
  }

  Future addBillItem(context) async {
    ProgressDialog.show(context: context);
    StaffProofModel proofModel = StaffProofModel(
        proofName: proofName ?? "",
        proofNo: proofNumber ?? "",
        proofDate: proofDate!,
        expDate: expairyDate!,
        img: proofImage ?? "");
/*     BillItemModel billItemModel = BillItemModel(
        itemName: itemName, qty: qty, rate: rate, amount: amount, type: type); */
    staffProofs.add(proofModel);
    ProgressDialog.hide(context);
    notifyListeners();
  }

  List<StaffProofModel> tempProoTable = [];

  // void onOpening(List<Proof> proofs) {
  //   List<StaffProofModel> proofModels =
  //       proofs.map((proof) => StaffProofModel.fromJson2(proof)).toList();
  //   tempProoTable = proofModels;
  // }
/*   void onOpening(List<Proof> proofs) {
    List<StaffProofModel> proofModels = proofs.map((proof)  {
      return StaffProofModel(
        proofName: proof.proofName,
        proofNo: proof.proofNo,
        proofDate: DateTime.parse(proof.proofDate),
        expDate: DateTime.parse(proof.expDate),
        img:await loadImage(proof.img), // Set your default value here
      );
    }).toList();

    tempProoTable = proofModels;
  }

  Future loadImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final List<int> imageBytes = response.bodyBytes;

    return base64Encode(imageBytes);
  } */
  Future onOpening(List<Proof> proofs) async {
    List<StaffProofModel> proofModels = await Future.wait(
      proofs.map((proof) async {
        return StaffProofModel(
          proofName: proof.proofName,
          proofNo: proof.proofNo,
          proofDate: DateTime.parse(proof.proofDate),
          expDate: DateTime.parse(proof.expDate),
          img: await loadImage(proof.img),
        );
      }),
    );

    tempProoTable = proofModels;
  }

/*   Future<String> loadImage(String imageUrl) async {
    // Simulate an asynchronous operation, such as loading an image from a network
    await Future.delayed(const Duration(seconds: 2));

    // Replace this with the actual logic to load the image
    return 'base64_encoded_image'; // Example result
  } */
  Future loadImage(String imageUrls) async {
    final response = await http.get(Uri.parse(imageUrl + imageUrls));
    final List<int> imageBytes = response.bodyBytes;
    log(base64Encode(imageBytes).toString(), name: "Base64");
    return base64Encode(imageBytes);
  }

/*
void updateProofInList(List<StaffProofModel> tempProoTable, String id, StaffProofModel updatedProof) {
  int index = tempProoTable.indexWhere((proof) => proof.proofNo == id);

  if (index != -1) {
    tempProoTable[index] = updatedProof;
    print('Proof updated successfully.');
  } else {
    print('Proof with id $id not found.');
  }
} */
  Future updateTempProof({
    required newproofName,
    required newproofNumber,
    required newproofDate,
    required newexpairyDate,
    required newproofImage,
    required oldproofNumber,
    required BuildContext context,
  }) async {
    ProgressDialog.show(context: context, status: 'Updating');
    StaffProofModel proofModel = StaffProofModel(
        proofName: newproofName ?? "",
        proofNo: newproofNumber ?? "",
        proofDate: newproofDate!,
        expDate: newexpairyDate!,
        img: newproofImage ?? "");
/*     BillItemModel billItemModel = BillItemModel(
        itemName: itemName, qty: qty, rate: rate, amount: amount, type: type); */
    int index =
        tempProoTable.indexWhere((proof) => proof.proofNo == oldproofNumber);

    if (index != -1) {
      // ProgressDialog.hide(context);
      tempProoTable[index] = proofModel;
      // print('Proof updated successfully.');
    } else {
      //  ProgressDialog.hide(context);
      // print('Proof with id $oldproofNumber not found.');
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future addToTemTable() async {
    StaffProofModel proofModel = StaffProofModel(
        proofName: proofName ?? "",
        proofNo: proofNumber ?? "",
        proofDate: proofDate!,
        expDate: expairyDate!,
        img: proofImage ?? "");
    tempProoTable.add(proofModel);

    notifyListeners();
  }

  deleteProof(String proofNumber) {
    if (tempProoTable.length == 1) {
      Fluttertoast.showToast(msg: "Can't delete all proofs");
    } else {
      tempProoTable.removeWhere((element) => element.proofNo == proofNumber);
    }
    notifyListeners();
  }
}
