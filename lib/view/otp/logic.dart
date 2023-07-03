import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route/routes.dart';
import 'state.dart';

class OtpLogic extends GetxController {
  final OtpState state = OtpState();
  final otpController = TextEditingController();
  var phoneNo = Get.arguments;

  String code = "";

  void checkOtp(){
    if (code.isEmpty) {
      Get.snackbar(
        'Error',
        'Enter Otp',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
    } else if (code.length < 6) {
      Get.snackbar(
        'Error',
        'Enter Valid Otp',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
    }else{
      Get.toNamed(RoutesClass.getUserCreate(),arguments: [phoneNo]);
    }
    update();
  }
}
