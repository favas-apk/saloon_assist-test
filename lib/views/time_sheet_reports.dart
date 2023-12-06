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
import 'package:string_validator/string_validator.dart';

class TimeSheetReportScreen extends StatefulWidget {
  const TimeSheetReportScreen({super.key});

  @override
  State<TimeSheetReportScreen> createState() => _TimeSheetReportScreenState();
}

class _TimeSheetReportScreenState extends State<TimeSheetReportScreen> {
  final TextEditingController satrtDate = TextEditingController();
  /*  @override
  void dispose() {
    super.dispose();
    satrtDate.dispose();
    endDate.dispose();
  } */
  String staffId = "";
  int totalAmount = 0;
  @override
  void initState() {
    super.initState();
    satrtDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    // bool isMobile = Responsive.isMobile(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Time sheet reports",
          style: whiteText,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: primaryColor),
      ),
      body: Column(
        children: [
          const Divider(
            color: Colors.transparent,
          ),
          Row(
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
                          // icon: Icon(Icons.calendar_today),
                          labelText: "Date"),
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
                        } else {
                          // print("Date is not selected");
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                child: Center(
                  child: Text(":"),
                ),
              ),
              Expanded(
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
            ],
          ),
          divider,
          Expanded(
            child: Consumer<ReportController>(builder: (context, va, c) {
              return Container(
                padding: const EdgeInsets.all(2),
                child: FutureBuilder(
                    future: va.getTimeSheetReports(
                        startDate: satrtDate.text.toString() == "null" ||
                                satrtDate.text.toString() == ""
                            ? DateFormat('yyyy-MM-dd')
                                .format(DateTime(DateTime.now().day - 1))
                            : satrtDate.text,
                        id: staffId),
                    builder: (context, snapshot) {
                      //     print(snapshot.data.toString());
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
                          for (int i = 0; i <= data.length - 1; i++) {
                            /*  billCount =
                              billCount + int.parse(data[i]["BillCount"]); */
                            totalAmount =
                                totalAmount + int.parse(data[i]["Amount"]);
                          }
                          return /* ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var currentData = snapshot.data[index];
                            return Card(
                              child: ListTile(
                                leading: const CircleAvatar(
                                    child: FaIcon(FontAwesomeIcons.chartLine)),
                                title: Text(currentData["ItemName"]),
                                subtitle: Text(currentData["EntryDate"]),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("AMOUNT"),
                                    Text(currentData["Amount"])
                                  ],
                                ),
                              ),
                            );
                          },
                        ); */
                              Column(
                            children: [
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(4),
                                  2: FlexColumnWidth(4),
                                  3: FlexColumnWidth(4),
                                  4: FlexColumnWidth(4),
                                },
                                /*    border: TableBorder.all(color: Colors.black26), */
                                children: [
                                  buildRow([
                                    'S.N',
                                    "Bill.No",
                                    'Check-In',
                                    'Check-Out',
                                    "AMOUNT"
                                  ], index: 0, isHeader: true),
                                ],
                              ),
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(0),
                                  // physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    var currentData = snapshot.data[index];
                                    return Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(2),
                                        1: FlexColumnWidth(3),
                                        2: FlexColumnWidth(4),
                                        3: FlexColumnWidth(4),
                                        4: FlexColumnWidth(4),
                                      },
                                      /*   border:
                                      TableBorder.all(color: Colors.black12), */
                                      children: [
                                        buildRow([
                                          ' ${index + 1}',
                                          currentData['BillNo'].toString() ==
                                                  'null'
                                              ? "_"
                                              : currentData['BillNo']
                                                  .toString(),
                                          currentData['CheckInTime']
                                                      .toString() ==
                                                  "null"
                                              ? "00:00"
                                              : slitTime(
                                                  originalString:
                                                      currentData['CheckInTime']
                                                          .toString(),
                                                ),
                                          currentData['CheckoutTime']
                                                      .toString() ==
                                                  "null"
                                              ? "00:00"
                                              : slitTime(
                                                  originalString: currentData[
                                                          'CheckoutTime']
                                                      .toString()),
                                          currentData['Amount'] + ".00",
                                        ], index: index + 1)
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Table(
                                children: [
                                  buildRow(
                                      ["TOTAL", "", "", "", "$totalAmount.00"],
                                      index: 1, isHeader: true),
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
                          : const TextStyle(fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center),
                ),
              )
            : Container(
                padding: const EdgeInsets.all(8),
                color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                child: Text(
                  cell,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: cell.contains(RegExp(r'[a-z]'))
                          ? Colors.black
                          : Colors.black),
                  textAlign: isDate(cell) || cell.contains(RegExp(r'[a-z]'))
                      ? TextAlign.left
                      : TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
              );
      }).toList());
  String slitTime({required String originalString}) {
    if (originalString.toString() != "null") {
      List<String> parts =
          originalString != "" ? originalString.split(' ') : ["00:00:00", ""];
      String time = parts[0];
      List<String> timeParts = time.split(':');
      String trimmedString = "${timeParts[0]}:${timeParts[1]} ${parts[1]}";
      return trimmedString;
    } else {
      return originalString;
    }
    // print(trimmedString); // Output: 12:10 PM
  }
}
