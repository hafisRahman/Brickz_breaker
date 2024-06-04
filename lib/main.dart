import 'package:brickz_breaker/Home_page.dart';
import 'package:brickz_breaker/testPage.dart/testfile2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // home: SlidingContainer(),
    );
  }
}
