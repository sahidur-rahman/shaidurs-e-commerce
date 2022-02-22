// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  const BottomTabs({
    Key? key,
    required this.selectedTab,
    required this.tabPressed,
  }) : super(key: key);

  final int selectedTab;
  final Function(int) tabPressed;

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 32.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
            imagePath: 'assets/images/home.png',
            isSelected: widget.selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottomTabBtn(
            imagePath: 'assets/images/search.png',
            isSelected: widget.selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottomTabBtn(
            imagePath: 'assets/images/save.png',
            isSelected: widget.selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
          BottomTabBtn(
            imagePath: 'assets/images/logout.png',
            isSelected: widget.selectedTab == 3 ? true : false,
            onPressed: () {
              FirebaseAuth.instance.signOut();
              // widget.tabPressed(0);
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  final Function() onPressed;

  const BottomTabBtn({
    Key? key,
    required this.imagePath,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Image(
          image: AssetImage(imagePath),
          color: isSelected
              ? Theme.of(context).colorScheme.secondary
              : Colors.black,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 12.0,
        ),
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isSelected
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
