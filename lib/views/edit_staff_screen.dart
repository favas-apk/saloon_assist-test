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
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/models/shopModel.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/views/edit_staff_proof.dart';
import 'package:saloon_assist/views/moreOptions.dart';
import 'package:saloon_assist/widgets/textFormFieldWidget.dart';

class EditStaffScreen extends StatefulWidget {
  EditStaffScreen(
      {super.key, this.data, this.isUpdate = false, this.proofData});
  Staff? data;
  bool isUpdate;
  List<Proof>? proofData;
  @override
  State<EditStaffScreen> createState() => _EditStaffScreenState();
}

class _EditStaffScreenState extends State<EditStaffScreen> {
  // RegExp get _emailRegex => RegExp(r'^\S+@\S+$');
  final _formKey = GlobalKey<FormState>();

  loadData() async {
    await Provider.of<ShopController>(context, listen: false)
        .onOpening(widget.proofData!);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isTab = Responsive.isTablet(context);
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
                      value.clearStaffDetails().then(
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
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            // toolbarHeight: 0,
            title: Text(
              widget.isUpdate ? "Update staff details" : "Add new staff",
              style: whiteText,
            ),
            backgroundColor: primaryColor,
            automaticallyImplyLeading: true,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: primaryColor),
          ),
          body: isMobile || isTab
              ? Padding(
                  padding: EdgeInsets.all(isMobile || isTab ? 8 : 15.0),
                  child: Consumer<ShopController>(
                      builder: (context, value, child) {
                    return Form(
                        key: _formKey,
                        child: CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(
                                children: [
                                  const SizedBox(height: 5),
                                  // space(context),
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
                                                          .pickImage(
                                                              ImageSource
                                                                  .gallery,
                                                              context)
                                                          .then(
                                                            (value) =>
                                                                Navigator.pop(
                                                                    context),
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
                                                              color: blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                        .pickImage(
                                                            ImageSource.camera,
                                                            context)
                                                        .then(
                                                          (value) =>
                                                              Navigator.pop(
                                                                  context),
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
                                                            color: blackColor,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                        MainAxisAlignment
                                                            .center,
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
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                      // await _pickImage( ImageSource.gallery);
                                    },
                                    child: value.imageFile != null
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.grey.shade300,
                                            ),

                                            // height: MediaQuery.of(context).size.height / 3,
                                            //: 200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            alignment: Alignment.center,
                                            // padding:  EdgeInsets.symmetric(vertical: 10),
                                            child: Column(
                                              children: [
                                                Image.file(
                                                  value.imageFile!,
                                                  fit: BoxFit.cover,
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
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'No'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      imageCache
                                                                          .clear();
                                                                      value.imageFile =
                                                                          null;
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Yes'),
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
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.grey.shade300,
                                                  ),

                                                  // height: MediaQuery.of(context).size.height / 3,
                                                  //: 200,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
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
                                                                    elevation:
                                                                        0,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .grey
                                                                            .shade300),
                                                            onPressed: () {
                                                              showBottomSheet(
                                                                backgroundColor:
                                                                    Colors.blueGrey[
                                                                        200],
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Card(
                                                                          child:
                                                                              ListTile(
                                                                            onTap:
                                                                                () async {
                                                                              await value.pickImage(ImageSource.gallery, context).then(
                                                                                    (value) => Navigator.pop(context),
                                                                                  );
                                                                            },
                                                                            title:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                const FaIcon(FontAwesomeIcons.images),
                                                                                const VerticalDivider(),
                                                                                Text(
                                                                                  'GALLERY',
                                                                                  style: TextStyle(color: blackColor, fontWeight: FontWeight.bold, fontSize: 15),
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
                                                                            await value.pickImage(ImageSource.camera, context).then(
                                                                                  (value) => Navigator.pop(context),
                                                                                );
                                                                          },
                                                                          title:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              const FaIcon(FontAwesomeIcons.camera),
                                                                              const VerticalDivider(),
                                                                              Text(
                                                                                'CAMERA',
                                                                                style: TextStyle(color: blackColor, fontWeight: FontWeight.bold, fontSize: 15),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )),
                                                                        Card(
                                                                            child:
                                                                                ListTile(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          title:
                                                                              const Row(
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
                                                                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
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
                                                                  color: Colors
                                                                      .red),
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
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: isMobile
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        .3
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        .3,
                                                child: const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    FaIcon(
                                                        FontAwesomeIcons.image),
                                                    Text('Add Image'),
                                                  ],
                                                ),
                                              ),
                                  ),
                                  space(context),
                                  Expanded(
                                      child: Padding(
                                    padding:
                                        EdgeInsets.all(isMobile ? 8 : 15.0),
                                    child: Column(
                                      children: [
                                        TextFormFieldWidget(
                                          initialvalue: widget.isUpdate
                                              ? widget.data!.staffName
                                              : null,
                                          validator: (p0) {
                                            if (p0 == null || p0 == '') {
                                              return 'this field cannot be empty';
                                            } else if (p0.length <= 2) {
                                              return 'enter a valid name';
                                            }
                                            return null;
                                          },
                                          onChanged: (p0) {
                                            value.setstaffName(p0);
                                          },
                                          icon: FontAwesomeIcons.person,
                                          hintText: 'Staff Name',
                                          // maxLine: 5,
                                        ),
                                        space(context),
                                        TextFormFieldWidget(
                                          initialvalue: widget.isUpdate
                                              ? widget.data!.address
                                              : null,
                                          /*    validator: (p0) {
                                    if (p0 == null || p0 == '') {
                                      return 'This field cannot be empty';
                                    } else if (p0.length <= 5) {
                                      return 'Enter complete address';
                                    }
                                    return null;
                                  }, */
                                          onChanged: (p0) {
                                            value.setaddress(p0);
                                          },
                                          icon: FontAwesomeIcons.addressCard,
                                          hintText: 'Address',
                                          maxLine: 5,
                                        ),
                                        space(context),
                                        TextFormFieldWidget(
                                          initialvalue: widget.isUpdate
                                              ? widget.data!.mobile
                                              : null,
                                          validator: (p0) {
                                            if (p0 == null || p0 == '') {
                                              return 'This field cannot be empty';
                                            } else if (p0.length <= 5) {
                                              return 'Enter a valid number';
                                            }
                                            return null;
                                          },
                                          icon: FontAwesomeIcons.phone,
                                          onChanged: (p0) {
                                            value.setmobileNumber(p0);
                                          },
                                          type: TextInputType.number,
                                          hintText: 'Mobile Number',
                                        ),
                                        space(context),
                                        TextFormFieldWidget(
                                          initialvalue: widget.isUpdate
                                              ? widget.data!.email
                                              : null,
                                          /*  validator: (p0) {
                                    if (!_emailRegex.hasMatch(p0.toString())) {
                                      return 'Enter a valid email !!';
                                    }
                                    return null;
                                  }, */
                                          onChanged: (p0) {
                                            value.setemail(p0);
                                          },
                                          icon: FontAwesomeIcons.envelope,
                                          type: TextInputType.emailAddress,
                                          hintText: 'Email',
                                        ),
                                        space(context),
                                        TextFormFieldWidget(
                                          initialvalue: widget.isUpdate
                                              ? widget.data!.salary
                                              : null,
                                          /*   validator: (p0) {
                                    if (p0 == null || p0 == '') {
                                      return 'This field cannot be empty';
                                    } else if (p0.length <= 2) {
                                      return 'Enter a valid number';
                                    }
                                    return null;
                                  }, */
                                          onChanged: (p0) {
                                            value.setsalary(p0);
                                          },
                                          icon: FontAwesomeIcons.moneyBill,
                                          type: TextInputType.phone,
                                          hintText: 'Salary',
                                        ),
                                        space(context),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  var dob =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime(
                                                        DateTime.now().year -
                                                            18),
                                                    firstDate: DateTime(
                                                        DateTime.now().year -
                                                            100),
                                                    lastDate: DateTime.now(),
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
                                                                .fromARGB(
                                                                255,
                                                                1,
                                                                14,
                                                                38), // <-- SEE HERE
                                                          ),
                                                          textButtonTheme:
                                                              TextButtonThemeData(
                                                            style: TextButton
                                                                .styleFrom(
                                                              foregroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      74,
                                                                      5,
                                                                      0), // button text color
                                                            ),
                                                          ),
                                                        ),
                                                        child: child!,
                                                      );
                                                    },
                                                  );
                                                  // var formatter = ;
                                                  if (dob != null) {
                                                    value.dateofBirth = dob;
                                                    setState(() {});
                                                    /*   String formattedTime =
                                        DateFormat('dd-MM-yyyy').format(dob);
                                    setState(() {
                                      value.dateofBirth = formattedTime;
                                    }); */
                                                  }
                                                },
                                                child: Card(
                                                  color: Colors.grey.shade300,
                                                  child: SizedBox(
                                                      height: 45,
                                                      child: Center(
                                                        child: Text(
                                                          value.dateofBirth !=
                                                                  null
                                                              ? DateFormat(
                                                                      'dd-MM-yyyy')
                                                                  .format(value
                                                                          .dateofBirth
                                                                      as DateTime)
                                                              : widget.isUpdate
                                                                  ? DateFormat(
                                                                          'dd-MM-yyyy')
                                                                      .format(widget
                                                                          .data!
                                                                          .dob)
                                                                  : 'Date Of Birth',
                                                          style: titleStyle,
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () async {
                                                    var doj =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate: DateTime(
                                                                DateTime.now()
                                                                        .year -
                                                                    100),
                                                            lastDate:
                                                                DateTime.now());
                                                    // var formatter = ;
                                                    if (doj != null) {
                                                      value.dateofjoining = doj;
                                                      setState(() {});
                                                      log(value.dateofjoining
                                                          .toString());
                                                    }
                                                  },
                                                  child: Card(
                                                    color: Colors.grey.shade300,
                                                    child: SizedBox(
                                                        height: 45,
                                                        child: Center(
                                                          child: Text(
                                                            value.dateofjoining !=
                                                                    null
                                                                ? DateFormat(
                                                                        'dd-MM-yyyy')
                                                                    .format(value
                                                                            .dateofjoining
                                                                        as DateTime)
                                                                : widget
                                                                        .isUpdate
                                                                    ? DateFormat(
                                                                            'dd-MM-yyyy')
                                                                        .format(widget
                                                                            .data!
                                                                            .doj)
                                                                    : 'Date Of Joining',
                                                            style: titleStyle,
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        /* space(context),
                                        TextFormFieldWidget(
                                          initialvalue: widget.isUpdate
                                              ? widget.data!.department
                                              : null,
                                          onChanged: (p0) {
                                            value.setdepartment(p0);
                                          },
                                          icon: FontAwesomeIcons.addressCard,
                                          hintText: 'Deparment',
                                        ), */
                                        space(context),
                                        SizedBox(
                                          height: 45,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor,
                                              shape: const StadiumBorder(),
                                            ),
                                            onPressed: widget.isUpdate
                                                ? () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            EditStaffProofScreen(
                                                                data: widget
                                                                    .proofData,
                                                                staff:
                                                                    widget.data,
                                                                isUpdate: widget
                                                                    .isUpdate),
                                                      ),
                                                    );
                                                  }
                                                : () async {
                                                    if (value.imageFile ==
                                                        null) {
                                                      return showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            const AlertDialog(
                                                          content: Text(
                                                            'Profile Image Reuired. Add Profile Image to Continue',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      );
                                                    } else if (value
                                                            .dateofBirth ==
                                                        null) {
                                                      return showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            const AlertDialog(
                                                          content: Text(
                                                            'Choose Date of birth to continue',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      );
                                                    } else if (value
                                                            .dateofjoining ==
                                                        null) {
                                                      return showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            const AlertDialog(
                                                          content: Text(
                                                            'Choose Date of joining to continue',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (ctx) =>
                                                                EditStaffProofScreen(
                                                              data: widget
                                                                  .proofData,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    }
                                                  },
                                            child: Text(
                                              'NEXT',
                                              style: whiteText,
                                            ),
                                          ),
                                        ),
                                        space(context)
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ));
                  }),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Consumer<ShopController>(
                      builder: (context, value, child) {
                    return Form(
                        key: _formKey,
                        child: CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(
                                children: [
                                  const SizedBox(height: 5),
                                  // space(context),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                showBottomSheet(
                                                  backgroundColor:
                                                      Colors.blueGrey[200],
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Card(
                                                            child: ListTile(
                                                              onTap: () async {
                                                                await value
                                                                    .pickImage(
                                                                        ImageSource
                                                                            .gallery,
                                                                        context)
                                                                    .then(
                                                                      (value) =>
                                                                          Navigator.pop(
                                                                              context),
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
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Card(
                                                              child: ListTile(
                                                            onTap: () async {
                                                              await value
                                                                  .pickImage(
                                                                      ImageSource
                                                                          .camera,
                                                                      context)
                                                                  .then(
                                                                    (value) =>
                                                                        Navigator.pop(
                                                                            context),
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
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                          Card(
                                                              child: ListTile(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            title: const Row(
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
                                                                      fontWeight:
                                                                          FontWeight
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
                                                // await _pickImage( ImageSource.gallery);
                                              },
                                              child: value.imageFile != null
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors
                                                            .grey.shade300,
                                                      ),

                                                      // height: MediaQuery.of(context).size.height / 3,
                                                      //: 200,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      alignment:
                                                          Alignment.center,
                                                      // padding:  EdgeInsets.symmetric(vertical: 10),
                                                      child: Column(
                                                        children: [
                                                          Image.file(
                                                            value.imageFile!,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          SizedBox(
                                                            height: 45,
                                                            width: double
                                                                .maxFinite,
                                                            child:
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        elevation:
                                                                            0,
                                                                        backgroundColor: Colors
                                                                            .grey
                                                                            .shade300),
                                                                    onPressed:
                                                                        () {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                const Text('Confirm delete'),
                                                                            content:
                                                                                const Text('Do you really want to delete this image?'),
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
                                                                                    value.imageFile = null;
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
                                                                    child:
                                                                        const Text(
                                                                      'Delete',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    )),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : widget.isUpdate
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color: Colors.grey
                                                                  .shade300,
                                                            ),

                                                            // height: MediaQuery.of(context).size.height / 3,
                                                            //: 200,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            alignment: Alignment
                                                                .center,
                                                            // padding:  EdgeInsets.symmetric(vertical: 10),
                                                            child: Column(
                                                              children: [
                                                                Image(
                                                                  image:
                                                                      NetworkImage(
                                                                    '$imageUrl${widget.data!.img}?v=4',
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 45,
                                                                  width: double
                                                                      .maxFinite,
                                                                  child: ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: Colors.grey.shade300),
                                                                      onPressed: () {
                                                                        showBottomSheet(
                                                                          backgroundColor:
                                                                              Colors.blueGrey[200],
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  Card(
                                                                                    child: ListTile(
                                                                                      onTap: () async {
                                                                                        await value.pickImage(ImageSource.gallery, context).then(
                                                                                              (value) => Navigator.pop(context),
                                                                                            );
                                                                                      },
                                                                                      title: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          const FaIcon(FontAwesomeIcons.images),
                                                                                          const VerticalDivider(),
                                                                                          Text(
                                                                                            'GALLERY',
                                                                                            style: TextStyle(color: blackColor, fontWeight: FontWeight.bold, fontSize: 15),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Card(
                                                                                      child: ListTile(
                                                                                    onTap: () async {
                                                                                      await value.pickImage(ImageSource.camera, context).then(
                                                                                            (value) => Navigator.pop(context),
                                                                                          );
                                                                                    },
                                                                                    title: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        const FaIcon(FontAwesomeIcons.camera),
                                                                                        const VerticalDivider(),
                                                                                        Text(
                                                                                          'CAMERA',
                                                                                          style: TextStyle(color: blackColor, fontWeight: FontWeight.bold, fontSize: 15),
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
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        FaIcon(
                                                                                          FontAwesomeIcons.xmark,
                                                                                          color: Colors.red,
                                                                                        ),
                                                                                        VerticalDivider(),
                                                                                        Text(
                                                                                          'CANCEL',
                                                                                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
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
                                                                            color:
                                                                                Colors.red),
                                                                      )),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: Colors
                                                                .grey.shade300,
                                                          ),
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: isMobile
                                                              ? MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  .2
                                                              : MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  1.22,
                                                          child: const Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              FaIcon(
                                                                  FontAwesomeIcons
                                                                      .image),
                                                              Text('Add Image'),
                                                            ],
                                                          ),
                                                        ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.015,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TextFormFieldWidget(
                                              initialvalue: widget.isUpdate
                                                  ? widget.data!.staffName
                                                  : null,
                                              validator: (p0) {
                                                if (p0 == null || p0 == '') {
                                                  return 'this field cannot be empty';
                                                } else if (p0.length <= 2) {
                                                  return 'enter a valid name';
                                                }
                                                return null;
                                              },
                                              onChanged: (p0) {
                                                value.setstaffName(p0);
                                              },
                                              icon: FontAwesomeIcons.person,
                                              hintText: 'Staff Name',
                                              // maxLine: 5,
                                            ),
                                            space(context),
                                            // space(context),
                                            TextFormFieldWidget(
                                              initialvalue: widget.isUpdate
                                                  ? widget.data!.mobile
                                                  : null,
                                              validator: (p0) {
                                                if (p0 == null || p0 == '') {
                                                  return 'This field cannot be empty';
                                                } else if (p0.length <= 5) {
                                                  return 'Enter a valid number';
                                                }
                                                return null;
                                              },
                                              icon: FontAwesomeIcons.phone,
                                              onChanged: (p0) {
                                                value.setmobileNumber(p0);
                                              },
                                              type: TextInputType.number,
                                              hintText: 'Mobile Number',
                                            ),
                                            space(context),
                                            TextFormFieldWidget(
                                              initialvalue: widget.isUpdate
                                                  ? widget.data!.email
                                                  : null,
                                              onChanged: (p0) {
                                                value.setemail(p0);
                                              },
                                              icon: FontAwesomeIcons.envelope,
                                              type: TextInputType.emailAddress,
                                              hintText: 'Email',
                                            ),
                                            space(context),
                                            TextFormFieldWidget(
                                              initialvalue: widget.isUpdate
                                                  ? widget.data!.address
                                                  : null,
                                              /*    validator: (p0) {
                                  if (p0 == null || p0 == '') {
                                    return 'This field cannot be empty';
                                  } else if (p0.length <= 5) {
                                    return 'Enter complete address';
                                  }
                                  return null;
                                }, */
                                              onChanged: (p0) {
                                                value.setaddress(p0);
                                              },
                                              icon:
                                                  FontAwesomeIcons.addressCard,
                                              hintText: 'Address',
                                              maxLine: 5,
                                            ),
                                            space(context),
                                            TextFormFieldWidget(
                                              initialvalue: widget.isUpdate
                                                  ? widget.data!.salary
                                                  : null,
                                              onChanged: (p0) {
                                                value.setsalary(p0);
                                              },
                                              icon: FontAwesomeIcons.moneyBill,
                                              type: TextInputType.phone,
                                              hintText: 'Salary',
                                            ),
                                            space(context),
                                            /*   TextFormFieldWidget(
                                              initialvalue: widget.isUpdate
                                                  ? widget.data!.department
                                                  : null,
                                              onChanged: (p0) {
                                                value.setdepartment(p0);
                                              },
                                              icon:
                                                  FontAwesomeIcons.addressCard,
                                              hintText: 'Deparment',
                                            ),
                                            space(context), */
                                            InkWell(
                                              onTap: () async {
                                                var dob = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime(
                                                      DateTime.now().year - 18),
                                                  firstDate: DateTime(
                                                      DateTime.now().year -
                                                          100),
                                                  lastDate: DateTime.now(),
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
                                                              .fromARGB(
                                                              255,
                                                              1,
                                                              14,
                                                              38), // <-- SEE HERE
                                                        ),
                                                        textButtonTheme:
                                                            TextButtonThemeData(
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    74,
                                                                    5,
                                                                    0), // button text color
                                                          ),
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  },
                                                );
                                                if (dob != null) {
                                                  value.dateofBirth = dob;
                                                  setState(() {});
                                                  log(value.dateofBirth
                                                      .toString());
                                                }
                                              },
                                              child: Card(
                                                color: Colors.grey.shade300,
                                                child: SizedBox(
                                                    height: 55,
                                                    child: Center(
                                                      child: Text(
                                                        value.dateofBirth !=
                                                                null
                                                            ? DateFormat(
                                                                    'dd-MM-yyyy')
                                                                .format(value
                                                                        .dateofBirth
                                                                    as DateTime)
                                                            : widget.isUpdate
                                                                ? DateFormat(
                                                                        'dd-MM-yyyy')
                                                                    .format(widget
                                                                        .data!
                                                                        .dob)
                                                                : 'Date Of Birth',
                                                        style: titleStyle,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            space(context),
                                            InkWell(
                                              onTap: () async {
                                                var doj = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(
                                                        DateTime.now().year -
                                                            100),
                                                    lastDate: DateTime.now());
                                                // var formatter = ;
                                                if (doj != null) {
                                                  value.dateofjoining = doj;
                                                  setState(() {});
                                                  log(value.dateofjoining
                                                      .toString());
                                                }
                                              },
                                              child: Card(
                                                color: Colors.grey.shade300,
                                                child: SizedBox(
                                                    height: 55,
                                                    child: Center(
                                                      child: Text(
                                                        value.dateofjoining !=
                                                                null
                                                            ? DateFormat(
                                                                    'dd-MM-yyyy')
                                                                .format(value
                                                                        .dateofjoining
                                                                    as DateTime)
                                                            : widget.isUpdate
                                                                ? DateFormat(
                                                                        'dd-MM-yyyy')
                                                                    .format(widget
                                                                        .data!
                                                                        .doj)
                                                                : 'Date Of Joining',
                                                        style: titleStyle,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.015,
                                      ),
                                      /*  Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                          
                                          ],
                                        ),
                                      ), */
                                    ],
                                  ),

                                  space(context),
                                  Column(
                                    children: [
                                      const Divider(color: Colors.transparent),

                                      //space(context),

                                      space(context),
                                      SizedBox(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            shape: const StadiumBorder(),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (ctx) =>
                                                    EditStaffProofScreen(
                                                        data: widget.proofData,
                                                        staff: widget.data,
                                                        isUpdate:
                                                            widget.isUpdate),
                                              ),
                                            );
                                          }
                                          /*  : () async {
                                                  if (value.imageFile == null) {
                                                    return showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          const AlertDialog(
                                                        content: Text(
                                                          'Profile Image Reuired. Add Profile Image to Continue',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    );
                                                  } else if (value
                                                          .dateofBirth ==
                                                      null) {
                                                    return showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          const AlertDialog(
                                                        content: Text(
                                                          'Choose Date of birth to continue',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    );
                                                  } else if (value
                                                          .dateofjoining ==
                                                      null) {
                                                    return showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          const AlertDialog(
                                                        content: Text(
                                                          'Choose Date of joining to continue',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              EditStaffProofScreen(
                                                            data: widget
                                                                .proofData,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                }, */
                                          ,
                                          child: Text(
                                            'NEXT',
                                            style: whiteText,
                                          ),
                                        ),
                                      ),
                                      space(context),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ));
                  }),
                )),
    );
  }
}
