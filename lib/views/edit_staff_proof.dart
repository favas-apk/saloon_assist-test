// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/models/shopModel.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/views/moreOptions.dart';
import 'package:saloon_assist/views/proof_edit_form.dart';

import '../constants/constants.dart';

class EditStaffProofScreen extends StatefulWidget {
  EditStaffProofScreen({
    super.key,
    this.data,
    this.isUpdate = false,
    this.staff,
  });
  List<Proof>? data;
  bool isUpdate;
  Staff? staff;

  @override
  State<EditStaffProofScreen> createState() => _EditStaffProofScreenState();
}

class _EditStaffProofScreenState extends State<EditStaffProofScreen> {
  TextEditingController proofNameController = TextEditingController();
  TextEditingController proofNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ShopController>(context, listen: false).getData();
    // loadData();
  }

  /*  loadData() async {
    await Provider.of<ShopController>(context, listen: false)
        .onOpening(widget.data!);
  } */

  @override
  Widget build(BuildContext context) {
    bool isTab = Responsive.isTablet(context);
    bool isMobile = Responsive.isMobile(context);
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm'),
              content: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Do you want to go back ?',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  UnorderedListItem('You have unsaved changes'),
                  UnorderedListItem('You may lose all the datas in this form'),
                ],
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              alignment: Alignment.center,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
                Consumer<ShopController>(builder: (context, value, child) {
                  return TextButton(
                    onPressed: () async {
                      value.clearProofDetails().then(
                            (value) => Navigator.pop(context, true),
                          );
                    },
                    child: const Text('Yes'),
                  );
                }),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Update Proof",
            style: whiteText,
          ),
          backgroundColor: primaryColor,
          automaticallyImplyLeading: true,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: primaryColor),
        ),
        body: Padding(
            padding: EdgeInsets.all(isMobile || isTab ? 8.0 : 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<ShopController>(
                      builder: (context, productsData, child) {
                    return SizedBox(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              // maxWidth: 150,
                              maxHeight: productsData.tempProoTable.length == 1
                                  ? productsData.tempProoTable.length * 120
                                  : productsData.tempProoTable.length * 80,
                              minHeight: 0.0),
                          child: Table(
                            border: TableBorder.all(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            children: [
                              TableRow(children: [
                                tablevalue("Proof"),
                                tablevalue("Number"),
                                tablevalue("Date"),
                                tablevalue("Exp.Date"),

                                const Text(""),
                                // Text("data"),
                              ]),
                              for (final item in productsData.tempProoTable)
                                TableRow(children: [
                                  tablevalue(item.proofName),
                                  tablevalue(item.proofNo),
                                  tablevalue(DateFormat('MMM d, y')
                                      .format(item.proofDate)),
                                  tablevalue(DateFormat('MMM d, y')
                                      .format(item.expDate)),
                                  Center(
                                      child: PopupMenuButton<String>(
                                    onSelected: (values) {
                                      if (values == 'update') {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            content: Text(
                                                "Do you want to edit ${item.proofName}"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("No")),
                                              const VerticalDivider(
                                                color: Colors.transparent,
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          EditProofForm(
                                                        proofName:
                                                            item.proofName,
                                                        proofNumber:
                                                            item.proofNo,
                                                        date: DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(
                                                                item.proofDate),
                                                        expDate: DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(
                                                                item.expDate),
                                                        image: item.img,
                                                        data: item,
                                                        isUpdate: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text("Yes"),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (values == 'delete') {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            content: Text(
                                                "Do you want to delete ${item.proofName}"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("No")),
                                              const VerticalDivider(
                                                color: Colors.transparent,
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  productsData.deleteProof(
                                                      item.proofNo);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Yes"),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        const PopupMenuItem<String>(
                                          value: 'update',
                                          child: Text('Update'),
                                        ),
                                        const PopupMenuItem<String>(
                                          value: 'delete',
                                          child: Text('Delete'),
                                        ),
                                      ];
                                    },
                                  ) /*  InkWell(
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          
                                          /* showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            content: Text(
                                                "Do you want to edit ${item.proofName}"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("No")),
                                              const VerticalDivider(
                                                color: Colors.transparent,
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                  
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          EditProofForm(
                                                        proofName:
                                                            item.proofName,
                                                        proofNumber:
                                                            item.proofNo,
                                                        date: DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(
                                                                item.proofDate),
                                                        expDate: DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(
                                                                item.expDate),
                                                        image: item.img,
                                                        data: item,
                                                        isUpdate: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text("Yes"),
                                              ),
                                            ],
                                          ),
                                        ); */
                                        },
                                        child: const FaIcon(
                                          FontAwesomeIcons.bars,
                                          color: Colors.black45,
                                        )), */
                                      )
                                ]),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  space(context),
                  SizedBox(
                      height: isMobile
                          ? 8
                          : isTab
                              ? 10
                              : 25),
                  Row(
                    children: [
                      Visibility(
                        visible: widget.isUpdate,
                        child: TextButton.icon(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.blue,
                          ),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => EditProofForm(
                                  proofName: "",
                                  proofNumber: "",
                                  date: "",
                                  expDate: "",
                                  image: "",
                                  isUpdate: false,
                                ),
                              ),
                            );
                            /*  value.addBillItem().then((values) {
                              return value.clearProofDetails();
                            });
                            proofNameController.clear();
                            proofNumberController.clear(); */
                          },
                          label: const Text(
                            "add more Proofs",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                  space(context),
                  Row(
                    children: [
                      Expanded(
                        child: Consumer<ShopController>(
                            builder: (context, value, child) {
                          return SizedBox(
                            height: isMobile || isTab ? 45 : 60,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () async {
                                await value.updateStaffDetails(
                                  context,
                                  staffid: widget.staff!.staffId,
                                  newstaffName: value.staffName ??
                                      widget.staff!.staffName,
                                  newaddress:
                                      value.address ?? widget.staff!.address,
                                  newmobile: value.mobileNumber ??
                                      widget.staff!.mobile,
                                  newemail: value.email ?? widget.staff!.email,
                                  newdob:
                                      value.dateofBirth ?? widget.staff!.dob,
                                  newdoj:
                                      value.dateofjoining ?? widget.staff!.doj,
                                  newsalary:
                                      value.salary ?? widget.staff!.salary,

                                  /* value.department ??
                                                      widget.staff!.department, */
                                  newimg: value.staffImage ?? '',
                                );
                              },
                              child: Text(
                                'SAVE CHANGES',
                                style: whiteText,
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget tablevalue(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          value,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
