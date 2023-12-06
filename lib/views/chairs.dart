// ignore_for_file: must_be_immutable, file_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/bottomNavigation.dart';
import 'package:saloon_assist/chairCardTest.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
// import 'package:saloon_assist/controllers/ShopController.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/models/chairModel.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/widgets/textFormFieldWidget.dart';
import 'package:shimmer/shimmer.dart';

class Chairs extends StatefulWidget {
  const Chairs({super.key});

  @override
  State<Chairs> createState() => _ChairsState();
}

class _ChairsState extends State<Chairs> {
  @override
  void initState() {
    super.initState();
    getDatas();
  }

  getDatas() async {
    Provider.of<ShopController>(context, listen: false).setIsAdmin();
    await Provider.of<ShopController>(context, listen: false).getData();
  }

  final scaffoldState = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    print("reached chair ");

    bool isMobile = Responsive.isMobile(context);
    bool isTab = Responsive.isTablet(context);
    // bool isAdmin = Provider.of<ShopController>(context, listen: false).isAdmin;
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          const SliverAppBar(
            // backgroundColor: Colors.transparent,
            centerTitle: true,
            /*  flexibleSpace: Container(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              height: MediaQuery.of(context).size.height * 3,
            ),*/
            toolbarHeight: 0,
            /* title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*  Text(
                  'SALOON ASSIST',
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const Divider(
                  color: Colors.transparent,
                ), */
                Text(
                  DateFormat('yMMMd').format(
                    DateTime.now(),
                  ),
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ],
            ), */
            automaticallyImplyLeading: false,
            /*  actions: [
              PopupMenuButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                icon: const FaIcon(FontAwesomeIcons.bars),
                elevation: 5,
                color: Colors.white,
                onSelected: (valueue) {},
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                      
                        /*   showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Confirm Log Out'),
                              content: const Text('Do you want to logout ?'),
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
                        ); */
                      },
                      value: 'Close Day',
                      child: const Text("Close Day"),
                    )
                  ];
                },
              )
            ], */
          )
        ];
      },
      body: Consumer<ShopController>(builder: (context, value, child) {
        return Scaffold(
          backgroundColor: primaryColor,
          key: scaffoldState,
          extendBody: true,
          body: Column(
            children: [
              Visibility(
                visible: value.model != null
                    ? value.model!.userType == "SHOP-ADMIN"
                    : false,
                child: Container(
                  height: 70,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      DateFormat('yMMMd').format(
                        DateTime.now(),
                      ),
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 8, left: 2, right: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: value.model != null
                        ? value.model!.userType == "SHOP-ADMIN"
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )
                            : BorderRadius.circular(0)
                        : BorderRadius.circular(0),
                  ),
                  child: FutureBuilder(
                    future: value.getChairsStatus(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isNotEmpty) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ChoiceChip(
                                      onSelected: (p) =>
                                          value.changeFilterOptions('all'),
                                      selectedColor: const Color.fromARGB(
                                          255, 164, 185, 207),
                                      showCheckmark: false,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      label: const Text("All"),
                                      selected: value.isAllChairs),
                                  const VerticalDivider(),
                                  ChoiceChip(
                                      onSelected: (p) =>
                                          value.changeFilterOptions('inwork'),
                                      selectedColor: const Color.fromARGB(
                                          255, 243, 143, 138),
                                      showCheckmark: false,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      label: const Text("In Work"),
                                      selected: value.isInworkChairs),
                                  const VerticalDivider(),
                                  ChoiceChip(
                                      onSelected: (p) =>
                                          value.changeFilterOptions('active'),
                                      selectedColor: const Color.fromARGB(
                                          255, 167, 238, 152),
                                      showCheckmark: false,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      label: const Text("Active"),
                                      selected: value.isActiveChairs),
                                  const VerticalDivider(),
                                  ChoiceChip(
                                      onSelected: (p) =>
                                          value.changeFilterOptions('inactive'),
                                      selectedColor: const Color.fromARGB(
                                          202, 250, 200, 124),
                                      showCheckmark: false,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      label: const Text("Inactive"),
                                      selected: value.isInactiveChairs),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Divider(
                                  color: Colors.black12,
                                ),
                              ),
                              Expanded(
                                child: chairWidget(
                                    snapshot.data,
                                    value.isAllChairs
                                        ? "3"
                                        : value.isActiveChairs
                                            ? "1"
                                            : value.isInactiveChairs
                                                ? "0"
                                                : "2",
                                    isMobile,
                                    isTab,
                                    value),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: LottieBuilder.asset(
                                'assets/lottie/noresult.json'),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Lottie.asset('assets/lottie/internet.json'),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: 4,
                          padding: const EdgeInsets.all(0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isMobile
                                ? 3
                                : isTab
                                    ? 3
                                    : 6,
                            childAspectRatio: 1,
                            mainAxisExtent: isTab
                                ? MediaQuery.of(context).size.height * .25
                                : isMobile
                                    ? MediaQuery.of(context).size.height * .28
                                    : 300,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                          ),
                          itemBuilder: (context, index) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: ChairCard(
                                lastActiveTime: "",
                                chairName: '',
                                entryDate: '',
                                staffId: '',
                                data: '',
                                chairID: '',
                                shopId: '',
                                status: '',
                                name: '',
                                entryTime: '',
                              )),
                        );
                      } else {
                        return const CircularProgressIndicator(
                          color: Colors.amber,
                        );
                      }
                    },
                  ),
                ),
              ),
              /*  Container(
                color: backgroundColor,
                height: 80,
              ) */
            ],
          ),
        );
      }),
    );
  }

  chairWidget(List chairList, String filter, bool isMobile, bool isTab,
      ShopController value) {
    List list = filter != "3"
        ? chairList.where((e) => e["Status"] == filter).toList()
        : chairList;
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      padding: const EdgeInsets.symmetric(vertical: 2),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile
            ? 3
            : isTab
                ? 3
                : 7,
        childAspectRatio: 1,
        // mainAxisSpacing: 2,
        mainAxisExtent: isTab
            ? MediaQuery.of(context).size.height * .26
            : isMobile
                ? 200
                : 210,
      ),
      itemBuilder: (context, index) {
        if (list.isEmpty) {
          return const Center(
            child: Text("No Chairs found"),
          );
        } else {
          var currentData = list[index];
          return ChairCard(
            onEdit: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Do you want to edit this chair ?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        print("111");
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
print("cvcxvxc");
                        Navigator.pop(context);
                        scaffoldState.currentState!
                            .showBottomSheet((context) => ShowCustomeDialogue(
                                  isUpdate: true,
                                  isMobile: isMobile,
                                  val: value,
                                  chairId: currentData.counterId,
                                  chairName: currentData.details,
                                  type: currentData.type,
                                ));
                      },
                      child: const Text('Yes'),
                    )
                  ],
                ),
              );
            },
            lastActiveTime: currentData["LastWorkTime"] == "00:00:00" ||
                    currentData["LastWorkTime"] == null
                ? "no works yet"
                : currentData["LastWorkTime"],
            chairName: currentData["Details"],
            chairID: currentData['CounterID'],
            shopId: currentData['ShopID'],
            status: currentData['Status'] == '1'
                ? "Active"
                : currentData['Status'] == "0"
                    ? 'Inactive'
                    : 'In Work',
            name: currentData['StaffName'],
            entryTime: slitTime(originalString: currentData['EntryTime']),
            data: list,
            staffId: currentData['StaffID'],
            entryDate: currentData['EntryDate'],
          );
        }
      },
    );
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

class ShowCustomeDialogue extends StatelessWidget {
  ShowCustomeDialogue({
    super.key,
    required this.isMobile,
    required this.val,
    this.isUpdate = false,
    this.data,
    this.chairName,
    this.type,
    this.chairId,
    this.status,
  });

  final bool isMobile;
  final ShopController val;
  bool isUpdate;
  ChairModel? data;
  String? chairName;
  String? chairId;
  String? type;
  String? status;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: !isMobile
                ? MediaQuery.of(context).size.height * 0.10
                : MediaQuery.of(context).size.height * 0.09,
            child: Center(
              child: Text(
                isUpdate ? 'Update Chair' : 'Add Chair',
                style: whiteText,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormFieldWidget(
                  initialvalue: isUpdate ? chairName : null,
                  onChanged: (v) {
                    val.setchairName(v);
                  },
                  hintText: 'Chair Name',
                ),
                space(context),
                TextFormFieldWidget(
                  initialvalue: isUpdate ? type : null,
                  onChanged: (v) {
                    val.setchairType(v);
                  },
                  hintText: 'Chair type',
                ),
                space(context),
                ElevatedButton(
                  onPressed: () async {
                    print("111");
                    isUpdate
                        ? await val
                            .updateChair(context,
                                newChairName:
                                    val.chairName ?? chairName.toString(),
                                newChairType: val.type ?? type.toString(),
                                chairId: chairId)
                            .then(
                              (value) => val.getData(),
                            )
                            .then(
                              (value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => BottomNavigation(
                                    page: 1,
                                  ),
                                ),
                              ),
                            )
                        : await val.addNewChair(context).then(
                              (value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => BottomNavigation(
                                    page: 1,
                                  ),
                                ),
                              ),
                            );
                  },
                  child: Text(isUpdate ? 'Update Chair' : 'Add Chair'),
                ),
              ],
            ),
          ),
          divider,
        ],
      ),
    );
  }
}
