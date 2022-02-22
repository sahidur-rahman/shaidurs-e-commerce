// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.hintText,
    required this.isSecured,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
  }) : super(key: key);

  final String hintText;
  final bool isSecured;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        obscureText: isSecured,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 18.0,
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
