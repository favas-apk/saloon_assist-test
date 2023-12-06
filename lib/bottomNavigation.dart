// ignore_for_file: library_private_types_in_public_api, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/views/chairs.dart';
import 'package:saloon_assist/views/dashboard.dart';
import 'package:saloon_assist/views/explore.dart';
import 'package:saloon_assist/views/moreOptions.dart';

class BottomNavigation extends StatefulWidget {
  static const title = 'salomon_bottom_bar';

  BottomNavigation({super.key, this.page = 0, this.tabPage = 0});
  int page;
  int? tabPage;
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _currentIndex;
  late int tabPage;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.page;
    tabPage = widget.tabPage as int;
  }

  int pagessss = 0;
  List<Widget> showPages(tabIndex) {
    return [
      const Dashboard(),
      const Chairs(),
      // const ViewStaffs(),
      // const Products(),
      Explore(
        initialPage: tabIndex,
      ),
      const MoreOptions(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm exit'),
              content: const Text(
                'Do you want to exit from the app ?',
                textAlign: TextAlign.center,
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
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
        ),
        // extendBody: true,
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SalomonBottomBar(
            unselectedItemColor: Colors.white30,
            backgroundColor: primaryColor,
            currentIndex: _currentIndex,

            onTap: (i) {

              setState(() {
                print("clicked in bottom navigation $i");
                _currentIndex = i;
              });

            },
         //   onTap: (i) => setState(() => _currentIndex = i),
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: const Icon(Icons.dashboard),
                title: const Text("Dashboard"),
                selectedColor: Colors.white,
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: const FaIcon(FontAwesomeIcons.chair),
                // icon: const Icon(Icons.home),
                title: const Text("Chairs"),
                selectedColor: Colors.white,
              ),

              SalomonBottomBarItem(
                icon: const FaIcon(FontAwesomeIcons.shop),
                title: const Text("Explore"),
                selectedColor: Colors.white,
              ),
              SalomonBottomBarItem(
                icon: const FaIcon(FontAwesomeIcons.bars),
                title: const Text("More"),
                selectedColor: Colors.white,
              ),
            ],
          ),
        ),
        body: showPages(widget.tabPage)[_currentIndex],
      ),
    );
  }
}
