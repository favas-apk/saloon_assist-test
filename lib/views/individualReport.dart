// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/reportsControllers.dart';
import 'package:string_validator/string_validator.dart';

class IndividualReports extends StatefulWidget {
  const IndividualReports({super.key});

  @override
  State<IndividualReports> createState() => _IndividualReportsState();
}

class _IndividualReportsState extends State<IndividualReports> {
  int billCount = 0;
  int totalAmount = 0;

  final TextEditingController satrtDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
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
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
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
                ],
              ),
              divider,
              divider,
              Expanded(
                child:
                    Consumer<ReportController>(builder: (context, val, child) {
                  return FutureBuilder(
                      future: val.getIndividualReport(
                          startDate: satrtDate.text.toString() == "null" ||
                                  satrtDate.text.toString() == ""
                              ? DateFormat('yyyy-MM-dd')
                                  .format(DateTime(DateTime.now().day - 1))
                              : satrtDate.text,
                          endDate: endDate.text.toString() == "null" ||
                                  endDate.text.toString() == ""
                              ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                              : endDate.text,
                          staffId: 0),
                      builder: (context, snapshot) {
                        var data = snapshot.data;
                        if (snapshot.hasData) {
                          billCount = 0;
                          totalAmount = 0;
                          for (int i = 0; i <= data.length - 1; i++) {
                            billCount =
                                billCount + int.parse(data[i]["BillCount"]);
                            totalAmount =
                                totalAmount + int.parse(data[i]["Amount"]);
                          }
                          return Column(
                            children: [
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(4),
                                  2: FlexColumnWidth(2),
                                  3: FlexColumnWidth(4),
                                },
                                children: [
                                  buildRow(["S.No", 'NAME', 'COUNT', "AMOUNT"],
                                      index: 0, isHeader: true),
                                ],
                              ),
                              Expanded(
                                  child: ListView.builder(
                                padding: const EdgeInsets.all(0),
                                physics: const NeverScrollableScrollPhysics(),
                                controller: ScrollController(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  var currentData = snapshot.data[index];
                                  return Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(4),
                                      2: FlexColumnWidth(2),
                                      3: FlexColumnWidth(4),
                                    },
                                    children: [
                                      buildRow([
                                        ' ${index + 1}',
                                        currentData['StaffName'],
                                        currentData['BillCount'],
                                        currentData['Amount'] + ".00",
                                      ], index: index + 1)
                                    ],
                                  );
                                },
                              )),
                              Table(
                                children: [
                                  buildRow([
                                    "TOTAL",
                                    "",
                                    billCount.toString(),
                                    "$totalAmount.00"
                                  ], index: 1, isHeader: true),
                                ],
                              ),
                            ],
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const Center(
                            child: Text("No Data "),
                          );
                        }
                      });
                }),
              ),
            ],
          ),
        ));
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
}
