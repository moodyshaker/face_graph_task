import 'dart:io';
import 'package:face_graph_task/Provider/main_provider.dart';
import 'package:face_graph_task/Screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/home.dart';
import 'Utilits/const.dart';

void main() =>
  runApp(const MyApp());




class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainProvider(),
      child: Platform.isIOS
          ? CupertinoApp(
              debugShowCheckedModeBanner: false,
              initialRoute: Home.id,
              title: 'FaceGraphTask',
              routes: routes,
            )
          : MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: SplashScreen.id,
              title: 'FaceGraphTask',
              routes: routes,
              onGenerateRoute: getOnGenerateRoute,
            ),
    );
  }
}
