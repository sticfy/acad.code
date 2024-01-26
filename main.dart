import 'package:flutter/material.dart';
import 'widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFormWidget(),
    );
  }
}
