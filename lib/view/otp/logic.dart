import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route/routes.dart';
import 'state.dart';

class OtpLogic extends GetxController {
  final OtpState state = OtpState();

  var phoneNo = Get.arguments;
  String code = "";
  String countryCode = '+91';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('vId:${phoneNo[1]}');
  }

  void checkOtp() async {
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
    } else {
      final otpCheck = PhoneAuthProvider.credential(
          verificationId: phoneNo[1], smsCode: code);
      try {
        await FirebaseAuth.instance.signInWithCredential(otpCheck);
        Get.toNamed(RoutesClass.getUserCreate(), arguments: [phoneNo[0]]);
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }
    update();
  }
}
