import 'package:face_graph_task/Screens/add_new_note.dart';
import 'package:face_graph_task/Widgets/face_graph_parent_widget.dart';
import 'package:face_graph_task/Widgets/note_item.dart';
import 'package:face_graph_task/model/add_new_note_arg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatelessWidget {
  static const String id = 'Home_Screen';

  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FaceGraphParentWidget(
      onAddIconCallback: () {
        Navigator.pushNamed(context, AddNewNote.id,
            arguments: AddNewNoteArg(isUpdate: false, note: null));
      },
      appbarTitle: 'Home',
      bodyWidget: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (BuildContext ctx, int i) => const NoteItem()),
    );
  }
}
