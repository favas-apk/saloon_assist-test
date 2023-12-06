// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

class TakeCustomerDetails extends StatelessWidget {
  TakeCustomerDetails(
      {super.key, required this.staffId, required this.chairId});
  String chairId;
  String staffId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            // divider,
          ],
        ),
      ),
    );
  }
}
