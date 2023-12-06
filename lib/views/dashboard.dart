// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/apiLinks/apiLinks.dart';
import 'package:saloon_assist/bottomNavigation.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/models/shopModel.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:shimmer/shimmer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    getDatas();
  }

  getDatas() async {
    await Provider.of<ShopController>(context, listen: false).getData();
    // await Provider.of<ShopController>(context, listen: false).setIsAdmin();
  }

/* @override
  void dispose() {
    Connectivity().onConnectivityChanged.cancel();
    super.dispose();
  } */
  int itemIndex = 0;
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isTab = Responsive.isTablet(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
      ),
      backgroundColor: primaryColor,
      body: Consumer<ShopController>(
        builder: (context, value, child) => FutureBuilder(
            future: value.getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    SizedBox(
                      height: isMobile || isTab ? 80 : 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          VerticalDivider(
                            color: Colors.transparent,
                            width: isMobile ? 5 : 10,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(
                              isMobile ? 30 : 35,
                            ),
                            onTap: () {},
                            child: CircleAvatar(
                              radius: isMobile
                                  ? 30
                                  : isTab
                                      ? 35
                                      : 45,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  const AssetImage('assets/logo.png'),
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.transparent,
                            width: isMobile
                                ? 7
                                : isTab
                                    ? 10
                                    : 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.model!.shopName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: isMobile || isTab ? 16 : 18),
                              ),
                              Text(
                                value.model!.address,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            children: [
                              /*   const Divider(
                                height: 8,
                                color: Colors.transparent,
                              ),
                              Visibility(
                                visible: isMobile || isTab,
                                child: SizedBox(
                                  height: !isMobile ? 300 : 200,
                                  child: Stack(
                                    children: [
                                      value.model!.images.isNotEmpty
                                          ? FutureBuilder(
                                              future: value.getData(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return CarouselSlider.builder(
                                                    itemCount: value
                                                        .model!.images.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int itemIndex,
                                                            int pageViewIndex) {
                                                      return ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child:
                                                            CachedNetworkImage(
                                                          width:
                                                              double.maxFinite,
                                                          fit: BoxFit.cover,
                                                          imageUrl: value
                                                                      .model !=
                                                                  null
                                                              ? value
                                                                  .model!
                                                                  .images[
                                                                      itemIndex]
                                                                  .url
                                                              : "",
                                                          placeholder: (context,
                                                                  url) =>
                                                              Shimmer
                                                                  .fromColors(
                                                            baseColor:
                                                                Colors.white,
                                                            highlightColor:
                                                                Colors.black12,
                                                            child:
                                                                const SizedBox(
                                                              height: 200,
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        ),
                                                      );
                                                    },
                                                    options: CarouselOptions(
                                                      onPageChanged:
                                                          (index, reason) {
                                                        setState(() {
                                                          itemIndex = index;
                                                        });
                                                      },
                                                      height:
                                                          !isMobile ? 300 : 200,
                                                      // aspectRatio: 16 / 9,
                                                      viewportFraction: .94,
                                                      initialPage: 0,
                                                      enableInfiniteScroll:
                                                          false,
                                                      reverse: false,
                                                      autoPlay: true,
                                                      autoPlayInterval:
                                                          const Duration(
                                                              seconds: 3),
                                                      autoPlayAnimationDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  800),
                                                      autoPlayCurve:
                                                          Curves.fastOutSlowIn,
                                                      enlargeCenterPage: true,
                                                      enlargeFactor: 0.3,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                    ),
                                                  );
                                                } else {
                                                  return Shimmer.fromColors(
                                                    baseColor: Colors.white,
                                                    highlightColor:
                                                        Colors.black12,
                                                    child: const SizedBox(
                                                      height: 200,
                                                    ),
                                                  );
                                                }
                                              })
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: const Image(
                                                  image: AssetImage(
                                                      'assets/dbanner.png'),
                                                ),
                                              ),
                                            ),
                                      value.model!.images.isEmpty
                                          ? const SizedBox(
                                              height: 5,
                                            )
                                          : Align(
                                              alignment: Alignment.bottomCenter,
                                              child: DotsIndicator(
                                                dotsCount:
                                                    value.model!.images.length,
                                                position: itemIndex,
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              ), */
                              ListTile(
                                title: Text(
                                  "DASHBOARD",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: isMobile || isTab ? 100 : 150,
                                child: Row(
                                  children: [
                                    Visibility(
                                        visible: !isMobile && !isTab,
                                        child: const Spacer()),
                                    Visibility(
                                      visible: isTab ? true : false,
                                      child: const SizedBox(
                                        width: 50,
                                      ),
                                    ),
                                    Expanded(
                                      child: DashCard(
                                        title: "TOTAL",
                                        values: value.model!.salesAmt,
                                      ),
                                    ),
                                    Expanded(
                                      child: DashCard(
                                        title: "EXPENSE",
                                        values: value.model!.expenses,
                                      ),
                                    ),
                                    Visibility(
                                      visible: !isMobile,
                                      child: Expanded(
                                        child: DashCard(
                                          title: "CASH",
                                          values: value.model!.cash,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: !isMobile,
                                      child: Expanded(
                                        child: DashCard(
                                          title: "CARD",
                                          values: value.model!.bank,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isTab ? true : false,
                                      child: const SizedBox(
                                        width: 50,
                                      ),
                                    ),
                                    Visibility(
                                        visible: !isMobile && !isTab,
                                        child: const Spacer()),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 4,
                                color: Colors.transparent,
                              ),
                              Visibility(
                                visible: isMobile,
                                child: SizedBox(
                                  height: isMobile ? 100 : 150,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: DashCard(
                                          title: "CASH",
                                          values: value.model!.cash,
                                        ),
                                      ),
                                      Expanded(
                                        child: DashCard(
                                          title: "CARD",
                                          values: value.model!.bank,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Colors.transparent,
                              ),
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    color: Colors.white //backgroundColor,
                                    ),
                                child: Column(
                                  // padding: const EdgeInsets.all(5),
                                  children: [
                                    /*  const Divider(
                                        color: Colors.transparent,
                                      ), */
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Chairs',
                                          style: isMobile || isTab
                                              ? poppinsStyleH2
                                              : GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (ctx) =>
                                                    BottomNavigation(
                                                  page: 2,
                                                  tabPage: 1,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'View all',
                                            style: isMobile || isTab
                                                ? poppinsStyleH2
                                                : GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: isMobile
                                          ? MediaQuery.of(context).size.width *
                                              0.35
                                          : isTab
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.30
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .30,
                                      child: FutureBuilder(
                                          future: value.getData(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              // print(value.model!.chairs);
                                              if (value
                                                  .model!.chairs.isNotEmpty) {
                                                return GridView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  shrinkWrap: false,
                                                  itemCount: value
                                                      .model!.chairs.length,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 3),
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: isMobile
                                                        ? 1
                                                        : isTab
                                                            ? 1
                                                            : 1,
                                                    //changed
                                                    childAspectRatio: 1,
                                                    mainAxisExtent: isTab
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .18
                                                        : isMobile
                                                            ? MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .3
                                                            : MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .12,
                                                    crossAxisSpacing: 0,
                                                    mainAxisSpacing: 1,
                                                  ),
                                                  itemBuilder:
                                                      (context, index) {
                                                    var currentData = value
                                                        .model!.chairs[index];
                                                    return Card(
                                                      elevation: 3,
                                                      color: Colors.white,
                                                      child: SizedBox(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CircleAvatar(
                                                                radius:
                                                                    isMobile ||
                                                                            isTab
                                                                        ? 33
                                                                        : 60,
                                                                child: Image(
                                                                    height: isMobile ||
                                                                            isTab
                                                                        ? 35
                                                                        : 45,
                                                                    image: const AssetImage(
                                                                        'assets/newchair1.png')) /* SvgPicture
                                                                  .asset(
                                                                'assets/chair.svg',
                                                                colorFilter:
                                                                    const ColorFilter
                                                                        .mode(
                                                                        Colors
                                                                            .black,
                                                                        BlendMode
                                                                            .srcIn),
                                                                height: isMobile
                                                                    ? MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .05
                                                                    : MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .08,
                                                              ), */
                                                                ),
                                                            SizedBox(
                                                              height: isMobile
                                                                  ? 3
                                                                  : 8,
                                                            ),
                                                            Text(
                                                              currentData
                                                                  .details
                                                                  .toUpperCase(),
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            /* const Divider(
                                                         color: Colors.transparent,
                                                         height: 1,
                                                       ), */
                                                            Text(
                                                              currentData.type
                                                                  .toUpperCase(),
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                return const Center(
                                                  child:
                                                      Text("No chiars found"),
                                                );
                                              }
                                            } else if (snapshot.hasError) {
                                              return const Center(
                                                child: Text('Error occured'),
                                              );
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                enabled: true,
                                                child: GridView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: 5,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 3),
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: isMobile
                                                        ? 1
                                                        : isTab
                                                            ? 1
                                                            : 2,
                                                    childAspectRatio: 1,
                                                    mainAxisExtent: isTab
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .18
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .3,
                                                    crossAxisSpacing: 0,
                                                    mainAxisSpacing: 1,
                                                  ),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return const Card(
                                                      elevation: 3,
                                                      color: Colors.blueGrey,
                                                      child: SizedBox(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          }),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      // height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Staffs',
                                            style: isMobile || isTab
                                                ? poppinsStyleH2
                                                : GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      BottomNavigation(
                                                    page: 2,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'View all',
                                              style: isMobile || isTab
                                                  ? poppinsStyleH2
                                                  : GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 400,
                                        child: LimitedBox(
                                          maxHeight: 80 *
                                                  value.model!.staffs.length
                                                      .toDouble() +
                                              70,
                                          child: Consumer<ShopController>(
                                              builder: (context, value, child) {
                                            return FutureBuilder(
                                                future: value.getData(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (value.model!.staffs
                                                        .isNotEmpty) {
                                                      return ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount: value
                                                                    .model!
                                                                    .staffs
                                                                    .length <=
                                                                5
                                                            ? value.model!
                                                                .staffs.length
                                                            : 5,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var staffData = value
                                                              .model!
                                                              .staffs[index];
                                                          return Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            color: Colors.white,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: ListTile(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                leading: CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    backgroundImage:
                                                                        NetworkImage(imageUrl +
                                                                            staffData.img)),
                                                                title: Text(
                                                                    staffData
                                                                        .staffName),
                                                                /*  subtitle: Text(
                                                                      staffData
                                                                          .email), */
                                                                trailing:
                                                                    Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Text(
                                                                        'Amount'),
                                                                    Text(
                                                                        "${staffData.sales}.00"),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      return const Center(
                                                        child:
                                                            Text("No staffs"),
                                                      );
                                                    }
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return const Center(
                                                      child:
                                                          Text('Error occured'),
                                                    );
                                                  } else if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder: (context,
                                                              index) =>
                                                          Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        child: const Card(
                                                          child: ListTile(
                                                            title: Text('data'),
                                                            subtitle:
                                                                Text('data'),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return const Center(
                                                      child: Text('No data'),
                                                    );
                                                  }
                                                });
                                          }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        )
                      ],
                    )),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: SpinKitRipple(
                  size: 50,
                  color: Colors.white,
                ));
              } else if (snapshot.hasError) {
                return Center(
                  child: Lottie.asset('assets/lottie/noresult.json'),
                );
              } else {
                return Center(
                  child: Lottie.asset('assets/lottie/internet.json'),
                );
              }
            }),
      ),
    );
  }

  getProof(String staffid, List<Proof> proof) {
    for (int i = 0; i < proof.length; i++) {
      if (staffid == proof[i].staffId) {
        return proof[i];
      } else {}
    }
  }
}

class DashCard extends StatelessWidget {
  DashCard({
    required this.title,
    required this.values,
  });
  final String title;
  final String values;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
        15,
      )),
      color: Colors.white, // const Color(0xffF7DAD9),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: Divider(
                height: 5,
                color: Colors.transparent,
              ),
            ),
            Consumer<ShopController>(builder: (context, value, child) {
              return Text(
                "$values.00",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              );
            })
          ],
        ),
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
