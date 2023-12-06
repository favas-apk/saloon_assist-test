// ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:country_code_picker/country_code_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/authenticationControllers.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/views/moreOptions.dart';
import 'package:saloon_assist/widgets/textFormFieldWidget.dart';

class CreateShop extends StatefulWidget {
  const CreateShop({super.key});

  @override
  State<CreateShop> createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  var _formKey;
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  // RegExp get _emailRegex => RegExp(r'^\S+@\S+$');
  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
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
                  UnorderedListItem(
                      "You will lose all your datas in this form"),
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
                Consumer<AuthenticationProvider>(
                    builder: (context, value, child) {
                  return TextButton(
                    onPressed: () async {
                      value.clear().then(
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
          elevation: 0,
          // toolbarHeight: 0,
        ),
        backgroundColor: primaryColor,
        body: Column(
          children: [
            const SizedBox(
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  //    height: MediaQuery.of(context).size.height / 3,
                  //  fit: BoxFit.contain,
                  //color: Colors.white,
                  backgroundImage: AssetImage('assets/logo.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: isMobile
                    ? const EdgeInsets.all(8)
                    : const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: Consumer<AuthenticationProvider>(
                    builder: (context, val, child) {
                  return Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Padding(
                              padding: isMobile
                                  ? const EdgeInsets.all(5.0)
                                  : const EdgeInsets.all(20.0),
                              child: Text('Create your shop', style: headStyle),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
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
                                                    await val
                                                        .pickFirstimage(
                                                            ImageSource.gallery,
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
                                                  await val
                                                      .pickFirstimage(
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
                                                      MainAxisAlignment.center,
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
                                    // await _pickProofImage( ImageSource.gallery);
                                  },
                                  child: val.imageOne != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            color: Colors.grey.shade300,
                                            // height: MediaQuery.of(context).size.height / 3,
                                            //: 200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            alignment: Alignment.center,
                                            // padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Column(
                                              children: [
                                                Image.file(
                                                  val.imageOne!,
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
                                                                      val.imageOne =
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
                                          ),
                                        )
                                      : Container(
                                          height: isMobile
                                              ? 100
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.grey.shade300,
                                          ),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(FontAwesomeIcons.image),
                                              Divider(),
                                              Text('Shop Image'),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: InkWell(
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
                                                    await val
                                                        .pickSecondimage(
                                                            ImageSource.gallery,
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
                                                  await val
                                                      .pickSecondimage(
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
                                                      MainAxisAlignment.center,
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
                                    // await _pickProofImage( ImageSource.gallery);
                                  },
                                  child: val.imagetwo != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            color: Colors.grey.shade300,
                                            // height: MediaQuery.of(context).size.height / 3,
                                            //: 200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            alignment: Alignment.center,
                                            // padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Column(
                                              children: [
                                                Image.file(
                                                  val.imagetwo!,
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
                                                                      val.imagetwo =
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
                                          ),
                                        )
                                      : Container(
                                          height: isMobile
                                              ? 100
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.grey.shade300,
                                          ),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(FontAwesomeIcons.image),
                                              Divider(),
                                              Text('Shop Image'),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                                              await val
                                                  .pickThirdimage(
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
                                            await val
                                                .pickThirdimage(
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
                              // await _pickProofImage( ImageSource.gallery);
                            },
                            child: val.imageThree != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: Colors.grey.shade300,
                                      // height: MediaQuery.of(context).size.height / 3,
                                      //: 200,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      // padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        children: [
                                          Image.file(
                                            val.imageThree!,
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
                                                            child: const Text(
                                                                'No'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                imageCache
                                                                    .clear();
                                                                val.imageThree =
                                                                    null;
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
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
                                    ),
                                  )
                                : Container(
                                    height: isMobile
                                        ? 100
                                        : MediaQuery.of(context).size.height *
                                            .3,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FaIcon(FontAwesomeIcons.image),
                                        Divider(),
                                        Text('Shop Image'),
                                      ],
                                    ),
                                  ),
                          ),
                          const Divider(),
                          space(context),
                          TextFormFieldWidget(
                              onChanged: (value) {
                                val.setshopName(value);
                              },
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'Shop name required !!';
                                }
                                return null;
                              },
                              hintText: 'Shop Name'),
                          SpaceWidget(isMobile: isMobile),
                          Row(
                            children: [
                              Expanded(
                                child: Card(
                                  child: SizedBox(
                                    height: 50,
                                    child: CountryCodePicker(
                                      onChanged: (contryCode) {
                                        val.setContryCode(contryCode.code);
                                      },
                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                      initialSelection: 'IT',
                                      favorite: const ['+966', '+91'],
                                      // optional. Shows only country name and flag
                                      showCountryOnly: false,
                                      // optional. Shows only country name and flag when popup is closed.
                                      showOnlyCountryWhenClosed: false,
                                      // optional. aligns the flag and the Text left
                                      alignLeft: false,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    showCurrencyPicker(
                                      context: context,
                                      showFlag: true,
                                      showCurrencyName: true,
                                      showCurrencyCode: true,
                                      onSelect: (Currency currency) {
                                        val.setCurrency(currency.code);
                                      },
                                    );
                                    // Navigator.pop(context);
                                  },
                                  child: Card(
                                    child: SizedBox(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          val.currency != ''
                                              ? val.currency
                                              : "Currency",
                                          style: titleStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SpaceWidget(isMobile: isMobile),
                          TextFormFieldWidget(
                              maxLine: 3,
                              onChanged: (value) {
                                val.setaddress(value);
                              },
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'Address required !!';
                                }
                                return null;
                              },
                              hintText: 'Address'),
                          SpaceWidget(isMobile: isMobile),
                          TextFormFieldWidget(
                              type: TextInputType.number,
                              onChanged: (value) {
                                val.setcontact(value);
                              },
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'Number required !!';
                                }
                                return null;
                              },
                              hintText: 'Mobile Number'),
                          SpaceWidget(isMobile: isMobile),
                          TextFormFieldWidget(
                              type: TextInputType.emailAddress,
                              onChanged: (value) {
                                val.setemail(value);
                              },
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'Email required !!';
                                }
                                return null;
                              },
                              hintText: 'Email'),
                          SpaceWidget(isMobile: isMobile),
                          TextFormFieldWidget(
                              // type: TextInputType.number,
                              onChanged: (value) {
                                val.setregnNo(value);
                              },
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'register number required !!';
                                }
                                return null;
                              },
                              hintText: 'Register Number'),
                          SpaceWidget(isMobile: isMobile),
                          TextFormFieldWidget(
                              type: TextInputType.number,
                              onChanged: (value) {
                                val.setpinCode(value);
                              },
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'pincode required !!';
                                }
                                return null;
                              },
                              hintText: 'Pincode'),
                          SpaceWidget(isMobile: isMobile),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  // padding: const EdgeInsets.all(15),
                                  // height: 150,
                                  child: Center(
                                    child: TextField(
                                      controller: startTime,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade100,
                                          labelText: "Start Time"),
                                      readOnly: true,
                                      onTap: () async {
                                        final TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: const TimeOfDay(
                                              hour: 9, minute: 30),
                                          initialEntryMode:
                                              TimePickerEntryMode.input,
                                        ); /* 
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101)); */

                                        if (pickedTime != null) {
                                          String formatedTime =
                                              pickedTime.format(context);

                                          setState(() {
                                            startTime.text = formatedTime;
                                          });
                                          val.setstartTime(formatedTime);
                                        } else {}
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const VerticalDivider(),
                              Expanded(
                                child: SizedBox(
                                  // height: 150,
                                  child: Center(
                                    child: TextField(
                                      controller: endTime,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade100,
                                          labelText: "End Time"),
                                      readOnly: true,
                                      onTap: () async {
                                        final TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: const TimeOfDay(
                                              hour: 8, minute: 00),
                                          initialEntryMode:
                                              TimePickerEntryMode.input,
                                        );

                                        if (pickedTime != null) {
                                          String formatedTime =
                                              pickedTime.format(context);

                                          setState(() {
                                            endTime.text = formatedTime;
                                          });
                                          val.setclosingTime(formatedTime);
                                        } else {}
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SpaceWidget(isMobile: isMobile),
                          const Text("Choose Holidays"),
                          SpaceWidget(isMobile: isMobile),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ChoiceChip(
                                  onSelected: (value) {
                                    val.setSunday();
                                  },
                                  label: const Text("Sunday"),
                                  selected: val.isSun),
                              ChoiceChip(
                                  onSelected: (value) {
                                    val.setMonday();
                                  },
                                  label: const Text("Monday"),
                                  selected: val.isMon),
                              ChoiceChip(
                                  onSelected: (value) {
                                    val.setTuesday();
                                  },
                                  label: const Text("Tuesday"),
                                  selected: val.isTu),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ChoiceChip(
                                  onSelected: (value) {
                                    val.setWednesday();
                                  },
                                  label: const Text("Wednesday"),
                                  selected: val.isWed),
                              ChoiceChip(
                                  onSelected: (value) {
                                    val.setThursday();
                                  },
                                  label: const Text("Thursday"),
                                  selected: val.isTh),
                              ChoiceChip(
                                  onSelected: (value) {
                                    val.setFriday();
                                  },
                                  label: const Text("Friday"),
                                  selected: val.isFri),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ChoiceChip(
                                  onSelected: (value) {
                                    val.setSaturday();
                                  },
                                  label: const Text("Saturday"),
                                  selected: val.isSat),
                            ],
                          ),
                          /* TextFormFieldWidget(
                              // type: TextInputType.number,
                              onChanged: (value) {
                                val.setholyDays(value);
                              },
                              hintText: 'Holy Days'), */
                          SpaceWidget(isMobile: isMobile),
                          TextFormFieldWidget(
                              // type: TextInputType.number,
                              onChanged: (value) {
                                val.setcategory(value);
                              },
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'category required !!';
                                }
                                return null;
                              },
                              hintText: 'Category'),
                          SpaceWidget(isMobile: isMobile),
                          TextFormFieldWidget(
                              // type: TextInputType.number,
                              onChanged: (value) {
                                val.setUserName(value);
                              },
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'username required !!';
                                }
                                return null;
                              },
                              hintText: 'Username'),
                          SpaceWidget(isMobile: isMobile),
                          TextFormFieldWidget(
                              // type: TextInputType.number,
                              onChanged: (value) {
                                val.setPassword(value);
                              },
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'password required !!';
                                }
                                return null;
                              },
                              hintText: 'Password'),
                          SpaceWidget(isMobile: isMobile),

                          /*    SizedBox(
                            height: MediaQuery.of(context).size.height * .05,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account ? signup "),
                                  InkWell(
                                      onTap: () {},
                                      child: const Text(
                                        "here",
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                ],
                              ),
                            ),
                          ), */
                          SizedBox(
                              height: isMobile
                                  ? MediaQuery.of(context).size.height * .05
                                  : MediaQuery.of(context).size.height * .07,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Consumer<AuthenticationProvider>(
                                builder: (context, value, child) =>
                                    ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shape: const StadiumBorder(),
                                      backgroundColor: primaryColor),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await value.createShop(context);
                                    } else {}
                                  },
                                  child: Text(
                                    'CREATE SHOP',
                                    style: whiteText,
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),

                          /* const Expanded(
                              child: SizedBox(),
                            ) */
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  } */
}

class SpaceWidget extends StatelessWidget {
  const SpaceWidget({
    super.key,
    required this.isMobile,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isMobile
          ? MediaQuery.of(context).size.height * .02
          : MediaQuery.of(context).size.height * .03,
    );
  }
}
