import 'dart:io';

import 'package:face_graph_task/Dilaogs/action_dialog.dart';
import 'package:face_graph_task/Dilaogs/cupertino_action_dialog.dart';
import 'package:face_graph_task/Dilaogs/image_picker_dialog.dart';
import 'package:face_graph_task/Dilaogs/loading.dart';
import 'package:face_graph_task/Provider/main_provider.dart';
import 'package:face_graph_task/Utilits/const.dart';
import 'package:face_graph_task/Widgets/face_graph_cupertino_button.dart';
import 'package:face_graph_task/Widgets/face_graph_material_button.dart';
import 'package:face_graph_task/Widgets/face_graph_parent_widget.dart';
import 'package:face_graph_task/Widgets/face_graph_image_container.dart';
import 'package:face_graph_task/Widgets/face_graph_input_field.dart';
import 'package:face_graph_task/model/add_new_note_arg.dart';
import 'package:face_graph_task/model/note_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
    if (widget.arg.isUpdate) {
      _titleController.text = widget.arg.note.title;
      _descriptionController.text = widget.arg.note.description;
      _pictureUrl = widget.arg.note.picture;
    }
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
    final mainProvider = Provider.of<MainProvider>(context);
    return WillPopScope(
        onWillPop: () async {
          showDialog(
            barrierDismissible: false,
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
          onAddIconCallback: null,
          appbarTitle: widget.arg.isUpdate ? 'Edit Note' : 'Add New Note',
          bodyWidget: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formState,
              child: SingleChildScrollView(
                child: mq.orientation == Orientation.portrait && size.width < 400 ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FaceGraphImageContainer(
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
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (ctx) => const Loading());
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
                    FaceGraphInputField(
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
                    FaceGraphInputField(
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
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Platform.isIOS
                        ? FaceGraphCupertinoButton(
                            onPressCallback: () async {
                              if (_formState.currentState.validate()) {
                                _formState.currentState.save();
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (ctx) => const Loading());
                                if (widget.arg.isUpdate) {
                                  await mainProvider.updateNote(NoteModel(
                                      id: widget.arg.note.id,
                                      title: _title,
                                      picture: _pictureUrl,
                                      date: DateTime.now(),
                                      description: _description,
                                      status: Status.open));
                                  Fluttertoast.showToast(msg: 'Note Edited');
                                } else {
                                  await mainProvider.addNewNote(NoteModel(
                                      title: _title,
                                      picture: _pictureUrl,
                                      date: DateTime.now(),
                                      description: _description,
                                      status: Status.open));
                                  Fluttertoast.showToast(msg: 'Note Added');
                                }
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            },
                            color: Theme.of(context).primaryColor,
                            label: widget.arg.isUpdate ? 'Edit' : 'Save',
                          )
                        : FaceGraphMaterialButton(
                            onPressCallback: () async {
                              if (_formState.currentState.validate()) {
                                _formState.currentState.save();
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (ctx) => const Loading());
                                if (widget.arg.isUpdate) {
                                  await mainProvider.updateNote(NoteModel(
                                      id: widget.arg.note.id,
                                      title: _title,
                                      picture: _pictureUrl,
                                      date: DateTime.now(),
                                      description: _description,
                                      status: Status.open));
                                  Fluttertoast.showToast(msg: 'Note Edited');
                                } else {
                                  await mainProvider.addNewNote(NoteModel(
                                      title: _title,
                                      picture: _pictureUrl,
                                      date: DateTime.now(),
                                      description: _description,
                                      status: Status.open));
                                  Fluttertoast.showToast(msg: 'Note Added');
                                }
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            },
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            label: widget.arg.isUpdate ? 'Edit' : 'Save',
                          ),
                  ],
                ) : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FaceGraphImageContainer(
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
                                        Navigator.pop(context);
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (ctx) => const Loading());
                                        TaskSnapshot task = await uploadImage(
                                            uid: DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString(),
                                            path: imageFile.path);
                                        String imageUrl =
                                        await task.ref.getDownloadURL();
                                        setState(() => _pictureUrl = imageUrl);
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
                        ),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              FaceGraphInputField(
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
                              FaceGraphInputField(
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
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Platform.isIOS
                        ? FaceGraphCupertinoButton(
                      textColor: Colors.white,
                      onPressCallback: () async {
                        if (_formState.currentState.validate()) {
                          _formState.currentState.save();
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (ctx) => const Loading());
                          if (widget.arg.isUpdate) {
                            await mainProvider.updateNote(NoteModel(
                                id: widget.arg.note.id,
                                title: _title,
                                picture: _pictureUrl,
                                date: DateTime.now(),
                                description: _description,
                                status: Status.open));
                            Fluttertoast.showToast(msg: 'Note Edited');
                          } else {
                            await mainProvider.addNewNote(NoteModel(
                                title: _title,
                                picture: _pictureUrl,
                                date: DateTime.now(),
                                description: _description,
                                status: Status.open));
                            Fluttertoast.showToast(msg: 'Note Added');
                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      label: widget.arg.isUpdate ? 'Edit' : 'Save',
                    )
                        : FaceGraphMaterialButton(
                      onPressCallback: () async {
                        if (_formState.currentState.validate()) {
                          _formState.currentState.save();
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (ctx) => const Loading());
                          if (widget.arg.isUpdate) {
                            await mainProvider.updateNote(NoteModel(
                                id: widget.arg.note.id,
                                title: _title,
                                picture: _pictureUrl,
                                date: DateTime.now(),
                                description: _description,
                                status: Status.open));
                            Fluttertoast.showToast(msg: 'Note Edited');
                          } else {
                            await mainProvider.addNewNote(NoteModel(
                                title: _title,
                                picture: _pictureUrl,
                                date: DateTime.now(),
                                description: _description,
                                status: Status.open));
                            Fluttertoast.showToast(msg: 'Note Added');
                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      label: widget.arg.isUpdate ? 'Edit' : 'Save',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
