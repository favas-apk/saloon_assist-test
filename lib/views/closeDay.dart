// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/reportsControllers.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/widgets/overallReportDashCard.dart';

class CloseDay extends StatefulWidget {
  const CloseDay({
    super.key,
    // required this.id,
    // required this.chairId,
    // required this.staffId,
    // required this.entryDate,
  });
  // final String id;
  // final String chairId;
  // final String staffId;
  // final String entryDate;

  @override
  State<CloseDay> createState() => _CloseDayState();
}

class _CloseDayState extends State<CloseDay> {
  @override
  void initState() {
    super.initState();
    Provider.of<ReportController>(context, listen: false).dayCloseReport();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isTab = Responsive.isTablet(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Close Day',
          style: whiteText,
        ),
      ),
      body: Consumer<ReportController>(builder: (context, value, child) {
        return isMobile || isTab
            ? FutureBuilder(
                future: value.dayCloseReport(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data[0];
                    return ListView(
                      padding: const EdgeInsets.all(8),
                      children: [
                        space(context),
                        Center(
                          child: Text(
                            'DAY CLOSE',
                            style: poppinsStyleHead1,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(value.closework!.billCount),
                            Text(DateFormat('dd-MM-yyyy')
                                .format(DateTime.now())
                                .toString()),
                          ],
                        ),
                        space(context),
                        divider,
                        SizedBox(
                          height: isMobile
                              ? MediaQuery.of(context).size.height * .20
                              : MediaQuery.of(context).size.height * .20,
                          child: Row(
                            children: [
                              Expanded(
                                child: OverallReportDashCard(
                                    isMobile: isMobile,
                                    icon: FontAwesomeIcons.moneyBills,
                                    title: 'Bill Count',
                                    value: data["BillCount"] ?? "00"),
                              ),
                              Expanded(
                                child: OverallReportDashCard(
                                    isMobile: isMobile,
                                    icon: FontAwesomeIcons.moneyCheckDollar,
                                    title: 'Amount',
                                    value: data["Amount"]),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          // visible: isMobile,
                          child: SizedBox(
                            height: isMobile
                                ? MediaQuery.of(context).size.height * .20
                                : MediaQuery.of(context).size.height * 0.25,
                            child: Row(
                              children: [
                                Expanded(
                                  child: OverallReportDashCard(
                                      isMobile: isMobile,
                                      icon: FontAwesomeIcons.handHoldingDollar,
                                      title: 'Cash',
                                      value: data["Cash"]),
                                ),
                                Expanded(
                                  child: OverallReportDashCard(
                                      isMobile: isMobile,
                                      icon: FontAwesomeIcons.creditCard,
                                      title: 'Card',
                                      value: data["Card"]),
                                ),
                                Expanded(
                                  child: OverallReportDashCard(
                                      isMobile: isMobile,
                                      icon: FontAwesomeIcons.chartLine,
                                      title: 'Expense',
                                      value: data["Expenses"] ?? "0.0"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        divider,
                        Text(
                          'Staffs',
                          style: poppinsHeadStyle2,
                        ),
                        divider,
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: 90 *
                                  double.parse(data["Staff"].length.toString()),
                              minHeight: 0.0),
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              // padding: const EdgeInsets.all(10),
                              itemCount: data["Staff"].length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                var currentStaff = data["Staff"][index];
                                return ListTile(
                                  title: Text(currentStaff["StaffName"]),
                                  subtitle: Text(
                                      "Bill count :  ${currentStaff["Billcount"]}"),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Bill Amount"),
                                      Text(currentStaff["Amount"]),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        divider,
                        /*  Text(
                      'Payment breakdown',
                      style: poppinsHeadStyle2,
                    ),
                    divider,
                    Container(
                      constraints:
                          const BoxConstraints(maxHeight: 200, minHeight: 56.0),

                      // height: MediaQuery.of(context).size.height / 2,
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(10),
                          itemCount: 5,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('payment type'),
                                Text('count'),
                                Text('amount'),
                              ],
                            );
                          }),
                    ), */
                        Consumer<ReportController>(
                            builder: (context, data, child) {
                          return ElevatedButton(
                            onPressed: () async {
                              await data.closeDay(context);

                              /*  data
                              .changeChairStatus(
                                  chairid: widget.chairId,
                                  status: 0,
                                  date: DateFormat('yyyy-MM-dd').format(
                                    DateTime.now(),
                                  ),
                                  staffId: widget.staffId)
                              .then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => BottomNavigation(
                                        page: 1,
                                      ),
                                    ),
                                    (route) => false),
                              ); */
                              /*  await data
                                    .updateChair(
                                        id: id,
                                        activeStaffs: null,
                                        inWork: false,
                                        currentStatus: false)
                                    .then(
                                      (value) => Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (ctx) => BottomNavigation(),
                                          ),
                                          (route) => false),
                                    ); */
                            },
                            child: const Text('CLOSE THE DAY'),
                          );
                        }),
                        space(context),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: Text("Waiting"),
                    );
                  } else {
                    return const Center(
                      child: Text("else"),
                    );
                  }
                })
            : FutureBuilder(
                future: value.dayCloseReport(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data[0];
                    return ListView(
                      padding: const EdgeInsets.all(8),
                      children: [
                        space(context),
                        Center(
                          child: Text(
                            'DAY CLOSE',
                            style: poppinsStyleHead1,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(value.closework!.billCount),
                            Text(DateFormat('dd-MM-yyyy')
                                .format(DateTime.now())
                                .toString()),
                          ],
                        ),
                        space(context),
                        divider,
                        SizedBox(
                          height: isMobile
                              ? MediaQuery.of(context).size.height * .20
                              : 200,
                          child: Row(
                            children: [
                              const VerticalDivider(color: Colors.transparent),
                              Expanded(
                                child: OverallReportDashCard(
                                    isMobile: isMobile,
                                    icon: FontAwesomeIcons.moneyBills,
                                    title: 'Bill Count',
                                    value: data["BillCount"] ?? "00"),
                              ),
                              Expanded(
                                child: OverallReportDashCard(
                                    isMobile: isMobile,
                                    icon: FontAwesomeIcons.moneyCheckDollar,
                                    title: 'Amount',
                                    value: data["Amount"]),
                              ),
                              Expanded(
                                child: OverallReportDashCard(
                                    isMobile: isMobile,
                                    icon: FontAwesomeIcons.handHoldingDollar,
                                    title: 'Cash',
                                    value: data["Cash"]),
                              ),
                              Expanded(
                                child: OverallReportDashCard(
                                    isMobile: isMobile,
                                    icon: FontAwesomeIcons.creditCard,
                                    title: 'Card',
                                    value: data["Card"]),
                              ),
                              Expanded(
                                child: OverallReportDashCard(
                                    isMobile: isMobile,
                                    icon: FontAwesomeIcons.chartLine,
                                    title: 'Expense',
                                    value: data["Expenses"] ?? "0.0"),
                              ),
                              const VerticalDivider(color: Colors.transparent)
                            ],
                          ),
                        ),
                        divider,
                        Text(
                          'Staffs',
                          style: poppinsHeadStyle2,
                        ),
                        divider,
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: 90 *
                                  double.parse(data["Staff"].length.toString()),
                              minHeight: 0.0),
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              // padding: const EdgeInsets.all(10),
                              itemCount: data["Staff"].length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                var currentStaff = data["Staff"][index];
                                return ListTile(
                                  title: Text(currentStaff["StaffName"]),
                                  subtitle: Text(
                                      "Bill count :  ${currentStaff["Billcount"]}"),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Bill Amount"),
                                      Text(currentStaff["Amount"]),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        divider,
                        /*  Text(
                      'Payment breakdown',
                      style: poppinsHeadStyle2,
                    ),
                    divider,
                    Container(
                      constraints:
                          const BoxConstraints(maxHeight: 200, minHeight: 56.0),

                      // height: MediaQuery.of(context).size.height / 2,
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(10),
                          itemCount: 5,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('payment type'),
                                Text('count'),
                                Text('amount'),
                              ],
                            );
                          }),
                    ), */
                        Consumer<ReportController>(
                            builder: (context, data, child) {
                          return ElevatedButton(
                            onPressed: () async {
                              await data.closeDay(context);

                              /*  data
                              .changeChairStatus(
                                  chairid: widget.chairId,
                                  status: 0,
                                  date: DateFormat('yyyy-MM-dd').format(
                                    DateTime.now(),
                                  ),
                                  staffId: widget.staffId)
                              .then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => BottomNavigation(
                                        page: 1,
                                      ),
                                    ),
                                    (route) => false),
                              ); */
                              /*  await data
                                    .updateChair(
                                        id: id,
                                        activeStaffs: null,
                                        inWork: false,
                                        currentStatus: false)
                                    .then(
                                      (value) => Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (ctx) => BottomNavigation(),
                                          ),
                                          (route) => false),
                                    ); */
                            },
                            child: const Text('CLOSE THE DAY'),
                          );
                        }),
                        space(context),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: Text("Waiting"),
                    );
                  } else {
                    return const Center(
                      child: Text("else"),
                    );
                  }
                });
      }),
    );
  }
}/* 

class OverallReportDashCard extends StatelessWidget {
  const OverallReportDashCard({
    super.key,
    required this.isMobile,
    required this.image,
    required this.title,
    required this.value,
  });

  final bool isMobile;
  final String image;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image(
              color: Colors.black38,
              height: isMobile
                  ? MediaQuery.of(context).size.height * .20 / 3
                  : MediaQuery.of(context).size.height * .20 / 3,
              image: AssetImage(image),
            ),
            const Spacer(),
            Text(
              title,
              style: titleStyle,
            ),
            const Divider(),
            Text(value),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
 */