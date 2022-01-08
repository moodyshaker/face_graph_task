import 'dart:io';

import 'package:face_graph_task/Screens/add_new_note.dart';
import 'package:face_graph_task/Screens/home.dart';
import 'package:face_graph_task/Screens/splash.dart';
import 'package:face_graph_task/model/add_new_note_arg.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Map<String, WidgetBuilder> routes = {
  Home.id: (_) => const Home(),
  SplashScreen.id: (_) => const SplashScreen(),
};

Route<dynamic> getOnGenerateRoute(RouteSettings settings) {
  if (settings.name == AddNewNote.id) {
    final AddNewNoteArg v = settings.arguments;
    return MaterialPageRoute(
      builder: (_) => AddNewNote(
        arg: v,
      ),
    );
  } else {
    return null;
  }
}

Future<TaskSnapshot> uploadImage(
    {@required String path, @required String uid}) async {
  String fileName = uid;
  File image = File(path);
  Reference reference = FirebaseStorage.instance.ref().child(fileName);
  UploadTask uploadTask = reference.putFile(image);
  return uploadTask;
}
