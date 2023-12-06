// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/authenticationControllers.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/views/addExpense.dart';
import 'package:saloon_assist/views/closeDay.dart';
import 'package:saloon_assist/views/employee_reports.dart';
import 'package:saloon_assist/views/getReportScreen.dart';
import 'package:saloon_assist/views/time_sheet_reports.dart';
import 'package:saloon_assist/views/view_all_bills.dart';

class MoreOptions extends StatefulWidget {
  const MoreOptions({super.key});

  @override
  State<MoreOptions> createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> {
  @override
  void initState() {
    super.initState();
    context.read<ShopController>().setIsAdmin();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Consumer<ShopController>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: value.model != null
            ? value.model!.userType == "SHOP-ADMIN"
                ? primaryColor
                : Colors.white
            : Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  height: 10,
                  color: Colors.transparent,
                ),
                Visibility(
                  visible: value.model != null
                      ? value.model!.userType == "SHOP-ADMIN"
                      : false,
                  child: Consumer<ShopController>(
                      builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const VerticalDivider(
                          color: Colors.transparent,
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: isMobile ? 35 : 45,
                            backgroundImage:
                                const AssetImage('assets/logo.png'),
                          ),
                        ),
                        const VerticalDivider(
                          width: 5,
                          color: Colors.transparent,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value.model != null
                                  ? value.model!.shopName
                                  : 'something went wrong',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            Text(
                              value.model != null
                                  ? value.model!.address
                                  : "error occured",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    );
                  }),
                ),
                Visibility(
                  visible: value.model != null
                      ? value.model!.userType == "SHOP-ADMIN"
                      : false,
                  child: const Divider(
                    height: 10,
                    color: Colors.white30,
                  ),
                ),
                Expanded(
                  child: Consumer<ShopController>(
                      builder: (context, shopData, child) {
                    return ListView(
                      children: [
                        Visibility(
                          //  visible: context.read<ShopController>().isAdmin,
                          child: SizedBox(
                            height: !isMobile ? 90 : 75,
                            child: Card(
                              color: Colors.white,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          const TimeSheetReportScreen(),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.lock_clock,
                                      color: Colors.black,
                                    ),

                                    // tileColor: Colors.grey.shade300,
                                    title: Text(
                                      'Time Sheet Report',
                                      style: blackText,
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: value.model != null
                              ? value.model!.userType == "SHOP-ADMIN"
                              : false,
                          child: SizedBox(
                            height: !isMobile ? 90 : 75,
                            child: Card(
                              color: Colors.white,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => const ViewAllBills(),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),

                                    // tileColor: Colors.grey.shade300,
                                    title: Text(
                                      'Edit Bills',
                                      style: blackText,
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          // visible: context.read<ShopController>().isAdmin,
                          child: SizedBox(
                            height: !isMobile ? 90 : 75,
                            child: Card(
                              color: Colors.white,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => const EmployeeReports(),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.lock_clock,
                                      color: Colors.black,
                                    ),

                                    // tileColor: Colors.grey.shade300,
                                    title: Text(
                                      'Employee Report',
                                      style: blackText,
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: shopData.isAdmin,
                          child: SizedBox(
                            height: !isMobile ? 90 : 75,
                            child: Card(
                              color: Colors.white,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          const GetReportsScreen(),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.edit_document,
                                      color: Colors.black,
                                    ),

                                    // tileColor: Colors.grey.shade300,
                                    title: Text(
                                      'Other Reports',
                                      style: blackText,
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: !isMobile ? 90 : 75,
                          child: Card(
                            color: Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => const AddExpense(),
                                  ),
                                );
                              },
                              child: Center(
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.mode_standby_outlined,
                                    color: Colors.black,
                                  ),

                                  // tileColor: Colors.grey.shade300,
                                  title: Text('Add Expense', style: blackText),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: !isMobile ? 90 : 75,
                          child: Card(
                            color: Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => const CloseDay(
                                        /*     entryDate: widget.entryDate,
                                                      id: 'id',
                                                      chairId: widget.chairID,
                                                      staffId: widget.staffId, */
                                        ),
                                  ),
                                );
                              },
                              child: Center(
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.close_outlined,
                                    color: Colors.black,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black26,
                                  ),

                                  // tileColor: Colors.grey.shade300,
                                  title: Text(
                                    'Close Day',
                                    style: blackText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: defaultTargetPlatform == TargetPlatform.iOS,
                          child: SizedBox(
                            height: !isMobile ? 90 : 75,
                            child: Card(
                              color: Colors.white,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Delete Account'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const UnorderedListItem(
                                                "You will lose all your shop datas"),
                                            const UnorderedListItem(
                                                "This action can not be undo"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Consumer<ShopController>(builder:
                                                (context, value, child) {
                                              return Text.rich(
                                                TextSpan(
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: [
                                                    const TextSpan(
                                                        text:
                                                            "Do you want to delete "),
                                                    TextSpan(
                                                      text:
                                                          value.model!.shopName,
                                                      style: const TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await context
                                                  .read<
                                                      AuthenticationProvider>()
                                                  .deleteShop(context);
                                            },
                                            child: const Text('Yes'),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Center(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.black26,
                                    ),
                                    title: Text(
                                      'Delete Account',
                                      style: blackText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: !isMobile ? 90 : 75,
                          child: Card(
                            color: Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Confirm'),
                                      content:
                                          const Text('Do you want to logout ?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await context
                                                .read<AuthenticationProvider>()
                                                .logout(context);
                                          },
                                          child: const Text('Yes'),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Center(
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.exit_to_app_outlined,
                                    color: Colors.black,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black26,
                                  ),

                                  // tileColor: Colors.grey.shade300,
                                  title: Text(
                                    'Logout',
                                    style: blackText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("• "),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}
