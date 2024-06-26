import 'package:flutter/material.dart';

PreferredSizeWidget myTabs() {
  return TabBar(
    labelColor: Colors.white,
    labelStyle: TextStyle(
      fontSize: 10,
      color: Colors.white,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 10,
      color: Colors.white,
    ),
    indicatorColor: Colors.white,
    dividerColor: Colors.transparent,
    padding: EdgeInsets.only(right: 10,),
    tabs: [
      Tab(
        text: "⏰  Today",
      ),
      Tab(
        text: "📆  17-Days",
      ),
    ],
  );
}
