// ignore_for_file: file_names, must_be_immutable

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/reportsControllers.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:string_validator/string_validator.dart';

class EmployeeReports extends StatefulWidget {
  const EmployeeReports({super.key});

  @override
  State<EmployeeReports> createState() => _EmployeeReportsState();
}

class _EmployeeReportsState extends State<EmployeeReports> {
  final TextEditingController satrtDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  String staffId = "";
  int totalAmount = 0;
  int cash = 0;
  int card = 0;
  @override
  void initState() {
    super.initState();
    satrtDate.text = DateFormat('yyyy-MM-dd').format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 1));
    endDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isTab = Responsive.isTablet(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Employee report",
          style: whiteText,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: primaryColor),
      ),
      body: Column(
        children: [
          const Divider(
            color: Colors.transparent,
          ),
          SizedBox(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 80,
                    child: Center(
                      child: TextField(
                        controller: satrtDate,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "From Date"),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);

                            setState(() {
                              satrtDate.text = formattedDate;
                            });
                          } else {}
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  child: Center(
                    child: Text("TO"),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 80,
                    child: Center(
                      child: TextField(
                        controller: endDate,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "To Date"),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);

                            setState(() {
                              endDate.text = formattedDate;
                            });
                          } else {}
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !isMobile && !isTab,
                  child: Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: 90,
                      child: Center(
                        child: Consumer<ShopController>(
                            builder: (context, value, child) {
                          return Center(
                            child: DropDownTextField(
                              clearOption: false,
                              onChanged: (c) {
                                setState(() {
                                  staffId = c.value;
                                  // staffName = c.name;
                                });
                              },
                              dropDownList: value.staffs,
                              textFieldDecoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: "Staff..."),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isMobile || isTab,
            child: Container(
              padding: const EdgeInsets.all(15),
              height: 90,
              child: Center(
                child:
                    Consumer<ShopController>(builder: (context, value, child) {
                  return Center(
                    child: DropDownTextField(
                      clearOption: false,
                      onChanged: (c) {
                        c == ""
                            ? ""
                            : setState(() {
                                staffId = c.value;
                                // staffName = c.name;
                              });
                      },
                      dropDownList: value.staffs,
                      textFieldDecoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Staff..."),
                    ),
                  );
                }),
              ),
            ),
          ),
          divider,
          Expanded(
            child: Consumer<ReportController>(builder: (context, va, c) {
              return Container(
                padding: const EdgeInsets.all(2),
                child: FutureBuilder(
                    future: va.getEmployeeOverallReport(
                      startDate: satrtDate.text.toString() == "null" ||
                              satrtDate.text.toString() == ""
                          ? DateFormat('yyyy-MM-dd')
                              .format(DateTime(DateTime.now().day - 1))
                          : satrtDate.text,
                      endDate: endDate.text.toString(),
                      staffId: staffId,
                      shopId: context.read<ShopController>().model!.shopId,
                    ),
                    builder: (context, snapshot) {
                      if (staffId == "") {
                        return const Center(
                          child: Text(
                            "Choose a staff",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black38),
                          ),
                        );
                      } else {
                        if (snapshot.hasData) {
                          // billCount = 0;
                          var data = snapshot.data;
                          totalAmount = 0;
                          cash = 0;
                          card = 0;
                          for (int i = 0; i <= data.length - 1; i++) {
                            totalAmount =
                                totalAmount + int.parse(data[i]["Amount"]);
                            cash = cash + int.parse(data[i]["Cash"]);
                            card = card + int.parse(data[i]["Card"]);
                          }

                          return Column(
                            children: [
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(4),
                                  1: FlexColumnWidth(4),
                                  2: FlexColumnWidth(4),
                                  3: FlexColumnWidth(4),
                                  4: FlexColumnWidth(4),
                                },
                                children: [
                                  buildRow([
                                    'Date',
                                    'Amount',
                                    'Cash',
                                    'Card',
                                  ], index: 0, isHeader: true),
                                ],
                              ),
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(0),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    var currentData = snapshot.data[index];
                                    return Table(
                                      columnWidths: const {
                                        // 0: FlexColumnWidth(4),
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(3),
                                        2: FlexColumnWidth(3),
                                        3: FlexColumnWidth(4),
                                      },
                                      /*   border:
                                      TableBorder.all(color: Colors.black12), */
                                      children: [
                                        buildRow([
                                          /*    currentData['StaffName'], */
                                          currentData['EntryDate'],
                                          currentData['Amount'] + ".00",
                                          currentData['Cash'] + ".00",
                                          currentData['Card'] + ".00",
                                          // currentData['CheckoutTime'],
                                        ], index: index + 1)
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Table(
                                children: [
                                  buildRow([
                                    "TOTAL",
                                    "$totalAmount.00",
                                    "$cash.00",
                                    "$card.00",
                                  ], index: 1, isHeader: true),
                                ],
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text("Error"),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                    }),
              );
            }),
          ),
          /*  ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CLOSE',
              style: whiteText,
            ),
          ), */
        ],
      ),
    );
  }

  TableRow buildRow(List<String> cells,
          {bool isHeader = false, required int index}) =>
      TableRow(
          children: cells.map((cell) {
        return isHeader
            ? Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(cell,
                      overflow: TextOverflow.ellipsis,
                      style: isHeader
                          ? const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white)
                          : const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 10),
                      textAlign: TextAlign.center),
                ),
              )
            : Container(
                padding: const EdgeInsets.all(8),
                color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                child: Text(
                  cell,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: cell.contains(RegExp(r'[a-z]'))
                          ? Colors.black
                          : Colors.black),
                  textAlign: isDate(cell) || cell.contains(RegExp(r'[a-z]'))
                      ? TextAlign.left
                      : TextAlign.right,
                ),
              );
      }).toList());
}
