// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/productControllers.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/models/productModel.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/widgets/textFormFieldWidget.dart';
import 'package:shimmer/shimmer.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    bool isMobile = Responsive.isMobile(context);
    bool isTab = Responsive.isTablet(context);

    return Consumer<ProductController>(builder: (context, val, child) {
      return Scaffold(
        // resizeToAvoidBottomInset: true,
        key: scaffoldKey,
        /*   floatingActionButton: Visibility(
          child: FloatingActionButton(
            onPressed: () {
              showBottomSheet(
                context: context,
                builder: (context) {
                  return ShowCustomeDialogue(isMobile: isMobile, val: val);
                },
              );
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        ), */
        /*   appBar: AppBar(
          title: Text(
            'Products',
            style: whiteText,
          ),
        ), */
        body: Column(
          children: [
            /*  Visibility(
              child: InkWell(
                onTap: () {
                  val.getAllProduts();
                  /*   showBottomSheet(
                                context: context,
                                builder: (context) {
                                  return ShowCustomeDialogue(
                                      isMobile: isMobile, val: val);
                                },
                              ); */
                },
                child: SizedBox(
                  height: isMobile ? 80 : 100,
                  child: const Card(
                    child: Center(
                      child: ListTile(
                        // splashColor: Colors.transparent,

                        title: Text('Add new product'),
                        trailing: Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
              ),
            ), */
            Expanded(
              child: FutureBuilder(
                  future: val.getAllProduts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.isNotEmpty
                          ? isMobile
                              ? ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    var currentData = snapshot.data![index];
                                    return SizedBox(
                                      height: isMobile ? 80 : 100,
                                      child: Card(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Confirm Updation'),
                                                  content: const Text(
                                                      'Do you want to update this product ?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('No'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            context: context,
                                                            builder: (context) =>
                                                                ShowCustomeDialogue(
                                                                    data:
                                                                        currentData,
                                                                    isUpdate:
                                                                        true,
                                                                    isMobile:
                                                                        isMobile,
                                                                    val: val));
                                                      },
                                                      child: const Text('Yes'),
                                                    )
                                                  ],
                                                );
                                              },
                                            );

                                            //id:val.products[index]['id'],
                                          },
                                          child: Center(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              leading: CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey.shade300,
                                                child: const Icon(
                                                  Icons.shopping_bag_rounded,
                                                  color: Colors.black38,
                                                ),
                                              ),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    Provider.of<ShopController>(
                                                            context,
                                                            listen: false)
                                                        .model!
                                                        .curencyName,
                                                    style: poppinsStyleH2,
                                                  ),
                                                  Text(
                                                    currentData.rate.toString(),
                                                    style: poppinsStyleH2,
                                                  ),
                                                ],
                                              ),
                                              title: Text(
                                                currentData.itemName
                                                    .toString()
                                                    .toUpperCase(),
                                                style: poppinsStyleH2,
                                              ),
                                              subtitle: Text(
                                                currentData.category.toString(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              : GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  padding: const EdgeInsets.all(8),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: isTab ? 4 : 7,
                                    childAspectRatio: 1,
                                    mainAxisExtent: isTab
                                        ? MediaQuery.of(context).size.height *
                                            .20
                                        : MediaQuery.of(context).size.height *
                                            .25,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    var currentData = snapshot.data![index];
                                    return Card(
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Confirm Updation'),
                                                content: const Text(
                                                    'Do you want to update this product ?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('No'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          context: context,
                                                          builder: (context) =>
                                                              ShowCustomeDialogue(
                                                                  data:
                                                                      currentData,
                                                                  isUpdate:
                                                                      true,
                                                                  isMobile:
                                                                      isMobile,
                                                                  val: val));
                                                    },
                                                    child: const Text('Yes'),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/bag.svg',
                                              color: Colors.black38,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                            ),
                                            // divider,
                                            const Divider(
                                              color: Colors.transparent,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    currentData.itemName
                                                        .toUpperCase(),
                                                    style: poppinsStyleH2,
                                                  ),
                                                  /*   Text(
                                                currentData.rate,
                                                style: poppinsStyleH2,
                                              ),*/
                                                ],
                                              ),
                                            ),
                                            divider,
                                            Center(
                                              child: Text(currentData.category
                                                  .toUpperCase()),
                                            ),
                                            Text(
                                              Provider.of<ShopController>(
                                                      context,
                                                      listen: false)
                                                  .model!
                                                  .curencyName,
                                              style: const TextStyle(
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Center(
                                              child: Text(
                                                "${currentData.rate}.00",
                                                style: poppinsStyleH2,
                                              ),
                                            ),
                                            /*   Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                              
                                                
                                              ],
                                            ), */
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                          : Center(
                              child: LottieBuilder.asset(
                                  'assets/lottie/noresult.json'),
                            );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return isMobile
                          ? ListView.builder(
                              itemCount: 15,
                              itemBuilder: (context, index) =>
                                  Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: const Card(
                                  child: ListTile(
                                    title: Text('data'),
                                    subtitle: Text('data'),
                                  ),
                                ),
                              ),
                            )
                          : GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 8,
                              padding: const EdgeInsets.all(8),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1,
                                mainAxisExtent:
                                    MediaQuery.of(context).size.height * .20,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                              ),
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: const Card(
                                    child: ListTile(
                                      title: Text('data'),
                                      subtitle: Text('data'),
                                    ),
                                  ),
                                );
                              });
                    } else if (snapshot.hasError) {
                      return Center(
                        child:
                            LottieBuilder.asset('assets/lottie/noresult.json'),
                      );
                    } else {
                      return const Center(
                        child: Text('unkown error'),
                      );
                    }
                  }),
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
                      return ShowCustomeDialogue(isMobile: isMobile, val: val);
                    },
                  );
                },
                title: const Center(
                  child: Text('Add Product'),
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
    });
  }
}

class ShowCustomeDialogue extends StatelessWidget {
  ShowCustomeDialogue({
    super.key,
    required this.isMobile,
    required this.val,
    this.isUpdate = false,
    this.data,
  });

  final bool isMobile;
  final ProductController val;
  bool isUpdate;
  ProductModel? data;
  // final _formKey = GlobalKey<FormState>();
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
                  isUpdate ? 'Update product' : 'Add new products',
                  style: whiteText,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormFieldWidget(
                    validator: (p0) {
                      if (p0!.isEmpty || p0 == '') {
                        return "name required";
                      }
                      return null;
                    },
                    labelText: "product name",
                    initialvalue: isUpdate ? data!.itemName : null,
                    onChanged: (v) {
                      val.setProduct(v);
                    },
                    hintText: 'Product Name',
                  ),
                  space(context),
                  TextFormFieldWidget(
                    initialvalue: isUpdate ? data!.category : null,
                    onChanged: (v) {
                      val.setCategory(v);
                    },
                    hintText: 'Product Category',
                  ),
                  space(context),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormFieldWidget(
                          validator: (p0) {
                            if (p0!.isEmpty || p0 == '') {
                              return "rate required";
                            }
                            return null;
                          },
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
                          initialvalue: isUpdate ? data!.tax : "0.00",
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
                  space(context),
                  ElevatedButton(
                    onPressed: () async {
                      isUpdate
                          ? await val
                              .updateProduct(context,
                                  newProductName:
                                      val.productName ?? data!.itemName,
                                  newCategory: val.category ?? data!.category,
                                  newRate: val.rate ?? data!.rate,
                                  newType: val.type ?? data!.type,
                                  newTax: val.tax ?? data!.tax,
                                  newDetails: val.details ?? data!.details,
                                  itemId: data!.itemId.toString())
                              .then((value) => val.clearDatas())
                              .then(
                                (value) => Navigator.pop(context),
                              )
                          : await val
                              .addNewProduct(context)
                              .then((value) => val.clearDatas())
                              .then(
                                (value) => Navigator.pop(context),
                              );
                    },
                    child: Text(isUpdate ? 'Update Product' : 'Add Product'),
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
