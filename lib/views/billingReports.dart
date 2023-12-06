// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/controllers/reportsControllers.dart';
import 'package:string_validator/string_validator.dart';

class BillingReport extends StatefulWidget {
  const BillingReport({super.key});

  @override
  State<BillingReport> createState() => _BillingReportState();
}

class _BillingReportState extends State<BillingReport> {
  final TextEditingController satrtDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  int totalAmount = 0;
  @override
  void initState() {
    super.initState();
    satrtDate.text = DateFormat('yyyy-MM-dd').format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 1));
    endDate.text = DateFormat('yyyy-MM-dd').format(
      DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
            ],
          ),
          const Divider(
            color: Colors.transparent,
          ),
          const Divider(),
          Expanded(
            child: Consumer<ReportController>(builder: (context, va, c) {
              return Container(
                padding: const EdgeInsets.all(2),
                child: FutureBuilder(
                    future: va.getBillingReport(
                        startDate: satrtDate.text.toString() == "null" ||
                                satrtDate.text.toString() == ""
                            ? DateFormat('yyyy-MM-dd').format(DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day - 1))
                            : satrtDate.text,
                        endDate: endDate.text.toString() == "null" ||
                                endDate.text.toString() == ""
                            ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                            : endDate.text),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        totalAmount = 0;
                        for (int i = 0; i <= data.length - 1; i++) {
                          totalAmount =
                              totalAmount + int.parse(data[i]["Amount"]);
                        }
                        return Column(
                          children: [
                            Table(
                              columnWidths: const {
                                0: FlexColumnWidth(2),
                                1: FlexColumnWidth(4),
                                2: FlexColumnWidth(4),
                                3: FlexColumnWidth(4),
                                4: FlexColumnWidth(4),
                              },
                              children: [
                                buildRow(["S.NO", 'NAME', 'DATE', "AMOUNT"],
                                    isHeader: true, index: 0),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(0),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  var currentData = snapshot.data[index];
                                  return Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(4),
                                      2: FlexColumnWidth(4),
                                      3: FlexColumnWidth(4),
                                      4: FlexColumnWidth(4),
                                    },
                                    children: [
                                      buildRow([
                                        ' ${index + 1}',
                                        currentData['ItemName'],
                                        currentData['EntryDate'],
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
                        if (kDebugMode) {
                          print(snapshot.error);
                        }
                        return const Center(
                          child: Text("Error"),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const Center(
                          child: Text("Data not found"),
                        );
                      }
                    }),
              );
            }),
          ),
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
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
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
