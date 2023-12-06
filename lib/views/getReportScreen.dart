// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/views/billingReports.dart';
import 'package:saloon_assist/views/expenseReport.dart';
import 'package:saloon_assist/views/individualReport.dart';

class GetReportsScreen extends StatelessWidget {
  const GetReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              // leading: const Icon(Icons.wallpaper),
              title: Text(
                "Reports",
                style: whiteText,
              ),
              centerTitle: true,
              elevation: 10.0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white38,
                  )),
              automaticallyImplyLeading: true,
              // expandedHeight: 50,
              floating: true,
              snap: true,
              // pinned: true,
              bottom: const TabBar(
                indicatorColor: Colors.white,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white38,
                padding: EdgeInsets.all(5),
                /*  indicator: BoxDecoration(
                  color: const Color.fromARGB(255, 21, 108, 112),
                  borderRadius: BorderRadius.circular(10),
                ), */
                tabs: [
                  Tab(
                    /*  icon: Icon(
                      Icons.person,
                    ), */
                    text: 'STAFF',
                  ),
                  Tab(
                    /*  icon: Icon(
                      Icons.document_scanner_rounded,
                    ), */
                    text: 'EXPENSE',
                  ),
                  Tab(
                    /*   icon: Icon(
                      Icons.document_scanner_rounded,
                    ), */
                    text: 'BILLING',
                  ),
                ],
              ),
            ),
          ];
        },
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            IndividualReports(),
            ExpenseReport(),
            BillingReport(),
          ],
        ),
      ),
    );

    /*  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Reports'), centerTitle: true,
          // toolbarHeight: 0,
          bottom: TabBar(
            padding: const EdgeInsets.all(5),
            indicator: BoxDecoration(
              color: const Color.fromARGB(255, 21, 108, 112),
              borderRadius: BorderRadius.circular(10),
            ),
            tabs: const [
              Tab(
                icon: Icon(Icons.person),
                text: 'Individual Reports',
              ),
              Tab(
                icon: Icon(
                  Icons.document_scanner_rounded,
                ),
                text: 'Overall Report',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            IndividualReports(),
            OverallReports(),
          ],
        ),
      ),
    ); */
  }
}
