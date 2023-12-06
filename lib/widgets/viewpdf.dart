/* // ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:saloon_assist/constants/constants.dart';
import "package:saloon_assist/widgets/pdf.dart";

class ViewPdf extends StatefulWidget {
  ViewPdf(
      {super.key,
      required this.shopName,
      required this.staffId,
      required this.time,
      required this.date});
  String shopName;
  String staffId;
  String time;
  String date;
  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  late PDFViewController pdfViewController;
  Future<Uint8List?>? pdfData;

  @override
  void initState() {
    super.initState();
    pdfData = Pdf.generatePdf(
        shopName: widget.shopName,
        staffId: widget.staffId,
        time: widget.time,
        date: widget.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Work Details',
          style: whiteText,
        ),
      ),
      body: FutureBuilder(
        future: Future.value(pdfData),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return PDFView(
              pdfData: snapshot.data as Uint8List,
              /*   filePath:
                  null, // Provide the path to an existing PDF file or null */
              onViewCreated: (controller) {
                pdfViewController = controller;
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}



/* 
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:saloon_assist/widgets/pdf.dart';

class PdfViewerPage extends StatefulWidget {

   PdfViewerPage({super.key, required String shopName,
      required this.staffId,
      required this.time,
      required this.date});

   String shopName;
       String staffId;
       String time;
       String date;


  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late PDFViewController pdfViewController;
  Future<Uint8List?>? pdfData;

  @override
  void initState() {
    super.initState();
    pdfData = Pdf.generatePdf(shopName: widget.shopName, staffId:widget. staffId, time:widget. time, date:widget. date);
  }

  Widgetbuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer Example'),
      ),
      body: FutureBuilder<Uint8List?>(
        future: pdfData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return PDFView(
              filePath:
                  null, // Provide the path to an existing PDF file or null
              onControllerInitialized: (controller) {
                pdfViewController = controller;
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
} */ */