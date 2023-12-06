// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/views/chairs.dart';
import 'package:saloon_assist/views/moreOptions.dart';

class StaffHomeScreen extends StatefulWidget {
  // final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  StaffHomeScreen({super.key, required this.page});
  int page;
  @override
  State<StaffHomeScreen> createState() => _StaffHomeScreenState();
}

class _StaffHomeScreenState extends State<StaffHomeScreen> {
  @override
  void initState() {
    super.initState();
    initalPage = widget.page;
    getDatas();
  }

  getDatas() async {
    Provider.of<ShopController>(context, listen: false).setIsAdmin();
    await Provider.of<ShopController>(context, listen: false).getModel();
  }

  int initalPage = 0;
  @override
  Widget build(BuildContext context) {
    // bool isMobile = Responsive.isMobile(context);
    // bool isTab = Responsive.isTablet(context);

    return DefaultTabController(
      initialIndex: initalPage,
      length: 2,
      child: Scaffold(
        // key: _scaffoldkey,
        appBar: AppBar(
          toolbarHeight: 85,
          elevation: 0,
          flexibleSpace:
              Consumer<ShopController>(builder: (context, value, child) {
            return SizedBox(
              // height: ,
              child: Consumer<ShopController>(builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*  const VerticalDivider(
                        color: Colors.transparent,
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          // backgroundColor: colorScheme.background,
                          radius: isMobile ? 35 : 45,
                          backgroundImage: const AssetImage('assets/applogo.png'),
                        ),
                      ),
                      const VerticalDivider(
                        width: 5,
                        color: Colors.transparent,
                      ), */
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
            );
          }),
          bottom: const TabBar(
              unselectedLabelColor: Colors.white54,
              indicatorColor: Colors.white,
              /*  onTap: Provider.of<ShopController>(context, listen: false)
                      .isBottomSheetOpened
                  ? (index) {
                      Navigator.pop(context);
                    }
                  : (dii) {}, */
              labelColor: Colors.white,
              tabs: [
                Tab(
                  text: 'Chairs',
                  //   icon: FaIcon(FontAwesomeIcons.chair),
                ),
                Tab(
                  text: 'More',
                  //   icon: FaIcon(FontAwesomeIcons.gears),
                ),
                /*  Tab(
              text: 'Services',
              icon: Icon(
                Icons.local_grocery_store_sharp,
              ),
            ), */
              ]),
        ),
        body: const TabBarView(
          children: [
            Chairs(), MoreOptions(),

            // Services(),
          ],
        ),
      ),
    );
  }
}
