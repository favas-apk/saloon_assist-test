// ignore_for_file: file_names, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/apiLinks/apiLinks.dart';
import 'package:saloon_assist/constants/colors.dart';
// import 'package:saloon_assist/controllers/ShopController.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/models/shopModel.dart';
// import 'package:saloon_assist/models/shopModel.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/views/moreOptions.dart';
import 'package:saloon_assist/widgets/textFormFieldWidget.dart';

import '../constants/constants.dart';

class AddStaffProofScreen extends StatefulWidget {
  AddStaffProofScreen({
    super.key,
    this.data,
    this.isUpdate = false,
    this.staff,
  });
  Proof? data;
  bool isUpdate;
  Staff? staff;

  @override
  State<AddStaffProofScreen> createState() => _AddStaffProofScreenState();
}

class _AddStaffProofScreenState extends State<AddStaffProofScreen> {
  TextEditingController proofNameController = TextEditingController();
  TextEditingController proofNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ShopController>(context, listen: false).getData();
    widget.isUpdate ? proofNameController.text = widget.data!.proofName : null;
    widget.isUpdate ? proofNameController.text = widget.data!.proofNo : null;
  }

  final _formKey = GlobalKey<FormState>();
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
              title: const Text('Exit Page ?'),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Do you want to go back ?',
                    textAlign: TextAlign.center,
                  ),
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
          // toolbarHeight: 0,
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
                  Consumer<ShopController>(builder: (context, value, child) {
                    return /* CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: */
                        Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          space(context),
                          InkWell(
                            onTap: () async {
                              showBottomSheet(
                                backgroundColor: Colors.blueGrey[200],
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Card(
                                          child: ListTile(
                                            onTap: () async {
                                              await value
                                                  .pickProofImage(
                                                      ImageSource.gallery,
                                                      context)
                                                  .then(
                                                    (value) =>
                                                        Navigator.pop(context),
                                                  );
                                            },
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const FaIcon(
                                                    FontAwesomeIcons.images),
                                                const VerticalDivider(),
                                                Text(
                                                  'GALLERY',
                                                  style: TextStyle(
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Card(
                                            child: ListTile(
                                          onTap: () async {
                                            await value
                                                .pickProofImage(
                                                    ImageSource.camera, context)
                                                .then(
                                                  (value) =>
                                                      Navigator.pop(context),
                                                );
                                          },
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const FaIcon(
                                                  FontAwesomeIcons.camera),
                                              const VerticalDivider(),
                                              Text(
                                                'CAMERA',
                                                style: TextStyle(
                                                    color: blackColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        )),
                                        Card(
                                            child: ListTile(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          title: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.xmark,
                                                color: Colors.red,
                                              ),
                                              VerticalDivider(),
                                              Text(
                                                'CANCEL',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        )),
                                      ],
                                    ),
                                  );
                                },
                              );
                              // await pickProofImage( ImageSource.gallery);
                            },
                            child: value.proofImageFile != null
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.shade300,
                                    ),

                                    // height: MediaQuery.of(context).size.height / 3,
                                    //: 200,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    // padding:  EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      children: [
                                        Image.file(
                                          value.proofImageFile!,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          height: 45,
                                          width: double.maxFinite,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  backgroundColor:
                                                      Colors.grey.shade300),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Confirm delete'),
                                                      content: const Text(
                                                          'Do you really want to delete this image?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text('No'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              imageCache
                                                                  .clear();
                                                              value.proofImageFile =
                                                                  null;
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text('Yes'),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                        )
                                      ],
                                    ),
                                  )
                                : widget.isUpdate
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.grey.shade300,
                                          ),

                                          // height: MediaQuery.of(context).size.height / 3,
                                          //: 200,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                          // padding:  EdgeInsets.symmetric(vertical: 10),
                                          child: Column(
                                            children: [
                                              Image(
                                                image: NetworkImage(
                                                  '$imageUrl${widget.data!.img}?v=4',
                                                ),
                                              ),
                                              SizedBox(
                                                height: 45,
                                                width: double.maxFinite,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            elevation: 0,
                                                            backgroundColor:
                                                                Colors.grey
                                                                    .shade300),
                                                    onPressed: () {
                                                      showBottomSheet(
                                                        backgroundColor: Colors
                                                            .blueGrey[200],
                                                        context: context,
                                                        builder: (context) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Card(
                                                                  child:
                                                                      ListTile(
                                                                    onTap:
                                                                        () async {
                                                                      await value
                                                                          .pickProofImage(
                                                                              ImageSource.gallery,
                                                                              context)
                                                                          .then(
                                                                            (value) =>
                                                                                Navigator.pop(context),
                                                                          );
                                                                    },
                                                                    title: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        const FaIcon(
                                                                            FontAwesomeIcons.images),
                                                                        const VerticalDivider(),
                                                                        Text(
                                                                          'GALLERY',
                                                                          style: TextStyle(
                                                                              color: blackColor,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 15),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Card(
                                                                    child:
                                                                        ListTile(
                                                                  onTap:
                                                                      () async {
                                                                    await value
                                                                        .pickProofImage(
                                                                            ImageSource.camera,
                                                                            context)
                                                                        .then(
                                                                          (value) =>
                                                                              Navigator.pop(context),
                                                                        );
                                                                  },
                                                                  title: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const FaIcon(
                                                                          FontAwesomeIcons
                                                                              .camera),
                                                                      const VerticalDivider(),
                                                                      Text(
                                                                        'CAMERA',
                                                                        style: TextStyle(
                                                                            color:
                                                                                blackColor,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 15),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                                Card(
                                                                    child:
                                                                        ListTile(
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  title:
                                                                      const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      FaIcon(
                                                                        FontAwesomeIcons
                                                                            .xmark,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      VerticalDivider(),
                                                                      Text(
                                                                        'CANCEL',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: const Text(
                                                      'Update',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey.shade300,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: isMobile
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .2
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .3,
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FaIcon(FontAwesomeIcons.image),
                                            Text('Add Image'),
                                          ],
                                        ),
                                      ),
                          ),
                          Padding(
                            padding: isMobile
                                ? const EdgeInsets.all(8.0)
                                : const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                space(context),
                                TextFormFieldWidget(
                                  controller: proofNameController,
                                  /*  initialvalue: widget.isUpdate
                                      ? 
                                      : null, */
                                  validator: (p0) {
                                    if (p0 == null || p0 == '') {
                                      return 'This field cannot be empty';
                                    } else if (p0.length <= 3) {
                                      return 'enter a valid proof name';
                                    }
                                    return null;
                                  },
                                  onChanged: (p0) {
                                    value.setproofName(p0);
                                  },
                                  icon: FontAwesomeIcons.person,
                                  hintText: 'Proof Name',
                                  // maxLine: 5,
                                ),
                                space(context),
                                /*  TextFormFieldWidget(
                  onChanged: (p0) {
                    value.setproofID(p0);
                  },
                  icon: FontAwesomeIcons.addressCard,
                  hintText: 'Proof ID',
                ),
                space(context), */
                                TextFormFieldWidget(
                                  controller: proofNumberController,
                                  /*     initialvalue: widget.isUpdate
                                      ? widget.data!.proofNo
                                      : null, */
                                  validator: (p0) {
                                    if (p0 == null || p0 == '') {
                                      return 'Proof number cannot be empty';
                                    } else if (p0.length <= 2) {
                                      return 'enter a valid proof number';
                                    }
                                    return null;
                                  },
                                  onChanged: (p0) {
                                    value.setproofNumber(p0);
                                  },
                                  icon: FontAwesomeIcons.phone,
                                  // type: TextInputType.number,
                                  hintText: 'Proof Number',
                                ),
                                space(context),

                                /* space(context),
                TextFormFieldWidget(
                  validator: (p0) {
                    if (p0 == null || p0 == '') {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  onChanged: (p0) {
                    value.setremindDays(p0);
                  },
                  icon: FontAwesomeIcons.moneyBill,
                  type: TextInputType.phone,
                  hintText: 'Remind Days',
                ), */
                                Row(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        color: Colors.grey.shade300,
                                        child: InkWell(
                                          onTap: () async {
                                            var proofDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(
                                                  DateTime.now().year - 20),
                                              lastDate: DateTime(
                                                  DateTime.now().year + 2),
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    colorScheme:
                                                        ColorScheme.light(
                                                      primary:
                                                          primaryColor, // <-- SEE HERE
                                                      onPrimary: Colors
                                                          .white, // <-- SEE HERE
                                                      onSurface: const Color
                                                          .fromARGB(255, 24, 41,
                                                          72), // <-- SEE HERE
                                                    ),
                                                    textButtonTheme:
                                                        TextButtonThemeData(
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor: Colors
                                                            .red, // button text color
                                                      ),
                                                    ),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                            );
                                            // var formatter = ;
                                            if (proofDate != null) {
                                              value.proofDate = proofDate;

                                              /*     String formattedTime =
                                                              DateFormat('dd-MM-yyyy').format(dob); */
                                              setState(() {
                                                //  value.proofDate = formattedTime;
                                              });
                                              log(value.proofDate.toString());
                                            }
                                          },
                                          child: SizedBox(
                                              height: 60,
                                              child: Center(
                                                child: Text(
                                                  value.proofDate != null
                                                      ? DateFormat('dd-MM-yyyy')
                                                          .format(
                                                              value.proofDate
                                                                  as DateTime)
                                                      : widget.isUpdate
                                                          ? widget
                                                              .data!.proofDate
                                                          : 'PROOF DATE',
                                                  style: titleStyle,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Card(
                                        color: Colors.grey.shade300,
                                        child: InkWell(
                                          onTap: () async {
                                            var expairyDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(
                                                  DateTime.now().year + 100),
                                            );
                                            // var formatter = ;
                                            if (expairyDate != null) {
                                              value.expairyDate = expairyDate;
                                              // String formattedTime =
                                              //     DateFormat('dd-MM-yyyy').format(expairyDate);
                                              setState(() {
                                                // value.expairyDate = formattedTime;
                                              });
                                              log(value.expairyDate.toString());
                                            }
                                          },
                                          child: SizedBox(
                                              height: 60,
                                              child: Center(
                                                child: Text(
                                                  value.expairyDate != null
                                                      ? DateFormat('dd-MM-yyyy')
                                                          .format(
                                                              value.expairyDate
                                                                  as DateTime)
                                                      : widget.isUpdate
                                                          ? widget.data!.expDate
                                                          : 'EXPIRY DATE',
                                                  style: titleStyle,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Consumer<ShopController>(
                                    builder: (context, productsData, child) {
                                  return Visibility(
                                      visible:
                                          productsData.staffProofs.isNotEmpty,
                                      child: SizedBox(
                                        child: Center(
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                                // maxWidth: 150,
                                                maxHeight: productsData
                                                            .staffProofs
                                                            .length ==
                                                        1
                                                    ? productsData.staffProofs
                                                            .length *
                                                        120
                                                    : productsData.staffProofs
                                                            .length *
                                                        80,
                                                minHeight: 0.0),
                                            child: Table(
                                              border: TableBorder.all(
                                                color: Colors.black45,
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                                for (final item
                                                    in productsData.staffProofs)
                                                  TableRow(children: [
                                                    tablevalue(item.proofName),
                                                    tablevalue(item.proofNo),
                                                    tablevalue(DateFormat(
                                                            'MMM d, y')
                                                        .format(
                                                            item.proofDate)),
                                                    tablevalue(DateFormat(
                                                            'MMM d, y')
                                                        .format(item.expDate)),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              content: Text(
                                                                  "Do you want to delete ${item.proofName}"),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: const Text(
                                                                        "No")),
                                                                const VerticalDivider(
                                                                  color: Colors
                                                                      .transparent,
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    productsData
                                                                        .deleteItem(
                                                                            item.proofNo);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          "Yes"),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: const Icon(
                                                            Icons.delete),
                                                      ),
                                                    )
                                                  ]),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                }),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Visibility(
                                      visible: !widget.isUpdate,
                                      child: TextButton.icon(
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () async {
                                          value
                                              .addBillItem(context)
                                              .then((values) {
                                            return value.clearProofDetails();
                                          });
                                          proofNameController.clear();
                                          proofNumberController.clear();
                                        },
                                        label: const Text(
                                          "Save and add more Proofs",
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
                                      child: SizedBox(
                                        height: isMobile || isTab ? 45 : 60,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            shape: const StadiumBorder(),
                                          ),
                                          onPressed: /*   widget.isUpdate
                                            ? () async {
                                                await value.updateStaffDetails(
                                                    context,
                                                    staffid:
                                                        widget.staff!.staffId,
                                                    newstaffName: value.staffName ??
                                                        widget.staff!.staffName,
                                                    newaddress: value.address ??
                                                        widget.staff!.address,
                                                    newmobile: value.mobileNumber ??
                                                        widget.staff!.mobile,
                                                    newemail: value.email ??
                                                        widget.staff!.email,
                                                    newdob: value.dateofBirth ??
                                                        widget.staff!.dob,
                                                    newdoj: value.dateofjoining ??
                                                        widget.staff!.doj,
                                                    newsalary: value.salary ??
                                                        widget.staff!.salary,
                                                  /*   newdepartment: "",
                                                    /* value.department ??
                                                  widget.staff!.department, */
                                                    newimg:
                                                        value.staffImage ?? '',
                                                    newproofName: value.proofName ??
                                                        widget.data!.proofName,
                                                    newproofNo: value.proofNumber ??
                                                        widget.data!.proofNo,
                                                    newproofDate: value.proofDate
                                                                .toString() !=
                                                            "null"
                                                        ? value.proofDate
                                                            .toString()
                                                        : widget.data!.proofDate,
                                                    newexpDate: value.expairyDate.toString() != "null" ? widget.data!.expDate.toString() : widget.data!.expDate,
                                                    newProofimg: value.proofImage ?? '' */);
                                              }
                                            : */
                                              () async {
                                            if (value.staffProofs.isNotEmpty) {
                                              await value
                                                  .addStaff(context)
                                                  .then((values) => value
                                                      .clearProofDetails()
                                                      .then((valuess) => value
                                                          .clearStaffDetails()));
                                            } else {
                                              if (value.proofImageFile ==
                                                  null) {
                                                return showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const AlertDialog(
                                                    content: Text(
                                                      'Proof Image Reuired. Add Proof Image to Continue',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                );
                                              } else if (value.proofDate ==
                                                  null) {
                                                return showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const AlertDialog(
                                                    content: Text(
                                                      'Choose Proof Date to continue',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                );
                                              } else if (value.expairyDate ==
                                                  null) {
                                                return showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const AlertDialog(
                                                    content: Text(
                                                      'Choose Expiry Date Continue',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  await value
                                                      .addStaff(context)
                                                      .then((values) => value
                                                          .clearProofDetails()
                                                          .then((valuess) => value
                                                              .clearStaffDetails()));
                                                }
                                              }
                                            }
                                          },
                                          child: Text(
                                            widget.isUpdate
                                                ? 'UPDATE'
                                                : 'SAVE STAFF',
                                            style: whiteText,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
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
