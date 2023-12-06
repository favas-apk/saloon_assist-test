// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/apiLinks/apiLinks.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/closeworkController.dart';
import 'package:saloon_assist/controllers/productControllers.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/models/shopModel.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/views/moreOptions.dart';
import 'package:saloon_assist/widgets/staffDetailsItemWidget.dart';
import 'package:saloon_assist/widgets/textFormFieldWidget.dart';
import 'package:shimmer/shimmer.dart';

class CloseWork extends StatefulWidget {
  const CloseWork({
    super.key,
    required this.activeStaff,
    required this.id,
    required this.startedTime,
    required this.endTime,
    required this.chairId,
    required this.staffId,
    required this.entryDate,
  });
  final String id;
  final String staffId;
  final String chairId;
  final String activeStaff;
  final String startedTime;
  final String endTime;
  final String entryDate;

  @override
  State<CloseWork> createState() => _CloseWorkState();
}

dynamic formKey;
var totalWorkTime = "0";

class _CloseWorkState extends State<CloseWork> {
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    itemQuantityController.text = "0";
    totalWorkTime = context.read<CloseWorkController>().getTotalWorkTime(
        startedTime: widget.startedTime, endedTime: widget.endTime);
  }

  final itemNameController = TextEditingController();
  final itemRateController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final itemtypeController = TextEditingController();
  final cashController = TextEditingController();
  final cardController = TextEditingController();
  String rate = "0";
  String name = "name";
  bool showWarning = false;

  @override
  Widget build(BuildContext context) {
    // log(widget.startedTime, name: "Start time");
    // log(widget.entryDate, name: "entry time");
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
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
                Consumer<CloseWorkController>(builder: (context, value, child) {
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
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Close Work',
            style: whiteText,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(isMobile
              ? 8
              : isTab
                  ? 15
                  : 22),
          child: Form(
            key: formKey,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<ShopController>(builder: (context, value, child) {
                  late Staff currentStaff;
                  for (int i = 0; i < value.model!.staffs.length; i++) {
                    if (value.model!.staffs[i].staffId == widget.staffId) {
                      currentStaff = value.model!.staffs[i];
                    } else {}
                  }
                  return SizedBox(
                    height: 130,
                    child: Row(
                      children: [
                        Visibility(
                          visible: !isMobile && !isTab,
                          child: const Spacer(),
                        ),
                        Expanded(
                          child: Card(
                            child: ListTile(
                                title: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(imageUrl + currentStaff.img),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(4.0),
                                ),
                                Text(
                                  currentStaff.staffName.toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                          ),
                        ),
                        Visibility(
                          visible: isMobile || isTab,
                          child: Expanded(
                            child: Consumer<CloseWorkController>(
                                builder: (context, ee, child) {
                              return Card(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Center(child: Text("Work Duration")),
                                  Center(
                                    child: Text(
                                      totalWorkTime,
                                      style: titleStyle,
                                    ),
                                  ),
                                ],
                              ));
                            }),
                          ),
                        ),
                        Visibility(
                          visible: !isMobile && !isTab,
                          child: const Spacer(),
                        ),
                      ],
                    ),
                  );
                }),

                /*   Center(
                  child: Text(
                    'Time Period',
                    style: isMobile || isTab
                        ? titleStyle
                        : const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                  ),
                ), */
                const Divider(
                  color: Colors.transparent,
                  height: 5,
                ),
                Visibility(
                  visible: !isMobile && !isTab,
                  child: const Divider(color: Colors.transparent),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: !isMobile && !isTab,
                      child: Consumer<CloseWorkController>(
                          builder: (context, ee, child) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: StaffDetailsItem(
                            title: 'Total Duration',
                            value: totalWorkTime,
                          ),
                        );
                      }), /*  */
                    ),
                    Visibility(
                        visible: !isMobile && !isTab,
                        child:
                            const VerticalDivider(color: Colors.transparent)),
                    isMobile || isTab
                        ? Expanded(
                            child: StaffDetailsItem(
                                title: 'Start Time', value: widget.startedTime),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: StaffDetailsItem(
                                title: 'Start Time', value: widget.startedTime),
                          ),
                    Visibility(
                        visible: !isMobile && !isTab,
                        child:
                            const VerticalDivider(color: Colors.transparent)),
                    isMobile || isTab
                        ? Expanded(
                            child: StaffDetailsItem(
                              title: 'End Time',
                              value: slitTime(originalString: widget.endTime),
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: StaffDetailsItem(
                              title: 'End Time',
                              value: slitTime(originalString: widget.endTime),
                            ),
                          ),
                  ],
                ),
                space(context),
                Consumer<CloseWorkController>(
                    builder: (context, productsData, child) {
                  return Visibility(
                      visible: productsData.items.isNotEmpty,
                      child: SizedBox(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                // maxWidth: 150,
                                maxHeight: productsData.items.length == 1
                                    ? productsData.items.length * 120
                                    : productsData.items.length * 80,
                                minHeight: 0.0),
                            child: Table(
                              border: TableBorder.all(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              children: [
                                TableRow(children: [
                                  tablevalue("Item"),
                                  tablevalue("Qty"),
                                  tablevalue("Rate"),
                                  tablevalue("Amount"),

                                  const Text(""),
                                  // Text("data"),
                                ]),
                                for (final item in productsData.items)
                                  TableRow(children: [
                                    tablevalue(item.itemName),
                                    tablevalue(item.qty),
                                    tablevalue(item.rate),
                                    tablevalue(item.amount),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Text(
                                                  "Do you want to delete ${item.itemName}"),
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
                                                    productsData.deleteItem(
                                                        item.itemName, context);

                                                    cashController.text =
                                                        productsData.cash
                                                            .toStringAsFixed(2);
                                                  },
                                                  child: const Text("Yes"),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: const Icon(Icons.delete),
                                      ),
                                    )
                                  ]),
                              ],
                            ),
                          ),
                        ),
                      ));
                }),
                divider,
                productSection(),
                space(context),
                Consumer<CloseWorkController>(builder: (context, value, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: value.serviceCharge,
                          validator: (data) {
                            if ((data!.isEmpty || data == "0") &&
                                value.itemRate == 0) {
                              return "both product charge and service charge can't be empty !!";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            context.read<CloseWorkController>().setBillAmount(
                                context: context,
                                value: value,
                                productRate: context
                                    .read<CloseWorkController>()
                                    .itemRate
                                    .toString());
                            cashController.text = context
                                .read<CloseWorkController>()
                                .cash
                                .toStringAsFixed(2);
                          },
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: 'Service Charge',
                              labelText: "Service Charge"
                              /*   suffix: const Text(
                              'SAR',
                              style: TextStyle(color: Colors.black54, fontSize: 14),
                            ), */
                              ),
                        ),
                      ),
                      const VerticalDivider(color: Colors.transparent),
                      Expanded(
                        child: TextFormField(
                          key: Key(value.itemRate.toString()),
                          initialValue: value.itemRate.toString(),
                          readOnly: true,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey[100],
                            labelText: "Product Charge",
                            hintStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            suffix: Text(
                              "${context.read<ShopController>().model!.curencyName}  ",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                space(context),
                Consumer<CloseWorkController>(builder: (context, value, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          key: Key(value.billAmount.toString()),
                          initialValue: value.billAmount,

                          /*   validator: (data) {
                            if (data!.isEmpty || data == "0") {
                              return "Bill amount required !!";
                            }
                            return null;
                          }, */
                          /*  onChanged: (value) {
                            context.read<CloseWorkController>().setBillAmount(
                                  value,
                                  int.parse(context
                                      .read<ShopController>()
                                      .model!
                                      .tax),
                                  context.read<CloseWorkController>().itemRate,
                                );
                          }, */
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: 'Bill Amount',
                              labelText: "Bill Amount"
                              /*   suffix: const Text(
                              'SAR',
                              style: TextStyle(color: Colors.black54, fontSize: 14),
                            ), */
                              ),
                        ),
                      ),
                      const VerticalDivider(color: Colors.transparent),
                      Expanded(
                        child: TextFormField(
                          key: Key(value.taxAmount.toString()),
                          initialValue: value.taxAmount,
                          readOnly: true,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey[100],
                            labelText: "Tax Amount",
                            hintStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            suffix: Text(
                              "${context.read<ShopController>().model!.curencyName}  ",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const Divider(
                  color: Colors.transparent,
                ),
                Consumer<CloseWorkController>(builder: (context, value, c) {
                  return Row(
                    children: [
                      // const VerticalDivider(),
                      Expanded(
                        child: TextFormField(
                          key: Key(value.grandTotal.toString()),
                          initialValue: value.grandTotal,
                          readOnly: true,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey[100],
                            labelText: "GRAND TOTAL",
                            hintStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            suffix: Text(
                              "${context.read<ShopController>().model!.curencyName}  ",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const Divider(
                  color: Colors.transparent,
                ),
                Consumer<CloseWorkController>(builder: (context, value, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cashController,
                          key: Key(value.cash.toString()),
                          // initialValue: value.cash.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          onChanged: (p0) {
                            var cardAmount = value.setCashAmount(
                              double.parse(p0 == "" ? "0" : p0),
                            );
                            cardController.text = cardAmount;
                          },
                          validator: (data) {
                            if (value.cash + value.others !=
                                double.parse(value.grandTotal)) {
                              return 'Please recheck bill amount';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey[100],
                            hintText: 'CASH AMOUNT',
                            labelText: "Cash",
                            hintStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            suffix: Text(
                              context.read<ShopController>().model!.curencyName,
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: TextFormField(
                          controller: cardController,
                          key: Key(value.others.toString()),
                          // initialValue: value.others.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          validator: (data) {
                            if (value.cash + value.others !=
                                double.parse(
                                  value.grandTotal,
                                )) {
                              return 'Please recheck bill amount';
                            }
                            return null;
                          },
                          onChanged: (p0) {
                            var cashAmount = value.setOtherPayAmount(
                              double.parse(p0.isEmpty ? "0" : p0),
                            );

                            cashController.text = cashAmount;
                            /* if (double.parse(value.grandTotal) >
                                (double.parse(cashAmount) +
                                    double.parse(cashAmount))) {
                              setState(() {
                                showWarning = true;
                              });
                            } else {
                              setState(() {
                                showWarning = false;
                              });
                            } */
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey[100],
                            hintText: 'BANK AMOUNT',
                            labelText: "Bank",
                            hintStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            suffix: Text(
                              "${context.read<ShopController>().model!.curencyName}  ",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                /*   Consumer<CloseWorkController>(builder: (context, value, child) {
                  return Visibility(
                    visible: showWarning,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        ,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }), */
                divider,
                isMobile
                    ? const SizedBox(
                        height: 0,
                      )
                    : divider,
                TextFormField(
                  onChanged: (value) {
                    context.read<CloseWorkController>().setCustomerName(value);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Customer Name',
                      labelText: "Customer Name"),
                  keyboardType: TextInputType.text,
                ),
                space(context),
                TextFormField(
                  onChanged: (value) {
                    context.read<CloseWorkController>().setcustomerPlace(value);
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: 'Place',
                      labelText: "Place"

                      // prefix: const Text('+966  '),
                      ),
                ),
                space(context),
                TextFormField(
                  onChanged: (value) {
                    context.read<CloseWorkController>().setCustomerPhone(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'Phone number',
                    labelText: "Number",
                    prefix: Text(
                        "${context.read<ShopController>().model!.contryCode}  "),
                  ),
                ),
                space(context),
                space(context),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child:
                      Consumer<ShopController>(builder: (context, data, child) {
                    return SizedBox(
                      height: isMobile || isTab ? 45 : 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            await Provider.of<CloseWorkController>(context,
                                    listen: false)
                                .billClose(context,
                                    startTime: widget.startedTime,
                                    endTime: widget.endTime,
                                    chairId: widget.chairId,
                                    staffId: widget.staffId,
                                    entryDate: widget.entryDate);
                          }
                        },



                        child: Text(
                          'SAVE BILL',
                          style: whiteText,
                        ),
                      ),
                    );
                  }),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  productSection() {
    bool isTab = Responsive.isTablet(context);
    bool isMobile = Responsive.isMobile(context);
    return SizedBox(
      height: isMobile || isTab ? 50 : 60,
      width: isMobile || isTab
          ? MediaQuery.of(context).size.width / 3
          : MediaQuery.of(context).size.width / 5,
      child: Consumer<ProductController>(builder: (context, val, child) {
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: isMobile
                    ? const StadiumBorder()
                    : const BeveledRectangleBorder()),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 5,
                        right: 5,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 100,
                          child: Center(
                            child: Text("Choose products"),
                          ),
                        ),

                        divider,
                        Expanded(
                          child: FutureBuilder(
                              future: val.getAllProduts(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ConstrainedBox(
                                    constraints: BoxConstraints(
                                        minHeight: snapshot.data!.length < 5
                                            ? 5 * 80
                                            : 100),
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            const Divider(),
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          var currentData =
                                              snapshot.data![index];
                                          return ListTile(
                                            leading: const Icon(Icons
                                                .production_quantity_limits),
                                            onTap: () {
                                              setState(() {
                                                itemQuantityController.text =
                                                    "1";
                                                itemNameController.text =
                                                    currentData.itemName;
                                                itemRateController.text =
                                                    currentData.rate;
                                              });
                                              if (kDebugMode) {
                                                print(itemNameController.text);
                                              }
                                              if (kDebugMode) {
                                                print(itemRateController.text);
                                              }
                                            },
                                            title: Text(
                                              currentData.itemName
                                                  .toString()
                                                  .toUpperCase(),
                                              style: poppinsStyleH2,
                                            ),
                                            trailing: Text(
                                              currentData.rate,
                                              style: poppinsStyleH2,
                                            ),
                                          );
                                        }),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return ListView.builder(
                                    itemCount: 15,
                                    itemBuilder: (context, index) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: const Card(
                                        child: ListTile(
                                          title: Text('data'),
                                          subtitle: Text('data'),
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(
                                      child: Text("No Products"));
                                } else {
                                  return const Center(
                                    child: Text('unkown error'),
                                  );
                                }
                              }),
                        ),

                        const Divider(),
                        TextFormFieldWidget(
                            readonly: true,
                            controller: itemNameController,
                            hintText: 'Item Name'),
                        divider,
                        Row(
                          children: [
                            Expanded(
                              child: TextFormFieldWidget(
                                  controller: itemQuantityController,
                                  type: TextInputType.number,
                                  hintText: 'Quantity'),
                            ),
                            const VerticalDivider(),
                            Expanded(
                              child: TextFormFieldWidget(
                                  readonly: true,
                                  controller: itemRateController,
                                  type: TextInputType.number,
                                  hintText: 'Rate'),
                            ),
                          ],
                        ),

                        const Divider(
                          color: Colors.transparent,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    itemNameController.text = "";
                                    itemRateController.text = "0";
                                    itemQuantityController.text = "0";
                                    itemtypeController.text = "";
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancel",
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              color: Colors.transparent,
                            ),
                            Expanded(
                              child: Consumer<CloseWorkController>(
                                  builder: (context, value, child) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    await value
                                        .addBillItem(
                                            itemNameController.text,
                                            itemQuantityController.text,
                                            itemRateController.text,
                                            (int.parse(itemRateController
                                                        .text) *
                                                    int.parse(
                                                        itemQuantityController
                                                            .text))
                                                .toString(),
                                            itemtypeController.text,
                                            context)
                                        .then((value) {
                                      itemNameController.clear();
                                      itemQuantityController.clear();
                                      itemRateController.clear();
                                      itemtypeController.clear();
                                      Navigator.pop(context);
                                    });
                                    setState(() {
                                      itemNameController.text = "";
                                      itemRateController.text = "0";
                                      itemQuantityController.text = "0";
                                      itemtypeController.text = "";
                                    });
                                    cashController.text =
                                        value.cash.toStringAsFixed(2);
                                  },
                                  child: const Text(
                                    "Add Item",
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        // TextFormFieldWidget(hintText: 'Product Name')
                      ],
                    ),
                  ),
                ),
              );
            },
            child: const Text("Add Product"));
      }),
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
  }
}
