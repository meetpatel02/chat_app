
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class CallScreenLogic extends GetxController {
  final CallScreenState state = CallScreenState();
  List callUserList = ['Meet', 'Kush', 'Jimil', 'Prince'];
  List<Color> callUserColor = [
    Color(0xFF808080),
    Color(0xFFFF0000),
    Color(0xFF808080),
    Color(0xFFFF0000),
  ];
  List<Icon> callIcon = [
    Icon(Icons.videocam),
    Icon(Icons.call),
    Icon(Icons.videocam),
    Icon(Icons.call)
  ];
}
