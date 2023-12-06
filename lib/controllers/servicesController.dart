// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ServiceController with ChangeNotifier {
  String? serviceName;
  String? rate;
  setService(va) {
    serviceName = va;
    notifyListeners();
  }

  setRate(va) {
    rate = va;
    notifyListeners();
  }

  List<Map<String, dynamic>> services = [
    /*  {'product': 'face cream', 'productcat': 'cosmetics', 'rate': '150'},
    {'product': 'face wash', 'productcat': 'cosmetics', 'rate': '200'}, */
  ];
  Future addService() async {
    if (serviceName != null && rate != null) {
      Map<String, dynamic> map = {};
      map['id'] = DateTime.now().millisecondsSinceEpoch;
      map['service'] = serviceName;
      map['charge'] = rate;
      services.add(map);
      notifyListeners();
    }
  }

  Future deleteService({required int index}) async {
    services.removeAt(index);
    notifyListeners();
  }
}
