// ignore_for_file: file_names, must_be_immutable

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/bill_controller.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/views/edit_bill.dart';

class ViewAllBills extends StatefulWidget {
  const ViewAllBills({
    super.key,
  });

  @override
  State<ViewAllBills> createState() => _ViewAllBillsState();
}

class _ViewAllBillsState extends State<ViewAllBills> {
  String staffId = "";

  @override
  Widget build(BuildContext context) {
    // bool isMobile = Responsive.isMobile(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Bills",
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
                              labelText: "Select a staff"),
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
            child: Consumer<BillController>(builder: (context, va, c) {
              return Container(
                padding: const EdgeInsets.all(2),
                child: FutureBuilder(
                    future: va.getBillDetails(
                        staffId: staffId,
                        shopId: context.read<ShopController>().model!.shopId),
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
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                var currentData = snapshot.data[index];
                                return InkWell(
                                  onTap: () async {
                                    final result =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => EditBill(
                                            data: currentData,
                                            staffid: staffId),
                                      ),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        staffId = result.toString();
                                      });
                                    } else {}
                                  },
                                  child: Card(
                                    color: klightblueBg,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Row(
                                        children: [
                                          const VerticalDivider(
                                              color: Colors.transparent),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            height: 2),
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              "B.No : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            ),
                                                            Text(
                                                              currentData[
                                                                      "BillNo"]
                                                                  .toString()
                                                                  .toUpperCase(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 2),
                                                        Text(
                                                          currentData[
                                                              "EntryDate"],
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black54),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const Divider(
                                                  color: Color.fromARGB(
                                                      17, 0, 0, 0),
                                                  height: 4,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text('Amount'),
                                                        Text(
                                                          currentData[
                                                                  "Amount"] +
                                                              ".00",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text("Cash"),
                                                        const Divider(
                                                          color: Colors
                                                              .transparent,
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          currentData["Cash"] +
                                                              ".00",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    const VerticalDivider(),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text("Card"),
                                                        const Divider(
                                                          color: Colors
                                                              .transparent,
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          currentData["Card"] +
                                                              ".00",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    const VerticalDivider(
                                                        color:
                                                            Colors.transparent),
                                                  ],
                                                ),
                                                const SizedBox(height: 2),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text("Error"),
                          );
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

  /*  TableRow buildRow(List<String> cells,
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

 */
}
