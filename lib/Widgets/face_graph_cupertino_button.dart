import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FaceGraphCupertinoButton extends StatelessWidget {
  final Function onPressCallback;
  final Color color;
  final String label;
  final Color textColor;

  const FaceGraphCupertinoButton(
      {@required this.onPressCallback,
      @required this.color,
      @required this.label,
      @required this.textColor,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressCallback,
      color: color,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}
