// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloon_assist/api/apiController.dart';
import 'package:saloon_assist/models/itemModel.dart';
import 'package:saloon_assist/models/productModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController with ChangeNotifier {
  //test
  String? productName;
  String? category;
  String? details;
  String? rate;
  String? type;
  String? tax;
  setProduct(va) {
    productName = va;
    notifyListeners();
  }

  setType(va) {
    type = va;
    notifyListeners();
  }

  setTax(va) {
    tax = va;
    notifyListeners();
  }

  setDetails(va) {
    details = va;
    notifyListeners();
  }

  setCategory(va) {
    category = va;
    notifyListeners();
  }

  setRate(va) {
    rate = va;
    notifyListeners();
  }

  List<Map<String, dynamic>> products = [
    /*  {'product': 'face cream', 'productcat': 'cosmetics', 'rate': '150'},
    {'product': 'face wash', 'productcat': 'cosmetics', 'rate': '200'}, */
  ];
/*   Future addProduct() async {
    if (productName != null && category != null && rate != null) {
      Map<String, dynamic> map = {};
      map['id'] =
          DateTime.now().millisecondsSinceEpoch; // Random().nextInt(10);
      map['product'] = productName;
      map['productcat'] = category;
      map['rate'] = rate;
      products.add(map);
      notifyListeners();
    } 
  }*/

  Future deleteProduct({required int index}) async {
    products.removeAt(index);
    //products.removeWhere((element) => element["id"] == id);
    // log(products);

    notifyListeners();
  }

  Future<List<ProductModel>> getAllProduts() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
    List<ProductModel> result = await ApiController().getAllitems(
      id.toString(),
    );
    // print(result);
    return result;
  }

  Future addNewProduct(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
    var result = await ApiController().addProduct(
      context,
      ItemModel(
        itemName: productName.toString(),
        type: type.toString(),
        category: category.toString(),
        rate: rate.toString(),
        tax: tax ?? "0",
        details: details.toString(),
        shopId: id.toString(),
      ),
    );
    if (result[0]['status']) {
      Fluttertoast.showToast(msg: 'Item added');
    } else {
      Fluttertoast.showToast(msg: 'Failed to add $productName');
    }
    notifyListeners();
  }

  Future updateProduct(
    BuildContext context, {
    required String newProductName,
    required String newCategory,
    required String newRate,
    required String newType,
    required String newTax,
    required String newDetails,
    required String itemId,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('ShopId');
    var result = await ApiController().updateProduct(
      ItemModel(
        itemName: newProductName,
        type: newType,
        category: newCategory,
        rate: newRate,
        tax: newTax,
        details: newDetails,
        shopId: id.toString(),
        itemId: itemId,
      ),
    );
    if (result['status']) {
      Fluttertoast.showToast(msg: 'Item Updated');
    } else {
      Fluttertoast.showToast(msg: result['message']);
    }
    notifyListeners();
  }

  Future clearDatas() async {
    productName = null;
    category = null;
    details = null;
    rate = null;
    type = null;
    tax = null;
    notifyListeners();
  }
}
