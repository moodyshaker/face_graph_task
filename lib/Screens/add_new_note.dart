import 'dart:io';

import 'package:face_graph_task/Dilaogs/action_dialog.dart';
import 'package:face_graph_task/Dilaogs/cupertino_action_dialog.dart';
import 'package:face_graph_task/Dilaogs/image_picker_dialog.dart';
import 'package:face_graph_task/Dilaogs/loading.dart';
import 'package:face_graph_task/Utilits/const.dart';
import 'package:face_graph_task/Widgets/face_graph_parent_widget.dart';
import 'package:face_graph_task/Widgets/image_container.dart';
import 'package:face_graph_task/Widgets/input_field.dart';
import 'package:face_graph_task/model/add_new_note_arg.dart';
import 'package:face_graph_task/model/note_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AddNewNote extends StatefulWidget {
  static const String id = 'Add_New_Note';
  final AddNewNoteArg arg;

  const AddNewNote({
    Key key,
    @required this.arg,
  }) : super(key: key);

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  String _title, _description, _pictureUrl;
  TextEditingController _titleController, _descriptionController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mq = MediaQuery.of(context);
    return WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (context) => Platform.isIOS
                ? CupertinoActionDialog(
                    title: 'Cancel',
                    content: 'Do you want to cancel',
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
                    title: 'Cancel',
                    content: 'Do you want to cancel',
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
          appbarTitle: widget.arg.isUpdate ? 'Add New Note' : 'Edit Note',
          bodyWidget: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formState,
              child: Column(
                children: [
                  ImageContainer(
                    onImagePressed: () {
                      _isLoading = true;
                      _isLoading
                          ? showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    20.0,
                                  ),
                                  topLeft: Radius.circular(
                                    20.0,
                                  ),
                                ),
                              ),
                              builder: (_) => ImagePickerDialog(
                                    onImageReceived: (XFile imageFile) async {
                                      if (imageFile != null) {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) => Loading());
                                        TaskSnapshot task = await uploadImage(
                                            uid: DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString(),
                                            path: imageFile.path);
                                        String imageUrl =
                                            await task.ref.getDownloadURL();
                                        setState(() => _pictureUrl = imageUrl);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        _isLoading = false;
                                      }
                                    },
                                  ))
                          : Container();
                    },
                    isLoading: _isLoading,
                    imagePath: _pictureUrl,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InputField(
                    readOnly: false,
                    isRadiusBorder: true,
                    controller: _titleController,
                    validator: (String output) {
                      if (output.length < 5) {
                        return 'please enter note title';
                      }
                    },
                    onSaved: (String value) {
                      _title = value;
                    },
                    labelText: 'title',
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InputField(
                    readOnly: false,
                    isRadiusBorder: true,
                    controller: _descriptionController,
                    validator: (String output) {
                      if (output.length < 5) {
                        return 'please enter note description';
                      }
                    },
                    onSaved: (String value) {
                      _description = value;
                    },
                    labelText: 'description',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
