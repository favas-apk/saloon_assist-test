// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/reportsControllers.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/widgets/textFormFieldWidget.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController expenseReason = TextEditingController();
  TextEditingController amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    context.read<ShopController>().setIsAdmin();
    dateinput.text = DateFormat('yyyy-MM-dd').format(
      DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense',
          style: whiteText,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding:
              isMobile ? const EdgeInsets.all(8.0) : const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: TextField(
                        controller:
                            dateinput, //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon:
                                Icon(Icons.calendar_today), //icon of text field
                            labelText:
                                "Choose Expense Date" //label text of field
                            ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            /*   print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000 */
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            // print(
                            //     formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              dateinput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            // print("Date is not selected");
                          }
                        },
                      ),
                    ),
                  ),

                  /*  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        final text = newValue.text;
                        return text.isEmpty
                            ? newValue
                            : double.tryParse(text) == null
                                ? oldValue
                                : newValue;
                      }),
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      labelText: 'Expense Amount',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ), */
                  TextFormFieldWidget(
                    validator: (v) {
                      if (v == "0" || v!.isEmpty) {
                        return "expense amount can't be empty";
                      } else {
                        return null;
                      }
                    },
                    controller: amount,
                    type: TextInputType.number,
                    hintText: 'Expense Amount',
                  ),
                  space(context),
                  TextFormFieldWidget(
                    controller: expenseReason,
                    maxLine: isMobile ? 3 : 5,
                    hintText: 'Expense reason',
                  ),
                  space(context),
                  Consumer<ReportController>(builder: (context, val, child) {
                    return SizedBox(
                      height: isMobile ? 45 : 60,
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await val
                                .addExpense(
                                    context: context,
                                    date: dateinput.text,
                                    reason: expenseReason.text,
                                    amount: amount.text)
                                .then(
                                  (value) => amount.clear(),
                                );
                          } else {}
                        },
                        child: Text(
                          'Add Expense',
                          style: whiteText,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
