// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/api/apiController.dart';
import 'package:saloon_assist/bottomNavigation.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/models/create_Shop_Model.dart';
import 'package:saloon_assist/models/shopModel.dart';
import 'package:saloon_assist/views/loginScreen.dart';
import 'package:saloon_assist/views/splashScreen.dart';
import 'package:saloon_assist/views/staff/staff_home_page.dart';
import 'package:saloon_assist/widgets/progressDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends ChangeNotifier {
  String? userName;
  String? password;
  bool isVisible = true;
  showPasword() {
    isVisible = !isVisible;
    notifyListeners();
  }

  setUserName(value) {
    userName = value;
    notifyListeners();
  }

  setPassword(value) {
    password = value;
    notifyListeners();
  }

  Future checkLogin(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? status = preferences.getBool('logged');
    bool? isAdmin = preferences.getBool('isAdmin');
    if (status == true && isAdmin == true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (ctx) => BottomNavigation(),
          ),
          (route) => false);
    } else if (status == true && isAdmin == false) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (ctx) => StaffHomeScreen(
              page: 0,
            ),
          ),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (ctx) => const LoginScreen(),
          ),
          (route) => false);
    }
    notifyListeners();
  }

  Future login(BuildContext context) async {
    ProgressDialog.show(context: context, status: 'Checking');
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = await ApiController().login(
      username: userName.toString().trim(),
      password: password.toString().trim(),
    );
    ProgressDialog.hide(context);
    if (data[0]['status']) {
      bool isAdmin = data[0]["UserType"] == "SHOP-ADMIN" ? true : false;

      ShopModel shopModel = shopModelFromJson(jsonEncode(data[0]));
      context.read<ShopController>().initShopModel(shopModel);
      Fluttertoast.showToast(msg: 'Success', gravity: ToastGravity.CENTER);
      saveLogin(true, userName.toString().trim(), password.toString().trim(),
              shopModel.shopId, isAdmin)
          .then(
        (value) {
          return isAdmin
              ? Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => BottomNavigation(),
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
        },
      );
    } else {
      ProgressDialog.hide(context);
      Fluttertoast.showToast(
          msg: data[0]['result'], gravity: ToastGravity.CENTER);
      // Fluttertoast.s
    }
  }

  saveLogin(bool value, String username, String password, String shopid,
      bool isAdmin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('logged', value);
    preferences.setString('username', username);
    preferences.setString('password', password);
    await preferences.setString('ShopId', shopid);
    await preferences.setBool("isAdmin", isAdmin);
  }

  /*  getLogin()async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    preferences.getBool('logged');
  } */
  logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('logged', false).then(
          (value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (ctx) => const SplashScreen(),
              ),
              (route) => false),
        );
  }

//create shop
  String shopName = "";
  String companyId = "";
  String address = "";
  String contact = "";
  String email = "";
  String regnNo = "";
  String pinCode = "";
  String latitude = "";
  String longitude = "";
  String startTime = "";
  String closingTime = "";
  String contryCode = "";
  String currency = "";
  // String holyDays = "";
  String category = "";
  String img1 = "";
  String img2 = "";
  String img3 = "";
  File? imageOne;
  File? imagetwo;
  File? imageThree;
  bool isSun = false;
  bool isMon = false;
  bool isTu = false;
  bool isWed = false;
  bool isTh = false;
  bool isFri = false;
  bool isSat = false;
  /* Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, and Saturday */
  List<String> holyDays = [];

  Future clear() async {
    imageCache.clear();
    shopName = "";
    companyId = "";
    address = "";
    contact = "";
    email = "";
    regnNo = "";
    pinCode = "";
    latitude = "";
    longitude = "";
    startTime = "";
    closingTime = "";
    contryCode = "";
    currency = "";
    category = "";
    img1 = "";
    img2 = "";
    img3 = "";
    imageOne = null;
    imagetwo = null;
    imageThree = null;
    isSun = false;
    isMon = false;
    isTu = false;
    isWed = false;
    isTh = false;
    isFri = false;
    isSat = false;
    holyDays = [];
    notifyListeners();
  }

  setSunday() {
    isSun = !isSun;
    if (holyDays.toString().contains("Sunday")) {
      holyDays.removeWhere((element) => element == "Sunday");
    } else {
      holyDays.add("Sunday");
    }
    notifyListeners();
  }

  setMonday() {
    isMon = !isMon;
    if (holyDays.toString().contains("Monday")) {
      holyDays.removeWhere((element) => element == "Monday");
    } else {
      holyDays.add("Monday");
    }
    notifyListeners();
  }

  setTuesday() {
    isTu = !isTu;
    if (holyDays.toString().contains("Tuesday")) {
      holyDays.removeWhere((element) => element == "Tuesday");
    } else {
      holyDays.add("Tuesday");
    }
    notifyListeners();
  }

  setWednesday() {
    isWed = !isWed;
    if (holyDays.toString().contains("Wednesday")) {
      holyDays.removeWhere((element) => element == "Wednesday");
    } else {
      holyDays.add("Wednesday");
    }
    notifyListeners();
  }

  setThursday() {
    isTh = !isTh;
    if (holyDays.toString().contains("Thursday")) {
      holyDays.removeWhere((element) => element == "Thursday");
    } else {
      holyDays.add("Thursday");
    }
    notifyListeners();
  }

  setFriday() {
    isFri = !isFri;
    if (holyDays.toString().contains("Friday")) {
      holyDays.removeWhere((element) => element == "Friday");
    } else {
      holyDays.add("Friday");
    }
    notifyListeners();
  }

  setSaturday() {
    isSat = !isSat;
    if (holyDays.toString().contains("Saturday")) {
      holyDays.removeWhere((element) => element == "Saturday");
    } else {
      holyDays.add("Saturday");
    }
    notifyListeners();
  }

  Future pickFirstimage(ImageSource source, BuildContext context) async {
    ProgressDialog.show(context: context);
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

        imageOne = File(selected.path);
        img1 = base64Encode(
          selected.readAsBytesSync(),
        );
      } else {
        Fluttertoast.showToast(msg: "Failed to add image");
      }
    } else {
      Fluttertoast.showToast(msg: "Failed to add image");
    }

    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future pickSecondimage(ImageSource source, BuildContext context) async {
    ProgressDialog.show(context: context);
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
        imagetwo = File(selected.path);
        img2 = base64Encode(selected.readAsBytesSync());
      } else {
        Fluttertoast.showToast(msg: "Failed to add image");
      }
    } else {
      Fluttertoast.showToast(msg: "Failed to add image");
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future pickThirdimage(ImageSource source, BuildContext context) async {
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

        imageThree = File(selected.path);
        img3 = base64Encode(selected.readAsBytesSync());
      } else {
        Fluttertoast.showToast(msg: "Failed to add image");
      }
    } else {
      Fluttertoast.showToast(msg: "Failed to add image");
    }

    ProgressDialog.hide(context);
    notifyListeners();
  }

  setshopName(value) {
    shopName = value;
    notifyListeners();
  }

  setaddress(value) {
    address = value;
    notifyListeners();
  }

  setcontact(value) {
    contact = value;
    notifyListeners();
  }

  setemail(value) {
    email = value;
    notifyListeners();
  }

  setregnNo(value) {
    regnNo = value;
    notifyListeners();
  }

  setpinCode(value) {
    pinCode = value;
    notifyListeners();
  }

  setlatitude(value) {
    latitude = value;
    notifyListeners();
  }

  setlongitude(value) {
    longitude = value;
    notifyListeners();
  }

  setstartTime(value) {
    startTime = value;
    notifyListeners();
  }

  setclosingTime(value) {
    closingTime = value;
    notifyListeners();
  }

  setholyDays(value) {
    holyDays = value;
    notifyListeners();
  }

  setcategory(value) {
    category = value;
    notifyListeners();
  }

  setimg1(value) {
    img1 = value;
    notifyListeners();
  }

  setimg2(value) {
    img2 = value;
    notifyListeners();
  }

  setimg3(value) {
    img3 = value;
    notifyListeners();
  }

  setContryCode(value) {
    contryCode = value;
    notifyListeners();
  }

  setCurrency(value) {
    currency = value;
    notifyListeners();
  }

  String separateWithComma(List<String> stringList) {
    return stringList.join(', ');
  }

  Future deleteShop(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
    var data = await ApiController().deleteShops(
      shopid: id.toString(),
    );
    // print(data);
    if (data.toString().contains("Shop Deleted")) {
      preferences.clear().then(
            (value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const SplashScreen(),
                ),
                (route) => false),
          );
    } else {
      Fluttertoast.showToast(msg: data);
    }
  }

  createShop(BuildContext context) async {
    ProgressDialog.show(context: context);
    var data = await ApiController().createShops(
        createShopModel: CreateShopModel(
            address: address,
            category: category,
            closingTime: closingTime,
            companyId: "1",
            contact: contact,
            contryCode: contryCode,
            curencyName: currency,
            email: email,
            holyDays: separateWithComma(holyDays), // holyDays.toString(),
            img1: img1,
            img2: img2,
            img3: img3,
            password: password.toString(),
            pinCode: pinCode,
            regnNo: regnNo,
            shopName: shopName,
            startTime: startTime,
            userName: userName.toString(),
            latitude: latitude,
            longitude: longitude));
    ProgressDialog.hide(context);
    if (data[0]['status']) {
      Fluttertoast.showToast(
              msg: data[0]["result"], gravity: ToastGravity.CENTER)
          .then(
            (value) => clear(),
          )
          .then(
            (value) => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                (route) => false),
          );
    } else {
      Fluttertoast.showToast(
          msg: data[0]["result"], gravity: ToastGravity.CENTER);
    }
    // print(data.toString());
  }
}
