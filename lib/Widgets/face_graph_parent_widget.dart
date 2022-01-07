import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FaceGraphParentWidget extends StatelessWidget {
  final String appbarTitle;
  final Widget bodyWidget;

  const FaceGraphParentWidget({
    @required this.bodyWidget,
    Key key,
    this.appbarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
      
            navigationBar: appbarTitle != null
                ? CupertinoNavigationBar(
              trailing: Icon(icon),
                    previousPageTitle: appbarTitle,
                  )
                : null,
            child: bodyWidget,
          
    )
        : Scaffold(
            appBar: appbarTitle != null
                ? AppBar(
                    title: Text(appbarTitle),
                  )
                : null,
            body: bodyWidget,
          );
  }
}
