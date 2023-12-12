// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saloon_assist/apiLinks/apiLinks.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/models/shopModel.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/views/edit_staff_screen.dart';

class ViewStaffDetails extends StatelessWidget {
  ViewStaffDetails({super.key, required this.data, this.proofData});

  Staff data;
  List<Proof>? proofData;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isTab = Responsive.isTablet(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Staff Details',
          style: whiteText,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding:
                isMobile ? const EdgeInsets.all(5) : const EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * .15,
            child: Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: SizedBox(
                              height: 250,
                              // width: double.maxFinite,
                              child: Stack(
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        imageUrl + data.img,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          shape: BoxShape.circle),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: CircleAvatar(
                    radius: 47,
                    backgroundColor: primaryColor,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(imageUrl + data.img),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.transparent,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      data.staffName.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const Divider(
                      height: 2,
                    ),
                    Text(
                      'Staff Id :${data.staffId.toUpperCase()}',
                      style: const TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    const Divider(
                      height: 2,
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),


                SizedBox(
                  height: isMobile ? 30 : 45,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title:
                              const Text('Do you want to edit the details ?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (c) => EditStaffScreen(
                                      proofData: proofData,
                                      data: data,
                                      isUpdate: true,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Yes'),
                            )
                          ],
                        ),
                      );
                    },
                    child: const Text('EDIT'),
                  ),
                )

              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.teal[50],
              padding: EdgeInsets.all(isMobile ? 8 : 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(isMobile ? 5 : 10),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: NewDetailsCard(
                            title: 'Name',
                            value: data.staffName.toUpperCase(),
                          ),
                        ),
                        VerticalDivider(
                          width: isMobile || isTab ? 2 : 10,
                        ),
                        Expanded(
                          child: NewDetailsCard(
                            title: 'Date of joining',
                            value: DateFormat('dd-MM-yyyy').format(data.doj),
                          ),
                        ),
                        Visibility(
                          visible: !isMobile && !isTab,
                          child: const VerticalDivider(),
                        ),
                        Visibility(
                          visible: !isTab && !isMobile,
                          child: Expanded(
                            child: NewDetailsCard(
                              title: 'Salary',
                              value: data.salary,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !isTab && !isMobile,
                          child: Expanded(
                            child: NewDetailsCard(
                              title: 'Email',
                              value: data.email == "null"
                                  ? "no email found"
                                  : data.email,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !isTab && !isMobile,
                          child: Expanded(
                            child: NewDetailsCard(
                              title: 'Phone',
                              value: data.mobile,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !isTab && !isMobile,
                          child: Expanded(
                            child: NewDetailsCard(
                              title: 'DOB',
                              value: DateFormat('dd-MM-yyyy').format(data.dob),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isTab || isMobile,
                      child: NewDetailsCard(
                        eleavtion: 0,
                        title: 'Salary',
                        value: data.salary,
                      ),
                    ),
                    Visibility(
                      visible: !isMobile && !isTab,
                      child: Card(
                        child: NewDetailsCard(
                          eleavtion: 0,
                          title: 'Address',
                          value: data.address == "null" ? "_" : data.address,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isTab || isMobile,
                      child: NewDetailsCard(
                        eleavtion: 0,
                        title: 'Email',
                        value: data.email == "null"
                            ? "email not found"
                            : data.email,
                      ),
                    ),
                    Visibility(
                      visible: isTab || isMobile,
                      child: NewDetailsCard(
                        eleavtion: 0,
                        title: 'Phone number',
                        value: data.mobile,
                      ),
                    ),
                    Visibility(
                      visible: isTab || isMobile,
                      child: NewDetailsCard(
                        eleavtion: 0,
                        title: 'Address',
                        value: data.address == "null" ? "_" : data.address,
                      ),
                    ),
                    Visibility(
                      visible: isTab || isMobile,
                      child: NewDetailsCard(
                        eleavtion: 0,
                        title: 'Date of birth',
                        value: DateFormat('dd-MM-yyyy').format(data.dob),
                      ),
                    ),
                    divider,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Proofs',
                        style: isTab || isMobile
                            ? poppinsStyleH2
                            : const TextStyle(
                                color: Colors.black, fontSize: 21),
                      ),
                    ),
                    Table(
                      border: TableBorder.all(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      children: [
                        TableRow(children: [
                          tablevalue("Proof", title: true),
                          tablevalue("Number", title: true),
                          tablevalue("Date", title: true),
                          tablevalue("Exp.Date", title: true),
                        ]),
                        for (final item in proofData!)
                          TableRow(children: [
                            tablevalue(item.proofName),
                            tablevalue(item.proofNo),
                            tablevalue(item.proofDate),
                            tablevalue(item.expDate),
                          ]),
                      ],
                    ),
                    /*  Card(
                      child: NewDetailsCard(
                        eleavtion: 0,
                        title: 'Proof type',
                        value: proofData != null ? proofData![0].proofName : "",
                      ),
                    ),
 */
                    /*  Visibility(
                      visible: !isTab && !isMobile,
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: NewDetailsCard(
                                eleavtion: 0,
                                title: 'Proof type',
                                value: proofData != null
                                    ? proofData![0].proofName
                                    : "",
                              ),
                            ),
                          ),
                          const VerticalDivider(color: Colors.transparent),
                          Expanded(
                            child: Card(
                              child: NewDetailsCard(
                                eleavtion: 0,
                                title: 'Proof Date',
                                value: proofData != null
                                    ? proofData![0].proofDate
                                    : "",
                              ),
                            ),
                          ),
                          const VerticalDivider(color: Colors.transparent),
                          Expanded(
                            child: Card(
                              child: NewDetailsCard(
                                eleavtion: 0,
                                title: 'Expiry Date',
                                value: proofData != null
                                    ? proofData![0].expDate
                                    : "",
                              ),
                            ),
                          ),
                          const VerticalDivider(color: Colors.transparent),
                          Expanded(
                            child: Card(
                              child: NewDetailsCard(
                                eleavtion: 0,
                                title: 'Proof number',
                                value: proofData != null
                                    ? proofData![0].proofNo
                                    : "",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isTab || isMobile,
                      child: NewDetailsCard(
                        eleavtion: 0,
                        title: 'Proof type',
                        value: proofData != null ? proofData![0].proofName : "",
                      ),
                    ),
                    Visibility(
                      visible: isTab || isMobile,
                      child: Row(
                        children: [
                          Expanded(
                            child: NewDetailsCard(
                              eleavtion: 0,
                              title: 'Proof Date',
                              value: proofData != null
                                  ? proofData![0].proofDate
                                  : "",
                            ),
                          ),
                          Expanded(
                            child: NewDetailsCard(
                              eleavtion: 0,
                              title: 'Expiry Date',
                              value: proofData != null
                                  ? proofData![0].expDate
                                  : "",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isMobile || isTab,
                      child: NewDetailsCard(
                        eleavtion: 0,
                        title: 'Proof number',
                        value: proofData != null ? proofData![0].proofNo : "",
                      ),
                    ), */
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tablevalue(String value, {bool title = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          value,
          style: TextStyle(
              fontSize: title ? 14 : 12,
              fontWeight: title ? FontWeight.bold : FontWeight.normal),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class NewDetailsCard extends StatelessWidget {
  const NewDetailsCard({
    super.key,
    required this.title,
    required this.value,
    this.eleavtion,
  });

  final String title;
  final String value;
  final double? eleavtion;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isTab = Responsive.isTablet(context);
    return Card(
      elevation: eleavtion,
      child: Padding(
        padding: isMobile
            ? const EdgeInsets.all(15)
            : isTab
                ? const EdgeInsets.all(30.0)
                : const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Divider(
                height: isMobile || isTab ? 8 : 12,
              ),
              Text(
                value,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ]),
      ),
    );
  }
}
