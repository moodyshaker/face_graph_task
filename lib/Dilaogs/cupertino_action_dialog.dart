import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CupertinoActionDialog extends StatelessWidget {
  final String title;
  final String content;
  final String approveAction;
  final String cancelAction;
  final Function onApproveClick;
  final Function onCancelClick;

  CupertinoActionDialog({
    this.title,
    this.content,
    this.approveAction,
    this.cancelAction,
    this.onApproveClick,
    this.onCancelClick,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mq = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: CupertinoAlertDialog(
        title: title != null
            ? Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
              )
            : Container(),
        actions: [
          onApproveClick != null || approveAction != null
              ? ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor)),
                  onPressed: onApproveClick,
                  child: Text(
                    approveAction ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    ),
                  ),
                )
              : Container(),
          onCancelClick != null || cancelAction != null
              ? ElevatedButton(
                  onPressed: onCancelClick,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor)),
                  child: Text(
                    cancelAction ?? '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0),
                  ),
                )
              : Container()
        ],
        content: content != null
            ? Text(
                content,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              )
            : Container(),
      ),
    );
  }
}
