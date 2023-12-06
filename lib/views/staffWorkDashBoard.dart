// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/widgets/dashCard.dart';

class StaffWordDashBoard extends StatelessWidget {
  StaffWordDashBoard({super.key, required this.staffName});
  String staffName;
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Work Dash Board',
              style: poppinsHeadStyle2,
            ),
            const Divider(
              color: Colors.black12,
            ),
            Text(
              DateFormat('yMMMd').format(
                DateTime.now(),
              ),
            ),
          ],
        ),
        toolbarHeight: MediaQuery.of(context).size.height * .2,
      ),
      body: Padding(
        padding:
            isMobile ? const EdgeInsets.all(8.0) : const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: Center(
                    child: Text(
                      staffName.toString().toUpperCase(),
                      style: poppinsHeadStyle2,
                    ),
                  ),
                  subtitle: const Center(
                    child: Text('Staff Name'),
                  ),
                ),
              ),
              isMobile
                  ? const SizedBox(
                      height: 2,
                    )
                  : const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DashCard(
                        asset: 'assets/works.png', title: 'WORKS', value: '15'),
                  ),
                  Expanded(
                    child: DashCard(
                      asset: 'assets/time.png',
                      title: ' WORK HOURS',
                      value: '8',
                    ),
                  ),
                  isMobile
                      ? const SizedBox(
                          width: 0,
                        )
                      : Expanded(
                          child: DashCard(
                              asset: 'assets/clock.png',
                              title: 'START TIME',
                              value: '11.30'),
                        ),
                  isMobile
                      ? const SizedBox(
                          width: 0,
                        )
                      : Expanded(
                          child: DashCard(
                              asset: 'assets/endclock.png',
                              title: 'END TIME',
                              value: '12.30'),
                        ),
                ],
              ),
              isMobile
                  ? const SizedBox(height: 5)
                  : const SizedBox(
                      height: 15,
                    ),
              Visibility(
                visible: isMobile,
                child: Row(
                  children: [
                    Expanded(
                      child: DashCard(
                          asset: 'assets/clock.png',
                          title: 'START TIME',
                          value: '11.30'),
                    ),
                    VerticalDivider(
                      width: isMobile
                          ? MediaQuery.of(context).size.width * 0.0001
                          : MediaQuery.of(context).size.width * 0.02,
                    ),
                    Expanded(
                      child: DashCard(
                          asset: 'assets/endclock.png',
                          title: 'END TIME',
                          value: '12.30'),
                    ),
                  ],
                ),
              ),
              space(context),
              SizedBox(
                height: isMobile ? 50 : 60,
                width: MediaQuery.of(context).size.width * .5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                   /*  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>  CloseWork(),
                      ),
                    ); */
                  },
                  child: Text(
                    'Finish Work',
                    style: whiteText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
