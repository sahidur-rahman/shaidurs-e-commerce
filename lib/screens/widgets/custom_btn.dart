// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool isOutlined;

  CustomBtn(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.isOutlined})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        // ignore: prefer_const_constructors
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(12.0),
          color: isOutlined ? Colors.transparent : Colors.black,
        ),
        // ignore: prefer_const_constructors
        child: Text(text,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: isOutlined ? Colors.black : Colors.white,
            )),
      ),
    );
  }
}
