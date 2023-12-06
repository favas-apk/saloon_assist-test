import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future abc() async {
  // Sample data
  String companyName = 'Your Company Name';
  String register = 'IDCOM';
  String mobile = '+96648375387';
  String address = 'PErinmthalmanna';
  double billAmount = 100.0;
  double cashAmount = 50.0;
  double cardAmount = 50.0;
  double taxAmount = 10.0;
  String staffId = "152";
  String customer = "";
  double grandTotal = billAmount + taxAmount;
  DateTime dateTimeNow = DateTime.now();
  String dateTime = DateFormat('MMM d yyyy').format(DateTime.now());
  String time = DateFormat.jm().format(dateTimeNow);

  // Load company logo image
  // final ByteData data =
  //     await rootBundle.load('assets/logo.png'); // Replace with your image path
  // final List<int> bytes = data.buffer.asUint8List();
  // final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;

  // Create PDF document
  final pdf = pw.Document();

  // Add content to PDF
  pdf.addPage(
    pw.Page(
      pageFormat:
          PdfPageFormat.roll80.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(companyName,
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 2),
            pw.Text(address),
            pw.SizedBox(height: 2),
            pw.Text("Reg No : $register"),
            pw.SizedBox(height: 2),
            pw.Text("Phone : $mobile"),
            pw.Divider(color: PdfColor.fromHex('#808080')),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Row(
                    children: [
                      pw.Text('Date : $dateTime'),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Row(
                    children: [
                      pw.Text('Time : $time '),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Row(
                    children: [
                      pw.Text('Staff ID : $staffId'),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Row(
                    children: [
                      pw.Text('Customer : $customer'),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 8),

            /* pw.Row(
              children: [
            
                pw.Flexible(
                  child: pw.Center(
                    child: pw.Text(
                        ".........................................................",
                        maxLines: 1,
                        overflow: pw.TextOverflow.clip),
                  ),
                ),
                pw.Text("  $time"),
              ],
            ),
            pw.SizedBox(height: 2), */
            pw.Row(
              children: [
                pw.Text('Bill Amount  '),
                pw.Flexible(
                  child: pw.Center(
                    child: pw.Text(
                        ".........................................................",
                        style: pw.TextStyle(
                          color: PdfColor.fromHex("#E7E0C3"),
                        ),
                        maxLines: 1,
                        overflow: pw.TextOverflow.clip),
                  ),
                ),
                pw.Text("  ${billAmount.toStringAsFixed(2)}"),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              children: [
                pw.Text('Cash  '),
                pw.Flexible(
                  child: pw.Center(
                    child: pw.Text(
                        ".........................................................",
                        style: pw.TextStyle(
                          color: PdfColor.fromHex("#E7E0C3"),
                        ),
                        maxLines: 1,
                        overflow: pw.TextOverflow.clip),
                  ),
                ),
                pw.Text("  ${cashAmount.toStringAsFixed(2)}"),
              ],
            ),
            pw.SizedBox(height: 2),
            pw.Row(
              children: [
                pw.Text('Card  '),
                pw.Flexible(
                  child: pw.Center(
                    child: pw.Text(
                        ".........................................................",
                        style: pw.TextStyle(
                          color: PdfColor.fromHex("#E7E0C3"),
                        ),
                        maxLines: 1,
                        overflow: pw.TextOverflow.clip),
                  ),
                ),
                pw.Text("  ${cardAmount.toStringAsFixed(2)}"),
              ],
            ),
            pw.SizedBox(height: 2),
            pw.Row(
              children: [
                pw.Text('Tax  '),
                pw.Flexible(
                  child: pw.Center(
                    child: pw.Text(
                        ".........................................................",
                        style: pw.TextStyle(
                          color: PdfColor.fromHex("#E7E0C3"),
                        ),
                        maxLines: 1,
                        overflow: pw.TextOverflow.clip),
                  ),
                ),
                pw.Text("  ${taxAmount.toStringAsFixed(2)}"),
              ],
            ),
            pw.Divider(
              color: PdfColor.fromHex('#808080'),
            ),
            pw.Row(children: [
              pw.Text('Grand Total'),
              pw.Expanded(
                child: pw.SizedBox(),
              ),
              pw.Text(grandTotal.toStringAsFixed(2),
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold))
            ]),
          ],
        );
      },
    ),
  );
  final output = await getExternalStorageDirectory();
  final pdfFile = File('${output!.path}/abcd$dateTime.pdf');
  await pdfFile.writeAsBytes(await pdf.save());
  return pdfFile.path;
  // Save PDF to a file
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var path = await abc();
            OpenFile.open(path);
          },
          child: const Text("PDF"),
        ),
      ),
    );
  }
}

class Test2 extends StatefulWidget {
  const Test2({super.key});

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  final text1 = TextEditingController();
  final text2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: text1,
            onChanged: (value) {
              text2.text = (int.parse(value) * int.parse(value)).toString();
            },
          ),
          TextField(
            controller: text2,
          ),
        ],
      ),
    );
  }
}
