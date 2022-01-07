import 'package:flutter/material.dart';

import 'Screens/home.dart';
import 'Utilits/const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Home.id,
      title: 'FaceGraphTask',
      routes: routes,
    );
  }
}
