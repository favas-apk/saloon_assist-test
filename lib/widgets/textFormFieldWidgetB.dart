// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidgetB extends StatelessWidget {
  TextFormFieldWidgetB(
      {
        super.key,
      required this.hintText,
      this.labelText,
      this.maxLine = 1,
      this.onChanged,
      this.type = TextInputType.text,
      this.icon,
      this.validator,
      this.initialvalue,
      this.controller,
      this.readonly = false,
        this.formatter,


      }) ;
  String hintText;
  String? labelText;
  String? initialvalue;
  int? maxLine;
  TextInputType type;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController? controller;
  IconData? icon;
  bool readonly;
  List<TextInputFormatter>? formatter;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly,
      controller: controller,
      initialValue: initialvalue,
      validator: validator,
      onChanged: onChanged,
      keyboardType: type,
      maxLines: maxLine,
      decoration: InputDecoration(
        //    label: FaIcon(icon),
        // suffixIcon:
        // icon: FaIcon(icon),
        filled: true,
        fillColor: Colors.grey.shade300,
        labelText: hintText,
        // labelText: labelText,
        /*  label: Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade300,
          ),
          child: Text(
            hintText,
            style: const TextStyle(color: Colors.black),
          ),
        ), */
        // helperText: hintText,
        /*  labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          backgroundColor: Colors.white,
        ), */
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      inputFormatters:[
        //DecimalTextInputFormatter(),DecimalTextInputFormatterB(decimalRange: 2),
        FilteringTextInputFormatter.allow(RegExp('[0123456789]')),],

    );
  }
}
