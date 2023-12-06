// ignore_for_file: must_be_immutable, no_logic_in_create_state, unused_element, file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String _dialogMessage = "Loading...";

enum ProgressDialogType { normal }

ProgressDialogType _progressDialogType = ProgressDialogType.normal;

bool _isShowing = false;

class ProgressDialog {
  ProgressDialog(
      BuildContext buildContext, ProgressDialogType progressDialogtype) {
    _progressDialogType = progressDialogtype;
  }

  void setMessage(String mess) {
    _dialogMessage = mess;
  }

  bool isShowing() {
    return _isShowing;
  }

  static Future<void> hide(BuildContext context) async {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(context).pop();
    }
  }

  static Future show(
      {String status = 'loading', required BuildContext context}) async {
    if (!_isShowing) {
      final dialoge = _MyDialog(status);
      _isShowing = true;
      showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          context = context;
          return SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: dialoge,
          );
        },
      );
    }
  }
}

class _MyDialog extends StatefulWidget {
  final _dialog = _MyDialogState();
  var status = '';

  _MyDialog(this.status);

  update() {
    _dialog.changeState();
  }

  @override
  State<StatefulWidget> createState() {
    return _dialog;
  }
}

class _MyDialogState extends State<_MyDialog> {
  changeState() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _isShowing = false;
    debugPrint('ProgressDialog dismissed by back button');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpinKitDoubleBounce(
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.status,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
