// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';

class CustomImageSwap extends StatefulWidget {
  CustomImageSwap({Key? key, required this.imagesLink}) : super(key: key);
  final List imagesLink;

  @override
  _CustomImageSwapState createState() => _CustomImageSwapState();
}

class _CustomImageSwapState extends State<CustomImageSwap> {
  int _imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (value) => setState(() {
              _imageIndex = value;
            }),
            children: [
              for (var imageLink in widget.imagesLink)
                Image.network(
                  imageLink,
                  fit: BoxFit.cover,
                ),
            ],
          ),
          Positioned(
            bottom: 8.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.imagesLink.length; i++)
                  AnimatedContainer(
                    duration: Duration(
                      milliseconds: 300,
                    ),
                    height: 10.0,
                    width: _imageIndex == i ? 32.0 : 10.0,
                    margin: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
