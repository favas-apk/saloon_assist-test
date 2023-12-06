// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/apiLinks/apiLinks.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/models/staffProofModel.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/widgets/textFormFieldWidget.dart';

class EditProofForm extends StatefulWidget {
  EditProofForm({
    super.key,
    this.isUpdate = false,
    this.data,
    required this.proofName,
    required this.proofNumber,
    required this.date,
    required this.expDate,
    required this.image,
  });
  StaffProofModel? data;
  bool isUpdate;

  String proofName;
  String proofNumber;
  String date;
  String expDate;
  String image;
  @override
  State<EditProofForm> createState() => _EditProofFormState();
}

class _EditProofFormState extends State<EditProofForm> {
  @override
  void initState() {
    super.initState();
    widget.isUpdate ? proofNameController.text = widget.proofName : null;
    widget.isUpdate ? proofNumberController.text = widget.proofNumber : null;
  }

  TextEditingController proofNameController = TextEditingController();
  TextEditingController proofNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool isTab = Responsive.isTablet(context);
    bool isMobile = Responsive.isMobile(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Details",
          style: whiteText,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<ShopController>(builder: (context, value, child) {
              return Form(
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
                                                ImageSource.gallery, context)
                                            .then(
                                              (value) => Navigator.pop(context),
                                            );
                                      },
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const FaIcon(FontAwesomeIcons.images),
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
                                      child: ListTile(
                                    onTap: () async {
                                      await value
                                          .pickProofImage(
                                              ImageSource.camera, context)
                                          .then(
                                            (value) => Navigator.pop(context),
                                          );
                                    },
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const FaIcon(FontAwesomeIcons.camera),
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
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(
                                      value.proofImageFile!,
                                      fit: BoxFit.cover,
                                    ),
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
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('No'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        imageCache.clear();
                                                        value.proofImageFile =
                                                            null;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Yes'),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        )),
                                  )
                                ],
                              ),
                            )
                          : widget.isUpdate && widget.data!.img.length > 100
                              ? Base64ImageWidget(
                                  base64String: widget.data!.img,
                                ) /*  Image.file(
                                  widget.data!.img,
                                    fit: BoxFit.cover,
                                  )  */
                              : widget.isUpdate
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.grey.shade300,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        alignment: Alignment.center,
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          backgroundColor:
                                                              Colors.grey
                                                                  .shade300),
                                                  onPressed: () {
                                                    showBottomSheet(
                                                      backgroundColor:
                                                          Colors.blueGrey[200],
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
                                                                child: ListTile(
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
                                                                          FontAwesomeIcons
                                                                              .images),
                                                                      const VerticalDivider(),
                                                                      Text(
                                                                        'GALLERY',
                                                                        style: TextStyle(
                                                                            color:
                                                                                blackColor,
                                                                            fontWeight:
                                                                                FontWeight.bold,
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
                                                                          ImageSource
                                                                              .camera,
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
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
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
                                                                          color: Colors
                                                                              .red,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
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
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey.shade300,
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      height: isMobile
                                          ? MediaQuery.of(context).size.height *
                                              .2
                                          : MediaQuery.of(context).size.height *
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
                              widget.isUpdate ? "" : value.setproofName(p0);
                            },
                            icon: FontAwesomeIcons.person,
                            hintText: 'Proof Name',
                            // maxLine: 5,
                          ),
                          space(context),
                          TextFormFieldWidget(
                            controller: proofNumberController,
                            validator: (p0) {
                              if (p0 == null || p0 == '') {
                                return 'Proof number cannot be empty';
                              } else if (p0.length <= 2) {
                                return 'enter a valid proof number';
                              }
                              return null;
                            },
                            onChanged: (p0) {
                              widget.isUpdate ? "" : value.setproofNumber(p0);
                            },
                            icon: FontAwesomeIcons.phone,
                            hintText: 'Proof Number',
                          ),
                          space(context),
                          Row(
                            children: [
                              Expanded(
                                child: Card(
                                  color: Colors.grey.shade300,
                                  child: InkWell(
                                    onTap: () async {
                                      var proofDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate:
                                            DateTime(DateTime.now().year - 20),
                                        lastDate:
                                            DateTime(DateTime.now().year + 2),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary:
                                                    primaryColor, // <-- SEE HERE
                                                onPrimary: Colors
                                                    .white, // <-- SEE HERE
                                                onSurface: const Color.fromARGB(
                                                    255,
                                                    24,
                                                    41,
                                                    72), // <-- SEE HERE
                                              ),
                                              textButtonTheme:
                                                  TextButtonThemeData(
                                                style: TextButton.styleFrom(
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
                                      }
                                    },
                                    child: SizedBox(
                                        height: 60,
                                        child: Center(
                                          child: Text(
                                            value.proofDate != null
                                                ? DateFormat('dd-MM-yyyy')
                                                    .format(value.proofDate
                                                        as DateTime)
                                                : widget.isUpdate
                                                    ? DateFormat('dd-MM-yyyy')
                                                        .format(widget
                                                            .data!.proofDate)
                                                    : "Proof Date",
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
                                      var expairyDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate:
                                            DateTime(DateTime.now().year + 100),
                                      );
                                      // var formatter = ;
                                      if (expairyDate != null) {
                                        value.expairyDate = expairyDate;
                                        // String formattedTime =
                                        //     DateFormat('dd-MM-yyyy').format(expairyDate);
                                        setState(() {
                                          // value.expairyDate = formattedTime;
                                        });
                                      }
                                    },
                                    child: SizedBox(
                                        height: 60,
                                        child: Center(
                                          child: Text(
                                            value.expairyDate != null
                                                ? DateFormat('dd-MM-yyyy')
                                                    .format(value.expairyDate
                                                        as DateTime)
                                                : widget.isUpdate
                                                    ? DateFormat('dd-MM-yyyy')
                                                        .format(widget
                                                            .data!.expDate)
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
                          /* Row(
                            children: [
                              Visibility(
                                visible: !widget.isUpdate,
                                child: TextButton.icon(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async {
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
                          ), */
                          const Divider(
                            color: Colors.transparent,
                          ),
                          SizedBox(
                            height: isMobile || isTab ? 45 : 60,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: const StadiumBorder(),
                              ),
                              onPressed: widget.isUpdate
                                  ? () {
                                      value
                                          .updateTempProof(
                                              context: context,
                                              oldproofNumber:
                                                  widget.data!.proofNo,
                                              newproofName:
                                                  proofNameController.text,
                                              newproofNumber:
                                                  proofNumberController.text,
                                              newproofDate: value.proofDate ??
                                                  widget.data!.proofDate,
                                              newexpairyDate:
                                                  value.expairyDate ??
                                                      widget.data!.expDate,
                                              newproofImage: value.proofImage ??
                                                  widget.data!.img)
                                          .then((values) {
                                        return value.clearProofDetails();
                                      });
                                      Navigator.pop(context);
                                    }
                                  : () async {
                                      if (value.proofImageFile == null) {
                                        return showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AlertDialog(
                                            content: Text(
                                              'Proof Image Reuired. Add Proof Image to Continue',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      } else if (value.proofDate == null) {
                                        return showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AlertDialog(
                                            content: Text(
                                              'Choose Proof Date to continue',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      } else if (value.expairyDate == null) {
                                        return showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AlertDialog(
                                            content: Text(
                                              'Choose Expiry Date Continue',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      } else {
                                        if (_formKey.currentState!.validate()) {
                                          value
                                              .addToTemTable()
                                              .then((values) =>
                                                  value.clearProofDetails())
                                              .then((value) =>
                                                  Navigator.pop(context));

                                          proofNameController.clear();
                                          proofNumberController.clear();
                                        }
                                      }
                                    },
                              child: Text(
                                widget.isUpdate ? 'UPDATE' : 'ADD PROOF',
                                style: whiteText,
                              ),
                            ),
                          ),
                          /*   value.addBillItem().then((values) {
                                            return value.clearProofDetails();
                                          });
                                          proofNameController.clear();
                                          proofNumberController.clear();
                                        }, */
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class Base64ImageWidget extends StatelessWidget {
  final String base64String;

  const Base64ImageWidget({super.key, required this.base64String});

  @override
  Widget build(BuildContext context) {
    // Decode the base64 string to bytes
    List<int> bytes = base64.decode(base64String);

    // Create an Image.memory widget with the decoded bytes
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.memory(
        Uint8List.fromList(bytes),
        fit: BoxFit.cover, // Adjust the fit as needed
      ),
    );
  }
}
