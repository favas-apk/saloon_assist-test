// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/bill_controller.dart';
import 'package:saloon_assist/controllers/shopController.dart';

class EditBill extends StatefulWidget {
  EditBill({super.key, required this.data, required this.staffid});
  var data;
  var staffid;

  @override
  State<EditBill> createState() => _EditBillState();
}

dynamic formKey;

class _EditBillState extends State<EditBill> {
  @override
  void initState() {
    super.initState();
    context.read<BillController>().setDetails(
          data: widget.data,
          taxPercentage: int.parse(context.read<ShopController>().model!.tax),
        );
    formKey = GlobalKey<FormState>();
    cashController.text = widget.data["Cash"];
    cardController.text = widget.data["Card"];
  }

  final cashController = TextEditingController();
  final cardController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update bill",
          style: whiteText,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Consumer<BillController>(builder: (context, value, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: value.billAmount,
                          validator: (data) {
                            if (data!.isEmpty) {
                              return "Bill amount required";
                            } else if (double.parse(
                                        value.cash ?? widget.data["Cash"]) +
                                    double.parse(
                                        value.card ?? widget.data["Card"]) !=
                                double.parse(value.grandTotal)) {
                              /*  print(double.parse(
                                      value.cash ?? widget.data["Cash"]) +
                                  double.parse(
                                      value.card ?? widget.data["Card"])); */
                              return 'Please recheck amount';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (values) {
                            context.read<BillController>().setBillAmount(
                                  values.isEmpty ? "0" : values,
                                  int.parse(context
                                      .read<ShopController>()
                                      .model!
                                      .tax),
                                );
                            cashController.text = value.grandTotal;
                            cardController.text = "";
                          },
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: 'Bill Amount',
                              labelText: "Bill Amount"),
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: TextFormField(
                          key: Key(value.taxAmounts.toString()),
                          initialValue: value.taxAmounts,
                          readOnly: true,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey[100],
                            labelText: "Tax Amount",
                            hintStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            suffix: Text(
                              "${context.read<ShopController>().model!.curencyName}  ",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const Divider(
                  color: Colors.transparent,
                ),
                Consumer<BillController>(builder: (context, value, c) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          key: Key(value.grandTotal.toString()),
                          initialValue: value.grandTotal,
                          readOnly: true,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey[100],
                            labelText: "GRAND TOTAL",
                            hintStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            suffix: Text(
                              "${context.read<ShopController>().model!.curencyName}  ",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const Divider(
                  color: Colors.transparent,
                ),
                Consumer<BillController>(builder: (context, value, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cashController,
                          //initialValue: widget.data["Cash"],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          onChanged: (p0) {
                            cardController.text = value.setCashAmount(
                                p0.isEmpty || p0 == "." ? "0" : p0);
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey[100],
                            hintText: 'CASH AMOUNT',
                            labelText: "Cash",
                            hintStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            suffix: Text(
                              context.read<ShopController>().model!.curencyName,
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: TextFormField(
                          controller: cardController,
                          // initialValue: widget.data["Card"],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          /*     validator: (data) {
                            if (value.cash! + value.card =
                                double.parse(
                                  value.billAmount.toString(),
                                )) {
                              return 'please recheck amount';
                            }
                            return null;
                          }, */
                          onChanged: (p0) {
                            cashController.text = value.setOtherPayAmount(
                                p0.isEmpty || p0 == "." ? "0.0" : p0);
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey[100],
                            hintText: 'BANK',
                            labelText: "Bank",
                            hintStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            suffix: Text(
                              "${context.read<ShopController>().model!.curencyName}  ",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 20),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: widget.data["Customer"],
                  onChanged: (value) {
                    context.read<BillController>().setCustomer(value);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Customer Name',
                      labelText: "Customer Name"),
                  keyboardType: TextInputType.text,
                ),
                space(context),
                TextFormField(
                  initialValue: widget.data["Mobile"],
                  onChanged: (value) {
                    context.read<BillController>().setNumber(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'Phone number',
                    labelText: "Number",
                    prefix: Text(
                        "${context.read<ShopController>().model!.contryCode}  "),
                  ),
                ),
                space(context),
                space(context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    height: 45,
                    width: double.maxFinite,
                    child: Consumer<BillController>(
                        builder: (context, billdata, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            await billdata.updateBill(
                                staffid: widget.staffid,
                                context: context,
                                bid: widget.data["BID"],
                                amount: billdata.billAmount ??
                                    widget.data["Amount"],
                                cash: billdata.cash ?? widget.data["Cash"],
                                card: billdata.card ?? widget.data["Card"],
                                name: billdata.customer ??
                                    widget.data["Customer"],
                                number:
                                    billdata.number ?? widget.data["Mobile"]);
                          }
                        },
                        child: const Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
