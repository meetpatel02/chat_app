import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SplashPage extends StatelessWidget  {
  SplashPage({Key? key}) : super(key: key);

  final logic = Get.find<SplashLogic>();
  final state = Get.find<SplashLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.canvasColor,
      body: Center(
        child: ScaleTransition(
            scale: logic.animation!,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 180,
                  ),
                ),
                Text('Chat App',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
              ],
            )),
      ),
    );
  }
}
