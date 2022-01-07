import 'package:face_graph_task/Widgets/face_graph_parent_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const String id = 'Home_Screen';

  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FaceGraphParentWidget(
      appbarTitle: 'Home',
      bodyWidget: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (BuildContext ctx, int i) => Text('hi $i')),
    );
  }
}
