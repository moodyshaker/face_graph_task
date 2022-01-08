import 'package:face_graph_task/Provider/main_provider.dart';
import 'package:face_graph_task/Screens/add_new_note.dart';
import 'package:face_graph_task/Widgets/face_graph_parent_widget.dart';
import 'package:face_graph_task/Widgets/note_item.dart';
import 'package:face_graph_task/model/add_new_note_arg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String id = 'Home_Screen';

  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MainProvider _mainProvider;

  @override
  void initState() {
    super.initState();
    _mainProvider = Provider.of<MainProvider>(context, listen: false);
    _mainProvider.getAllNotes();
  }



  @override
  Widget build(BuildContext context) {
    return FaceGraphParentWidget(
      onAddIconCallback: () {
        Navigator.pushNamed(context, AddNewNote.id,
            arguments: AddNewNoteArg(isUpdate: false, note: null));
      },
      appbarTitle: 'Home',
      bodyWidget: Consumer<MainProvider>(
        builder: (c, data, ch) => ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: data.notes.length,
            itemBuilder: (BuildContext ctx, int i) =>
                NoteItem(note: data.notes[i])),
      ),
    );
  }
}
