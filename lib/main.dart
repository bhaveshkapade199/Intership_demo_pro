import 'package:flutter/material.dart';
import 'package:time_degnitor__project/login.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(body: Login()),
    );
  }
}
