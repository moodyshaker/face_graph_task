import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FaceGraphParentWidget extends StatelessWidget {
  final String appbarTitle;
  final Widget bodyWidget;
  final Function onAddIconCallback;

  const FaceGraphParentWidget({
    @required this.bodyWidget,
    @required this.onAddIconCallback,
    Key key,
    this.appbarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appbarTitle != null
                ? CupertinoNavigationBar(
                    trailing: GestureDetector(
                      onTap: onAddIconCallback,
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
                    previousPageTitle: appbarTitle,
                  )
                : null,
            child: bodyWidget,
          )
        : Scaffold(
            floatingActionButton: Platform.isAndroid
                ? FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                    ),
                    onPressed: onAddIconCallback,
                  )
                : null,
            appBar: appbarTitle != null
                ? AppBar(
                    title: Text(
                      appbarTitle,
                    ),
                  )
                : null,
            body:
                appbarTitle == null ? SafeArea(child: bodyWidget) : bodyWidget,
          );
  }
}
