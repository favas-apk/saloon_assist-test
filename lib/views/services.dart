import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/servicesController.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/widgets/textFormFieldWidget.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Consumer<ServiceController>(builder: (context, val, child) {
      return Scaffold(
        floatingActionButton: Visibility(
          visible: val.services.isNotEmpty,
          child: FloatingActionButton(
            onPressed: () {
              showBottomSheet(
                context: context,
                builder: (context) {
                  return CustomAddService(isMobile: isMobile, val: val);
                },
              );
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
        /*   appBar: AppBar(
          title: Text(
            'Services',
            style: whiteText,
          ),
        ), */
        body: ListView.builder(
            itemCount: val.services.isNotEmpty ? val.services.length : 1,
            itemBuilder: (context, index) {
              return val.services.isEmpty
                  ? InkWell(
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          builder: (context) {
                            return CustomAddService(
                                isMobile: isMobile, val: val);
                          },
                        );
                      },
                      child: SizedBox(
                        height: isMobile ? 80 : 100,
                        child: const Card(
                          child: Center(
                            child: ListTile(
                              // splashColor: Colors.transparent,

                              title: Text('Add new service'),
                              trailing: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Confirm delete'),
                              content: const Text(
                                  'Do you want to delete this product ?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await val.deleteService(index: index).then(
                                          (value) => Navigator.pop(context),
                                        );
                                  },
                                  child: const Text('Yes'),
                                )
                              ],
                            );
                          },
                        );

                        //id:val.Services[index]['id'],
                      },
                      child: Card(
                        child: SizedBox(
                          height: isMobile ? 80 : 100,
                          child: Center(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                child: const FaIcon(
                                  FontAwesomeIcons.scissors,
                                  color: Colors.black38,
                                ),
                              ),
                              title: Text(
                                val.services[index]['service']
                                    .toString()
                                    .toUpperCase(),
                                style: poppinsStyleH2,
                              ),
                              subtitle: Text(
                                'Charge : ${val.services[index]['charge']}',
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
            }),
      );
    });
  }
}

class CustomAddService extends StatelessWidget {
  const CustomAddService({
    super.key,
    required this.isMobile,
    required this.val,
  });

  final bool isMobile;
  final ServiceController val;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: isMobile
          ? MediaQuery.of(context).size.height / 2.5
          : MediaQuery.of(context).size.height * .35,
      // color: Colors.red,
      child: Column(
        children: [
          SizedBox(
            // color: primaryColor,
            height: MediaQuery.of(context).size.height * 0.10,
            child: Center(
              child: Text(
                'Add new Services',
                style: poppinsStyleH2,
              ),
            ),
          ),
          divider,
          TextFormFieldWidget(
            onChanged: (v) {
              val.setService(v);
            },
            hintText: 'Service Name',
          ),
          space(context),
          TextFormFieldWidget(
            type: TextInputType.phone,
            onChanged: (v) {
              val.setRate(v);
            },
            hintText: 'Service Charge',
          ),
          space(context),
          ElevatedButton(
            onPressed: () async {
              await val.addService().then((value) => Navigator.pop(context));
            },
            child: const Text('Add Product'),
          ),
        ],
      ),
    );
  }
}
