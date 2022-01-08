import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FaceGraphParentWidget extends StatelessWidget {
  final String appbarTitle;
  final Widget bodyWidget;
  final Function onAddIconCallback;

  const FaceGraphParentWidget({
    @required this.bodyWidget,
    this.onAddIconCallback,
    Key key,
    this.appbarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appbarTitle != null
                ? CupertinoNavigationBar(
                    leading: null,
                    trailing: GestureDetector(
                      onTap:
                          onAddIconCallback,
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
                ? onAddIconCallback != null
                    ? FloatingActionButton(
                        child: const Icon(
                          Icons.add,
                        ),
                        onPressed: onAddIconCallback,
                      )
                    : null
                : null,
            appBar: appbarTitle != null
                ? AppBar(
                    leading: null,
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
