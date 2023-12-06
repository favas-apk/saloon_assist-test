// ignore_for_file: must_be_immutable, file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/apiLinks/apiLinks.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/views/closeWork.dart';
// import 'package:saloon_assist/views/search_blutooth_devices.dart';

class ChairCard extends StatefulWidget {
  ChairCard({
    super.key,
    this.onEdit,
    required this.status,
    required this.entryTime,
    required this.name,
    required this.chairID,
    required this.shopId,
    required this.staffId,
    required this.chairName,
    required this.data,
    required this.entryDate,
    required this.lastActiveTime,
  });
  void Function()? onEdit;
  String status;
  String entryTime;
  String? name;
  String chairName;
  String chairID;
  String shopId;
  String staffId;
  String entryDate;
  String lastActiveTime;
  var data;

  @override
  State<ChairCard> createState() => _ChairCardState();
}

class _ChairCardState extends State<ChairCard> {
  TextStyle textStyle = const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    bool isTab = Responsive.isTablet(context);
    bool isMobile = Responsive.isMobile(context);
    return Center(
      child: InkWell(

        onTap: () {
          print("clicked 1 chair");

          widget.status == 'In Work'
              ?
              () {
            print("  clicked on  - inwork");
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Confirm'),
                  content: const Text('Do you want to close the work ?'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),

                    TextButton(
                      onPressed: () async {
                        final DateTime now = DateTime.now();
                        Navigator.pop(context);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => CloseWork(
                                entryDate: widget.entryDate,
                                staffId: widget.staffId,
                                chairId: widget.chairID,
                                startedTime: widget.entryTime,
                                activeStaff: widget.name.toString(),
                                id: 'id',
                                endTime: DateFormat('hh:mm a').format(now)),
                          ),
                        );
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          } ()


              :


          widget.status == 'Active'
              ?
          () {

            print("  clicked on  - Active only");

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Center(child: Text('Choose')),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      divider,
                      Visibility(
                          visible:
                          widget.status == 'In Work' ? false : true,
                          child: Consumer<ShopController>(
                              builder: (context, data, child) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    /*  var path = await Pdf.getPdf(
                                            shopName: data.model!.shopName,
                                            staffId: widget.staffId,
                                            time: DateFormat('HH.mm:ss').format(
                                              DateTime.now(),
                                            ),
                                            date: DateFormat('yyyy-MM-dd').format(
                                              DateTime.now(),
                                            )); */
                                    /*   Fluttertoast.showToast(
                                            msg: "File Saved in $path"); */

                                    print("changing chair status to 2");
                                    await data.changeChairStatus(
                                      context: context,
                                      staffId: widget.staffId,
                                      chairid: widget.chairID,
                                      status: 2,
                                      date: DateFormat('yyyy-MM-dd').format(
                                        DateTime.now(),
                                      ),
                                    );
                                    /*  .then(
                                                (value) => /* OpenFile.open(path)
                                                .then((value) => */
                                                    Navigator.pop(context) );*/

                                    /* Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (ctx) =>
                                                  SearchBlutoothDevices(
                                                      chairID: widget.chairID,
                                                      id: widget.staffId),
                                            )); */
                                  },
                                  child: const Text('Start a new work'),
                                );
                              })),
                      const SizedBox(
                        height: 3,
                      ),
                      Visibility(
                          visible:
                          widget.status == 'In Work' ? false : true,
                          child: Consumer<ShopController>(
                              builder: (context, data, child) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    await data.changeChairStatus(
                                      context: context,
                                      staffId: widget.staffId,
                                      chairid: widget.chairID,
                                      status: 0,
                                      date: DateFormat('yyyy-MM-dd').format(
                                        DateTime.now(),
                                      ),
                                    ) /*
                                            .then((value) =>
                                                Navigator.pop(context)) */
                                    ;
                                  },
                                  child: const Text('Stop works'),
                                );
                              })),
                      const SizedBox(
                        height: 3,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                );
              },
            );
          } ()


              :
          ()
          {
            print("    clicked on  - not active and  not inwork  ie-INACTIVE");
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        height: isMobile
                            ? MediaQuery.of(context).size.height * 0.10
                            : MediaQuery.of(context).size.height * 0.08,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CircleAvatar(
                              child: Icon(Icons.question_mark),
                            ),
                            const VerticalDivider(
                              color: Colors.transparent,
                            ),
                            const Text(
                              'Whats your name ?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const Expanded(child: SizedBox()),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const FaIcon(
                                  FontAwesomeIcons.angleDown),
                            ),
                          ],
                        ),
                      ),


                      SizedBox(
                        height:
                        MediaQuery.of(context).size.height * 0.3,
                        child: Consumer<ShopController>(
                            builder: (context, datas, child) {
                              return ListView.separated(
                                  controller: ScrollController(),
                                  itemBuilder: (context, index) {
                                    var currentData =
                                    datas.model!.staffs[index];
                                    // getActiveStaffs(currentData.staffId);
                                    return ListTile(
                                      onTap: () async {
                                        print("clicked on staff name - now status is ${currentData.workStatus}");
                                        currentData.workStatus == "1" ||
                                            currentData
                                                .workStatus ==
                                                "2"
                                            ? () {}
                                            : await datas
                                            .changeChairStatus(
                                            context: context,
                                            staffId: currentData
                                                .staffId,
                                            chairid:
                                            widget.chairID,
                                            status: 1,
                                            date: DateFormat(
                                                'yyyy-MM-dd')
                                                .format(
                                              DateTime.now(),
                                            ))
                                        /*  .then(
                                                              (value) => Navigator.pop(
                                                                  context),
                                                            ) */
                                        ;
                                      },
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            imageUrl + currentData.img),
                                      ),
                                      // subtitle: const Text(''),
                                      title: Text(
                                        currentData.staffName.toUpperCase(),
                                        style: currentData.workStatus ==
                                            "1" ||
                                            currentData.workStatus ==
                                                "2"
                                            ? const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black26)
                                            : const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                      subtitle: Text(
                                        currentData.workStatus == "1" ||
                                            currentData.workStatus ==
                                                "2"
                                            ? "already assigned a chair"
                                            : "tap to assign work",
                                        style: currentData.workStatus != "0"
                                            ? const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black26)
                                            : const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                  const Divider(),
                                  itemCount: datas.model!.staffs.length);
                            }),
                      )
                    ],
                  ),
                );
              },
            );

          } ();










        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Card(
                color: widget.status == 'Active'
                    ? const Color.fromARGB(255, 167, 238, 152)
                    : widget.status == 'Inactive'
                        ? const Color.fromARGB(202, 250, 200, 124)
                        : const Color.fromARGB(255, 243, 143, 138),
                elevation: 3,
                // color: const Color.fromARGB(221, 243, 225, 225),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    /*   height: isTab
                        ? MediaQuery.of(context).size.height * .38
                        : isMobile
                            ? MediaQuery.of(context).size.height * .33
                            : 300, */
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: Image(
                                height: isTab
                                    ? MediaQuery.of(context).size.height * .10
                                    : isMobile
                                        ? 45
                                        : 50,
                                image: AssetImage(
                                  widget.status == 'In Work'
                                      ? 'assets/newchair2.png'
                                      : 'assets/newchair3.png',
                                ),
                                color: widget.status == 'In Work'
                                    ? Colors.black
                                    : widget.status == 'Active'
                                        ? Colors.black
                                        : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.chairName.toUpperCase(),
                          style: poppinsStyleH2,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Divider(
                            height: 2,
                            // color: Colors.transparent,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Status',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Center(
                                  child: Text(':  '),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      widget.status,
                                      style: widget.status != "Inactive"
                                          ? textStyle
                                          : const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black26),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 2,
                              color: Colors.transparent,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Center(
                                  child: Text(':  '),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    widget.status == 'Active' ||
                                            widget.status == 'In Work'
                                        ? widget.name.toString()
                                        : 'Not activated',
                                    overflow: TextOverflow.ellipsis,
                                    style: widget.status != "Inactive"
                                        ? textStyle
                                        : const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black26),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 2,
                              color: Colors.transparent,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Time',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Center(
                                  child: Text(':  '),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    widget.status == 'In Work'
                                        ? widget.entryTime.toString()
                                        : 'No In Work',
                                    overflow: TextOverflow.ellipsis,
                                    style: widget.status != "Inactive"
                                        ? textStyle
                                        : const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black26),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Last Active Time',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Center(
                                  child: Text(':  '),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    widget.lastActiveTime != "no works yet"
                                        ? slitTime(
                                            originalString:
                                                widget.lastActiveTime)
                                        : "00:00:00",
                                    style: widget.lastActiveTime ==
                                                "no works yet" ||
                                            widget.status == "Inactive"
                                        ? const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black26)
                                        : textStyle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> activeStaffIds = [];

  getActiveStaffs(String staffId) {
    // bool isActive;
    for (int i = 0; i < widget.data.length - 1; i++) {
      if (widget.data[i]["StaffID"] == staffId) {
        setState(() {
          activeStaffIds.add(staffId);
        });
      }
      /*   for (int j = 0; i < staffs.length - 1; j++) {
      
      } */
      // isActive = false;
    }
    // return isActive;
  }

  String slitTime({required String originalString}) {
    List<String> parts =
        originalString != "" ? originalString.split(' ') : ["00:00:00", ""];
    String time = parts[0];
    List<String> timeParts = time.split(':');
    String trimmedString = "${timeParts[0]}:${timeParts[1]} ${parts[1]}";
    return trimmedString;
    // print(trimmedString); // Output: 12:10 PM
  }
}
