// ignore_for_file: must_be_immutable, file_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/bottomNavigation.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
// import 'package:saloon_assist/controllers/ShopController.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/models/chairModel.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/widgets/textFormFieldWidget.dart';
import 'package:shimmer/shimmer.dart';

class ManageChairs extends StatefulWidget {
  const ManageChairs({super.key});

  @override
  State<ManageChairs> createState() => _ManageChairsState();
}

class _ManageChairsState extends State<ManageChairs> {
  @override
  void initState() {
    super.initState();
    Provider.of<ShopController>(context, listen: false).getData();
  }

  // final scaffoldState = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isTab = Responsive.isTablet(context);
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          /*   SliverAppBar(
            floating: false,
            snap: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              height: MediaQuery.of(context).size.height * 3,
            ),
            toolbarHeight: MediaQuery.of(context).size.height * .2,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SALOON ASSIST',
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Text(
                  DateFormat('yMMMd').format(
                    DateTime.now(),
                  ),
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            actions: [
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
                        showDialog(
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
                        );
                      },
                      value: 'logout',
                      child: const Text("Logout"),
                    )
                  ];
                },
              )
            ],
          ) */
        ];
      },
      body: Consumer<ShopController>(builder: (context, value, child) {
        return Scaffold(
          // key: scaffoldState,
          /*   floatingActionButton: Visibility(
            // visible: value.model!.ManageChairs != null,
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return ShowCustomeDialogue(isMobile: isMobile, val: value);
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
          ), */
          extendBody: true,
          body: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: value.getChairs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data.isNotEmpty
                          ? isMobile
                              ? ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: value.model!.chairs.length,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  itemBuilder: (context, index) {
                                    var currentData =
                                        value.model!.chairs[index];
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      color: Colors.white,
                                      child: ListTile(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          tileColor: Colors.white,
                                          leading: const CircleAvatar(
                                            child:
                                                FaIcon(FontAwesomeIcons.chair),
                                          ),
                                          subtitle: Text(currentData.type),
                                          title: Text(currentData.details),
                                          trailing: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: const Text(
                                                      'Do you want to edit the chair ?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('No'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);

                                                        showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          context: context,
                                                          builder: (context) =>
                                                              ShowCustomeDialogue(
                                                            // status:currentData. ,
                                                            isUpdate: true,
                                                            isMobile: isMobile,
                                                            val: value,
                                                            chairId: currentData
                                                                .counterId,
                                                            chairName:
                                                                currentData
                                                                    .details,
                                                            type: currentData
                                                                .type,

                                                            // data:currentData ,
                                                          ),
                                                        );
                                                      },
                                                      child: const Text('Yes'),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.edit),
                                          )),
                                    );
                                  },
                                )
                              : GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: value.model!.chairs.length,
                                  padding: const EdgeInsets.all(8),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: isTab ? 4 : 7,
                                    childAspectRatio: 1,
                                    mainAxisExtent: isMobile || isTab
                                        ? MediaQuery.of(context).size.height *
                                            .20
                                        : MediaQuery.of(context).size.height *
                                            .25,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    var currentData =
                                        value.model!.chairs[index];
                                    return Card(
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text(
                                                  'Do you want to edit the chair ?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('No'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);

                                                    showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (context) =>
                                                          ShowCustomeDialogue(
                                                        // status:currentData. ,
                                                        isUpdate: true,
                                                        isMobile: isMobile,
                                                        val: value,
                                                        chairId: currentData
                                                            .counterId,
                                                        chairName:
                                                            currentData.details,
                                                        type: currentData.type,

                                                        // data:currentData ,
                                                      ),
                                                    );
                                                  },
                                                  child: const Text('Yes'),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Expanded(
                                              child: SizedBox(),
                                            ),
                                            Image(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .1,
                                              image: const AssetImage(
                                                  'assets/newchair1.png'),
                                            ),
                                            /* CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius:
                                                  MediaQuery.of(context).size.height *
                                                      .035,
                                              child: CircleAvatar(
                                                radius: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .04,
                                                backgroundImage: const AssetImage(
                                                    'assets/newchair2.png'),
                                              ),
                                            ), */
                                            divider,
                                            Center(
                                              child: Text(
                                                currentData.details
                                                    .toUpperCase(),
                                                style: titleStyle,
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                currentData.type.toUpperCase(),
                                                style: titleStyle,
                                              ),
                                            ),
                                            const Expanded(
                                              child: SizedBox(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                          : Center(
                              child: LottieBuilder.asset(
                                  'assets/lottie/noresult.json'),
                            );
                    } else if (snapshot.hasError) {
                      return Center(
                        child:
                            LottieBuilder.asset('assets/lottie/noresult.json'),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return ListView.builder(
                        itemCount: 15,
                        itemBuilder: (context, index) => Shimmer.fromColors(
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
                    } else {
                      return const CircularProgressIndicator(
                        color: Colors.amber,
                      );
                    }
                  },
                ),
              ),
              Card(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return ShowCustomeDialogue(
                            isMobile: isMobile, val: value);
                      },
                    );
                  },
                  title: const Center(
                    child: Text('Add Chair'),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(
                      Icons.add,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
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
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  /*  Row(
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          initialvalue: isUpdate ? data!.rate : null,
                          onChanged: (v) {
                            val.setRate(v);
                          },
                          hintText: 'Rate',
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: TextFormFieldWidget(
                          initialvalue: isUpdate ? data!.tax : null,
                          onChanged: (v) {
                            val.setTax(v);
                          },
                          hintText: 'Tax',
                        ),
                      ),
                      space(context),
                    ],
                  ),
                  space(context),
                  TextFormFieldWidget(
                    initialvalue: isUpdate ? data!.type : null,
                    maxLine: 2,
                    onChanged: (v) {
                      val.setType(v);
                    },
                    hintText: 'Type',
                  ),
                  space(context),
                  TextFormFieldWidget(
                    initialvalue: isUpdate ? data!.details : null,
                    maxLine: 3,
                    onChanged: (v) {
                      val.setDetails(v);
                    },
                    hintText: 'Details',
                  ),
                  space(context), */
                  ElevatedButton(
                    onPressed: () async {
                      isUpdate
                          ? await val
                              .updateChair(context,
                                  newChairName:
                                      val.chairName ?? chairName.toString(),
                                  newChairType: val.type ?? type.toString(),
                                  chairId: chairId)
                              .then((value) => val.clearChairData())
                              .then(
                                (value) => val.getChairs(),
                              )
                              .then(
                                (value) => Navigator.pop(
                                  context,
                                  /*   MaterialPageRoute(
                                    builder: (ctx) => BottomNavigation(
                                      page: 1,
                                    ),
                                  ), */
                                ),
                              )
                          : await val
                              .addNewChair(context)
                              .then((value) => val.clearChairData())
                              .then(
                                (value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => BottomNavigation(
                                      page: 2,
                                      tabPage: 1,
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
      ),
    );
  }
}
