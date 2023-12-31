// ignore_for_file: file_names

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/apiLinks/apiLinks.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/models/shopModel.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/views/addStaffScreen.dart';
import 'package:saloon_assist/views/viewStaffDetails.dart';

class ViewStaffs extends StatefulWidget {
  const ViewStaffs({super.key});

  @override
  State<ViewStaffs> createState() => _ViewStaffsState();
}

class _ViewStaffsState extends State<ViewStaffs> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  int random = 0;
  getData() async {
    var rng = Random();
    await Provider.of<ShopController>(context, listen: false).getData();

    random = rng.nextInt(100);
  }


  Widget _buildListView(BuildContext context) {
    return Consumer<ShopController>(
      builder: (context, data, child) {
        return ListView.builder(
          itemCount: data.model!.staffs.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            var currentData = data.model!.staffs[index];

            return Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => ViewStaffDetails(
                        data: currentData,
                        proofData: getProof(currentData.staffId, data.model!.proofs),
                      ),
                    ),
                  );
                },
                trailing: const SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                ),
                leading: CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const Image(
                        image: AssetImage('assets/default.png'),
                      ),
                      imageUrl: "$imageUrl${currentData.img}?v=$random",
                    ),
                  ),
                ),
                title: Text(
                  currentData.staffName.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(currentData.mobile),
              ),
            );
          },
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isTab = Responsive.isTablet(context);
    return Scaffold(
        /*   floatingActionButton: isMobile
            ? FloatingActionButton(
                tooltip: 'Add new staff',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => AddStaffScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.group_add_rounded),
              )
            : FloatingActionButton(
                tooltip: 'Add staff',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => AddStaffScreen(),
                    ),
                  );
                },
                child: const FaIcon(
                  FontAwesomeIcons.userPlus,
                  // size: 50,
                ),
              ), */
        body: Column(
      children: [

        Expanded(
          child: context.read<ShopController>().model != null
              ? context.read<ShopController>().model!.staffs.isNotEmpty ? isMobile ?

          Consumer<ShopController>(
                          builder: (context, data, child) {
                          return ListView.builder(
                              itemCount: data.model!.staffs.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var currentData = data.model!.staffs[index];
                                // var imageurl =
                                //     "$imageUrl${currentData.img}?v=$random";
                                // print(imageurl);
                                return Card(
                                  color: Colors.white,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (ctx) => ViewStaffDetails(
                                            data: currentData,
                                            proofData: getProof(
                                                currentData.staffId,
                                                data.model!.proofs),
                                          ),
                                        ),
                                      );
                                    },
                                    trailing: const SizedBox(
                                      // width: ,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.black12,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // onTap: () {},
                                    leading: CircleAvatar(
                                      // key:
                                      //     ValueKey("$imageUrl${currentData.img}?v=1"),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                const Image(
                                                  image: AssetImage(
                                                      'assets/default.png'),
                                                ),
                                            imageUrl:
                                                "$imageUrl${currentData.img}?v=$random"),
                                      ),
                                    ),
                                    title: Text(
                                      currentData.staffName.toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(currentData.mobile),
                                  ),
                                );
                              });
                        })

                      :

          Consumer<ShopController>(
                          builder: (context, data, child) {
                          return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.model!.staffs.length,
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isTab ? 4 : 6,
                              childAspectRatio: 1,
                              mainAxisExtent: isTab || isMobile
                                  ? MediaQuery.of(context).size.height * .20
                                  : MediaQuery.of(context).size.height * .25,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                            ),
                            itemBuilder: (context, index) {
                              var currentData = data.model!.staffs[index];
                              return Card(
                                elevation: 1,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => ViewStaffDetails(
                                          proofData: getProof(
                                              currentData.staffId,
                                              data.model!.proofs),
                                          data: currentData,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                        child: SizedBox(),
                                      ),
                                      /* Image(
                                  // color: Colors.black12,
                                  height:
                                      MediaQuery.of(context).size.height * .08,
                                  image: const AssetImage(
                                    'assets/default.png',
                                  ),
                                ), */
                                      CircleAvatar(
                                        backgroundColor: primaryColor,
                                        radius: isMobile || isTab
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .035
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .030,
                                        child: CircleAvatar(
                                            radius: isMobile || isTab
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .04
                                                : MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .038,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                              child: CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      const Image(
                                                        image: AssetImage(
                                                            'assets/default.png'),
                                                      ),
                                                  imageUrl:
                                                      "$imageUrl${currentData.img}?v=$random"),
                                            )),
                                      ),
                                      divider,
                                      /*  Center(
                                  child: Text(
                                    'ID :${currentData.staffId.toUpperCase()}',
                                    style: titleStyle,
                                  ),
                                ), */
                                      Center(
                                        child: Text(
                                          currentData.staffName.toUpperCase(),
                                          style: titleStyle,
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          currentData.mobile.toUpperCase(),
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
                          );
                        })
                  : Center(
                      child: LottieBuilder.asset('assets/lottie/noresult.json'),
                    )
              : Center(
                  child: LottieBuilder.asset('assets/lottie/noresult.json'),
                ),
        ),


        Card(
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => AddStaffScreen(),
                ),
              );
            },
            title: const Center(
              child: Text('Add Staff'),
            ),
            trailing: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: const Icon(
                Icons.person_add,
                color: Colors.black38,
              ),
            ),
          ),
        ),
      ],
    ));
  }

  getProof(String staffid, List<Proof> proof) {
    List<Proof> staffProofs = [];
    for (int i = 0; i < proof.length; i++) {
      if (staffid == proof[i].staffId) {
        staffProofs.add(proof[i]);
      } else {}
    }
    return staffProofs;
  }
}
