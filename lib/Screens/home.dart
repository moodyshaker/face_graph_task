import 'dart:io';

import 'package:face_graph_task/Dilaogs/action_dialog.dart';
import 'package:face_graph_task/Dilaogs/cupertino_action_dialog.dart';
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
    final mq = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => Platform.isIOS
              ? CupertinoActionDialog(
                  title: 'Exit',
                  content: 'Do you want to Exit ?',
                  onApproveClick: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  onCancelClick: () {
                    Navigator.pop(context);
                  },
                  approveAction: 'Yes',
                  cancelAction: 'No',
                )
              : ActionDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  title: 'Exit',
                  content: 'Do you want to Exit',
                  onApproveClick: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  onCancelClick: () {
                    Navigator.pop(context);
                  },
                  approveAction: 'Yes',
                  cancelAction: 'No',
                ),
        );
        return false;
      },
      child: FaceGraphParentWidget(
        onAddIconCallback: () {
          Navigator.pushNamed(context, AddNewNote.id,
              arguments: AddNewNoteArg(isUpdate: false, note: null));
        },
        appbarTitle: 'Home',
        bodyWidget: Consumer<MainProvider>(
          builder: (c, data, ch) => mq.orientation == Orientation.portrait && size.width < 400
              ? ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: data.notes.length,
                  itemBuilder: (BuildContext ctx, int i) =>
                      NoteItem(note: data.notes[i]))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.023,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  itemCount: data.notes.length,
                  itemBuilder: (BuildContext ctx, int i) =>
                      NoteItem(note: data.notes[i])),
        ),
      ),
    );
  }
}
