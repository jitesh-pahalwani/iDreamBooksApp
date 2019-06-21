import 'package:flutter/material.dart';

import './homeScreen/HomeScreen.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
