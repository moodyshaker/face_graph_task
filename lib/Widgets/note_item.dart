import 'dart:io';

import 'package:face_graph_task/Provider/main_provider.dart';
import 'package:face_graph_task/Screens/add_new_note.dart';
import 'package:face_graph_task/model/add_new_note_arg.dart';
import 'package:face_graph_task/model/note_model.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'face_graph_cupertino_button.dart';
import 'face_graph_material_button.dart';

class NoteItem extends StatelessWidget {
  final NoteModel note;

  const NoteItem({
    Key key,
    @required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0)),
                child: FancyShimmerImage(
                  imageUrl: note.picture,
                  height: mq.orientation == Orientation.portrait
                      ? size.height * 0.25
                      : size.width * 0.25,
                  width: mq.orientation == Orientation.portrait
                      ? size.width
                      : size.height,
                  boxFit: BoxFit.cover,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12.0),
                    ),
                    color: note.status == Status.open
                        ? Colors.green
                        : Colors.orange),
                child: Text(
                  note.status.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy').format(note.date),
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          DateFormat('hh:mm a').format(note.date),
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            note.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            note.description,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Platform.isIOS
                          ? FaceGraphCupertinoButton(
                              onPressCallback: () async {
                                await mainProvider.deleteNote(note);
                                Fluttertoast.showToast(msg: 'Note Deleted');
                              },
                              label: 'Delete',
                              color: Colors.red,
                              textColor: Colors.white,
                            )
                          : FaceGraphMaterialButton(
                              onPressCallback: () async {
                                await mainProvider.deleteNote(note);
                                Fluttertoast.showToast(msg: 'Note Deleted');
                              },
                              color: Colors.red,
                              textColor: Colors.white,
                              label: 'Delete',
                            ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Expanded(
                      child: Platform.isIOS
                          ? FaceGraphCupertinoButton(
                              onPressCallback: () async {
                                Navigator.pushNamed(context, AddNewNote.id,
                                    arguments: AddNewNoteArg(
                                        isUpdate: true, note: note));
                              },
                              color: Colors.grey,
                              textColor: Colors.white,
                              label: 'Edit',
                            )
                          : FaceGraphMaterialButton(
                              onPressCallback: () async {
                                Navigator.pushNamed(context, AddNewNote.id,
                                    arguments: AddNewNoteArg(
                                        isUpdate: true, note: note));
                              },
                              color: Colors.grey,
                              textColor: Colors.white,
                              label: 'Edit',
                            ),
                    )
                  ],
                ),
                SizedBox(
                  width: size.height * 0.02,
                ),
                Platform.isIOS
                    ? FaceGraphCupertinoButton(
                        onPressCallback: () async {
                          await mainProvider.updateStatus(
                              note.status == Status.open
                                  ? Status.close
                                  : Status.open,
                              note.id);
                          if (note.status == Status.open) {
                            Fluttertoast.showToast(msg: 'Note closed');
                          } else {
                            Fluttertoast.showToast(msg: 'Note opened');
                          }
                        },
                        label: note.status == Status.open
                            ? 'Close Note'
                            : 'Open Note',
                        color: note.status == Status.open
                            ? Colors.orange
                            : Colors.green,
                        textColor: Colors.white,
                      )
                    : FaceGraphMaterialButton(
                        onPressCallback: () async {
                          await mainProvider.updateStatus(
                              note.status == Status.open
                                  ? Status.close
                                  : Status.open,
                              note.id);
                          if (note.status == Status.open) {
                            Fluttertoast.showToast(msg: 'Note closed');
                          } else {
                            Fluttertoast.showToast(msg: 'Note opened');
                          }
                        },
                        color: note.status == Status.open
                            ? Colors.orange
                            : Colors.green,
                        textColor: Colors.white,
                        label: note.status == Status.open
                            ? 'Close Note'
                            : 'Open Note',
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
