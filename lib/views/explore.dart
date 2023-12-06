// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saloon_assist/views/manageChairs.dart';
import 'package:saloon_assist/views/products.dart';
import 'package:saloon_assist/views/viewStaffs.dart';

class Explore extends StatefulWidget {
  // final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  Explore({super.key, this.initialPage});
  int? initialPage;

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initialPage as int,
      length: 3,
      child: Scaffold(
        // key: _scaffoldkey,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          bottom: const TabBar(
              unselectedLabelColor: Colors.white54,
              /*  onTap: Provider.of<ShopController>(context, listen: false)
                      .isBottomSheetOpened
                  ? (index) {
                      Navigator.pop(context);
                    }
                  : (dii) {}, */
              labelColor: Colors.white,
              tabs: [
                Tab(
                  height: 95,
                  text: 'Staffs',
                  icon: FaIcon(
                    FontAwesomeIcons.userTie,
                  ),
                ),


                Tab(
                  text: 'Chairs',
                  icon: FaIcon(FontAwesomeIcons.chair),
                ),
                Tab(
                  text: 'Products',
                  icon: FaIcon(FontAwesomeIcons.cartShopping),
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
            ViewStaffs(), ManageChairs(),
            Products(),

            // Services(),
          ],
        ),
      ),
    );
  }
}
