// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/screens/tabs/home_tab.dart';
import 'package:flutter_training_ecommerce/screens/tabs/saved_tab.dart';
import 'package:flutter_training_ecommerce/screens/tabs/search_tab.dart';
import 'package:flutter_training_ecommerce/screens/widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _tabsPagecontroller = PageController();
  int _selectedTab = 0;

  @override
  void dispose() {
    _tabsPagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PageView(
                  controller: _tabsPagecontroller,
                  onPageChanged: (value) {
                    setState(() {
                      _selectedTab = value;
                    });
                  },
                  children: [
                    HomeTab(),
                    SearchTab(),
                    SavedTab(),
                  ],
                ),
              ),
              BottomTabs(
                selectedTab: _selectedTab,
                tabPressed: (value) {
                  _tabsPagecontroller.animateToPage(
                    value,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOutCubic,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
