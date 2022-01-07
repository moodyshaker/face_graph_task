import 'package:flutter/material.dart';

class NoteModel {
  int id;
  String title;
  String picture;
  DateTime date;
  String description;
  int status;

  NoteModel({
    this.id,
    @required this.title,
    @required this.picture,
    @required this.date,
    @required this.description,
    @required this.status,
  });

  NoteModel.withId({
    @required this.id,
    @required this.title,
    @required this.picture,
    @required this.date,
    @required this.description,
    @required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      'title': title,
      'picture': picture,
      'date': date.toIso8601String(),
      'description': description,
      'status': status,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel.withId(
      id: map['_id'],
      title: map['title'],
      picture: map['picture'],
      date: DateTime.parse(map['date']),
      description: map['description'],
      status: map['status'],
    );
  }
}
