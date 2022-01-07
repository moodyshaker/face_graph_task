import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class NoteItem extends StatelessWidget {
  const NoteItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image.network(
          'https://cdn.pixabay.com/photo/2016/11/19/15/50/chair-1840011_960_720.jpg',
          height: mq.orientation.index == 0 ? size.width * 0.2 : size.height * 0.2,
          width: mq.orientation.index == 0 ? size.width * 0.2 : size.height * 0.2,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        'Chair 1',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,

        ),
      ),
      subtitle: Text(
        'Chair black',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 13.0,
        ),
      ),
    );
  }
}
