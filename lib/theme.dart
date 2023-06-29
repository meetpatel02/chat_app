// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.cyan,

        ///background Color
        canvasColor: Colors.white,
        hintColor: Colors.black,
        backgroundColor: Colors.white,

        ///Container Background Color
        cardColor: Colors.grey[200],
        hoverColor: Color(0xFF024DFC),
        indicatorColor: Colors.black26,

        /// chatContainerColor
        dividerColor: Color(0xFFA6D0DD),
        focusColor: Color(0xFFB2A4FF),

        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
        ),

        ///profile Image Shadow
        shadowColor: Colors.black26,
        badgeTheme: BadgeThemeData(backgroundColor: Colors.red),
        useMaterial3: true,
        tabBarTheme: TabBarTheme(indicatorColor: Colors.transparent),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
        canvasColor: Colors.black,
        hintColor: Colors.white,
        backgroundColor: Colors.black,

        /// chatContainerColor
        dividerColor: Color(0xFFA6D0DD),
        focusColor: Color(0xFFB2A4FF),

        ///
        cardColor: Color(0xFF282A3A),
        hoverColor: Color(0xFFA5C9CA),
        indicatorColor: Colors.white60,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
            color: Colors.black,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.white)),

        ///profile Image Shadow
        shadowColor: Colors.white24,
        badgeTheme: BadgeThemeData(backgroundColor: Colors.red),
      );
}
