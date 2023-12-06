/* // ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/location_permission.dart';
import 'package:saloon_assist/widgets/reportItemWidget.dart';

class SearchBlutoothDevices extends StatefulWidget {
  // final List<Map<String, dynamic>> data;
  SearchBlutoothDevices({super.key, required this.id, required this.chairID});
  String id;
  String chairID;
  @override
  _SearchBlutoothDevicesState createState() => _SearchBlutoothDevicesState();
}

class _SearchBlutoothDevicesState extends State<SearchBlutoothDevices> {
/*   BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  final f = NumberFormat("\$###,###.00", "en_US"); */

/*   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPrinter());
  }
 */
  /*  Future<void> initPrinter() async {
    await bluetoothPrint.startScan(timeout: const Duration(seconds: 3));

    if (!mounted) return;
    bluetoothPrint.scanResults.listen(
      (val) {
        if (!mounted) return;
        setState(() => _devices = val);
        if (_devices.isEmpty) {
          setState(() {});
        }
      },
    );
  } */

  final doc = pw.Document();
  var time = DateFormat.jm().format(DateTime.now());
  var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Start Work',
            style: whiteText,
          ),
          backgroundColor: primaryColor,
        ),
        body: FutureBuilder(
          future: LocationPermissions.determinePosition(),
          builder: (context, snapshot) => Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          ReportItems(title: "Employee Id", value: widget.id),
                          space(context),
                          ReportItems(title: "Date", value: date),
                          space(context),
                          ReportItems(title: "Time", value: time),
                          space(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Choose Printer",
                  style: titleStyle,
                ),
              ),
              /*  Expanded(
                child: _devices.isEmpty
                    ? const Center(
                        child: Column(
                          children: [
                            Text("No Devices Available"),
                            Text("Make sure that your device location is On")
                          ],
                        ),
                      )
                    : Consumer<ShopController>(
                        builder: (context, datas, child) {
                        return ListView.builder(
                          itemCount: _devices.length,
                          itemBuilder: (c, i) {
                            return ListTile(
                              leading: const Icon(Icons.print),
                              title: Text(_devices[i].name.toString()),
                              trailing: _devices[i].connected == true
                                  ? const Icon(Icons.task)
                                  : const SizedBox(),
                              subtitle: Text(_devices[i].address.toString()),
                              onTap: () async {
                                await connectDevice(_devices[i]);
                              },
                            );
                          },
                        );
                      }),
              ), */
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    /* Visibility(
                      visible: _devices.isNotEmpty,
                      child: Expanded(
                        child: Consumer<ShopController>(
                            builder: (context, datas, child) {
                          return ElevatedButton(
                              onPressed: () async {
                                await _startPrint(
                                  empId: widget.id,
                                  shopName: datas.model!.shopName,
                                ).then(
                                  (value) => datas
                                      .changeChairStatus(
                                        staffId: widget.id,
                                        chairid: widget.chairID,
                                        status: 2,
                                        date: DateFormat('yyyy-MM-dd').format(
                                          DateTime.now(),
                                        ),
                                      )
                                      .then(
                                        (value) => Navigator.pop(context),
                                      ),
                                );
                              },
                              child: const Text("Print And Start"));
                        }),
                      ),
                    ), */
                    const VerticalDivider(
                      color: Colors.transparent,
                    ),
                    Expanded(
                      child: Consumer<ShopController>(
                          builder: (context, datas, child) {
                        return ElevatedButton(
                          onPressed: () async {
                            // print(path);
                            // print('PDF file saved to: ${pdfFile.path}');

                            /*  Future<void> generatePDF() async {
                              final pdf = pw.Document();

                              pdf.addPage(pw.Page(
                                build: (pw.Context context) {
                                  return pw.Center(
                                    child: pw.Text('Hello, World!',
                                        style:
                                            const pw.TextStyle(fontSize: 40.0)),
                                  );
                                },
                              ));

                              final output =
                                  await getExternalStorageDirectory();
                              final pdfFile =
                                  File('${output!.path}/example.pdf');
                              await pdfFile.writeAsBytes(await pdf.save());

                              print('PDF file saved to: ${pdfFile.path}');
                            } */

                            /*  await Pdf.generatePdfTest(
                                shopName: datas.model!.shopName,
                                staffId: widget.id,
                                time: time,
                                date: date); */

                            /*    final pdfData = await Pdf.generatePdf(
                                shopName: datas.model!.shopName,
                                staffId: widget.id,
                                time: time,
                                date: date);
                            await savePDFToDevice(pdfData).then(
                              (value) => datas
                                  .changeChairStatus(
                                    staffId: widget.id,
                                    chairid: widget.chairID,
                                    status: 2,
                                    date: DateFormat('yyyy-MM-dd').format(
                                      DateTime.now(),
                                    ),
                                  )
                                  .then(
                                    (value) => Navigator.pop(context),
                                  ),
                            );  */
                          },
                          child: const Text("Save And Start"),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.transparent,
              )
            ],
          ),
        ));
  }

  Future<void> savePDFToDevice(Uint8List pdfData) async {
    final directory = await getDownloadsDirectory();
    final file = File('${directory!.path}/workstart$time.pdf');
    Fluttertoast.showToast(
        msg: "pdf saved in ${directory.path}/workstart$time.pdf");
    await file.writeAsBytes(pdfData);
  }

  bool connected = false;
  /*  Future connectDevice(BluetoothDevice device) async {
    await bluetoothPrint.connect(device);
    bluetoothPrint.state.listen((state) {
      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            connected = true;
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            connected = false;
          });
          break;
        default:
          break;
      }
    }); */
}

  /* Future<void> _startPrint({required empId, required shopName}) async {
    Map<String, dynamic> config = {};

    List<LineText> list = [];

    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: shopName,
        weight: 2,
        width: 2,
        height: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 0,
      ),
    );
    // list.add(LineText(linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '..............................................',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'EMPLOYEE ID',
        align: LineText.ALIGN_LEFT,
        x: 0,
        relativeX: 0,
        linefeed: 0));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '',
        align: LineText.ALIGN_LEFT,
        x: 350,
        relativeX: 0,
        linefeed: 0));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: empId,
        align: LineText.ALIGN_LEFT,
        x: 450,
        relativeX: 0,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Date',
        align: LineText.ALIGN_LEFT,
        x: 0,
        relativeX: 0,
        linefeed: 0));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "",
        align: LineText.ALIGN_LEFT,
        x: 350,
        relativeX: 0,
        linefeed: 0));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: date,
        align: LineText.ALIGN_LEFT,
        x: 450,
        relativeX: 0,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Time',
        align: LineText.ALIGN_LEFT,
        x: 0,
        relativeX: 0,
        linefeed: 0));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "",
        align: LineText.ALIGN_LEFT,
        x: 350,
        relativeX: 0,
        linefeed: 0));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: time,
        align: LineText.ALIGN_LEFT,
        x: 450,
        relativeX: 0,
        linefeed: 0));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '..............................................',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    await bluetoothPrint.printReceipt(config, list);
  } */

  /* Future<void> generateAndSavePDF() async {
    // Create a new PDF document
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
            child: pw.Text('Hello, PDF!'),
          );
        },
      ),
    );

    // Get the document directory
    final directory = await getApplicationDocumentsDirectory();

    // Create a file path for the PDF
    final filePath = '${directory.path}/example.pdf';

    // Save the PDF to the document directory
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Open the saved PDF
    OpenFile.open(file.path);
  } 
}*/
 */