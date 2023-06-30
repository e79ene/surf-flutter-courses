// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillAppBar extends AppBar {
  final int billNo;
  final DateTime dateTime;

  BillAppBar({
    super.key,
    required this.billNo,
    required this.dateTime,
  }) : super(
          leading: BackButton(),
          title: Column(
            children: [
              Text(
                "Чек № $billNo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                DateFormat('dd.MM.yy в hh:mm').format(dateTime),
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        );
}
