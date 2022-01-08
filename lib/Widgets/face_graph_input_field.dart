import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class FaceGraphInputField extends StatefulWidget {
  final Function onTap;
  final Function onChange;
  final TextEditingController controller;
  final Function validator;
  final Function onSaved;
  final String hintText;
  final String labelText;
  final bool readOnly;
  final FocusNode focusNode;
  final double radius;
  final TextInputType keyboardType;
  final bool isPassword;
  final Key key;
  final bool isRadiusBorder;

  FaceGraphInputField({
    this.onTap,
    this.onChange,
    this.validator,
    this.onSaved,
    this.keyboardType,
    this.radius,
    this.key,
    this.isPassword = false,
    this.controller,
    this.isRadiusBorder,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.readOnly,
  });

  @override
  State<FaceGraphInputField> createState() => _FaceGraphInputFieldState();
}

class _FaceGraphInputFieldState extends State<FaceGraphInputField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      readOnly: widget.readOnly ?? false,
      controller: widget.controller,
      onTap: widget.onTap,
      onSaved: widget.onSaved,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChange,
      validator: widget.validator,
      focusNode: widget.focusNode,
      obscureText: widget.isPassword ? isObscure : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        border: widget.isRadiusBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          icon: isObscure
              ? const Icon(
            Ionicons.ios_eye,
            color: Colors.grey,
          )
              : const Icon(Ionicons.ios_eye_off,
              color:Colors.grey),
        )
            : null,
      ),
    );
  }
}
