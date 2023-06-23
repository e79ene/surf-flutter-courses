import 'package:flutter/material.dart';

import 'sortings.dart';
import 'bill_screen.dart';
import 'mock.dart';
import 'theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: BillScreen(
        billNo: billNo,
        dateTime: dateTime,
        products: dataForStudents,
        sortings: allSortings,
      ),
    );
  }
}
