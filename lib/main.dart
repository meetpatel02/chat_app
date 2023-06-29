// ignore_for_file: prefer_const_constructors

import 'package:chat_app/route/routes.dart';
import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      themeMode: ThemeMode.system,
      initialRoute: RoutesClass.splash,
      getPages: RoutesClass.routes,
      // home: NavigationBr(),
    );
  }
}
