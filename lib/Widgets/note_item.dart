import 'package:face_graph_task/model/note_model.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: FancyShimmerImage(
          imageUrl: note.picture,
          height:
              mq.orientation.index == 0 ? size.width * 0.2 : size.height * 0.2,
          width:
              mq.orientation.index == 0 ? size.width * 0.2 : size.height * 0.2,
          boxFit: BoxFit.cover,
        ),
      ),
      title: Text(
        note.title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),
      ),
      subtitle: Text(
        note.description,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 13.0,
        ),
      ),
    );
  }
}
