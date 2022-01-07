import 'package:face_graph_task/Screens/add_new_note.dart';
import 'package:face_graph_task/Screens/home.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  Home.id: (_) => const Home(),
  AddNewNote.id: (_) => const AddNewNote(),
};
