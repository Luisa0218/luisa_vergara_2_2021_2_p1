// @dart=2.9

import 'package:elephant_app/screens/elephants_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elephant App',
      home: ElephantsScreen(),
    );
  }
}
