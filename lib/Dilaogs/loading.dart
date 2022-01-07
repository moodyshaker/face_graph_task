import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        child: Container(
          height: 100.0,
          width: 100.0,
          padding: const EdgeInsets.all(20.0),
          child: const Center(
            child: CircularProgressIndicator(),
          )
        ),
      ),
    );
  }
}
