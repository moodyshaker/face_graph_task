import 'package:face_graph_task/model/note_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewNoteArg{
  final bool isUpdate;
  final NoteModel note;

  AddNewNoteArg({@required this.isUpdate,@required this.note});
}