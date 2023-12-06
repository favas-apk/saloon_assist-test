import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Pdf {
  static Future getPdf(
      {required String starttime,
      required String staffId,
      required String endTime,
      required String cashAmount,
      required String cardAmount,
      required String billAmount,
      required String customer,
      required String taxAmount,
      required String time,
      required String companyName,
      required String address,
      required String register,
      required String grandTotal,
      required String mobile,
      required String date}) async {
    DateTime dateTimeNow = DateTime.now();
    String dateTime = DateFormat('MMM d yyyy').format(DateTime.now());
    String time = DateFormat.jm().format(dateTimeNow);
    final pdf = pw.Document();
    // final font = await rootBundle.load("assets/fonts/open-sans.ttf");
    // final ttf = Font.ttf(font);

    String sanitizeFilename(String original) {
      return original.replaceAll(RegExp(r'[":]'), ''); // Remove double quotes and colons
    }


    pdf.addPage(
      pw.Page(
        pageFormat:
            PdfPageFormat.roll80.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(companyName,
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
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
              /*   pw.Row(
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
              pw.SizedBox(height: 5), */
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
                        pw.Text('Start Time : $starttime'),
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
                        pw.Text('End Time : $endTime'),
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
                  pw.Text("  $billAmount"),
                ],
              ),
              pw.SizedBox(height: 2),
              pw.Row(
                children: [
                  pw.Text('Tax Amount  '),
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
                  pw.Text("  $taxAmount"),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                children: [
                  pw.Text('Cash Amount  '),
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
                  pw.Text("  $cashAmount"),
                ],
              ),
              pw.SizedBox(height: 2),
              pw.Row(
                children: [
                  pw.Text('Card Amount  '),
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
                  pw.Text("  $cardAmount"),
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
                pw.Text(grandTotal,
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold))
              ]),
            ],
          );
        },
      ),
    );

    Directory? output;
    if (Platform.isAndroid) {
      output = await getExternalStorageDirectory();
    } else {
      output = await getApplicationCacheDirectory();
    }

    if (output == null) return null;

    final sanitizedDate = sanitizeFilename(date);
    final sanitizedTime = sanitizeFilename(time);
    final pdfFile = File('${output.path}/$staffId _$sanitizedDate _$sanitizedTime.pdf');
    await pdfFile.writeAsBytes(await pdf.save());
    return pdfFile.path;

    // final pdfFile = File('${output.path}/$staffId _$date _"$time.pdf');
    // await pdfFile.writeAsBytes(await pdf.save());
    // return pdfFile.path;
  }
}
