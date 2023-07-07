import 'package:chat_app/utils/custome_loader.dart';
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

  void checkOtp(BuildContext context) async {
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
      showProgressbarDialog(context);
      final otpCheck = PhoneAuthProvider.credential(
          verificationId: phoneNo[1], smsCode: code);
      try {
        await FirebaseAuth.instance.signInWithCredential(otpCheck);
        hideProgressDialog();
        Get.toNamed(RoutesClass.getUserCreate(), arguments: [phoneNo[0]]);
      } catch (e) {
        Get.snackbar('Error', e.toString());
        hideProgressDialog();
      }
    }
    update();
  }

  // resendOtp() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: countryCode + phoneNo[0],
  //     verificationCompleted: (phoneAuthCredential) {},
  //     verificationFailed: (error) {
  //       Get.snackbar('Error', error.message.toString());
  //     },
  //     codeSent: (String? verificationId, int? token) {
  //       verificationId = phoneNo[1];
  //       var id = verificationId.toString();
  //       print('id123:$verificationId');
  //       // Get.toNamed(RoutesClass.getOtpScreen(), arguments: [userPhoneNumber,id]);
  //     },
  //     codeAutoRetrievalTimeout: (e) {
  //       Get.snackbar('TimeOut', e.toString());
  //     },
  //   );
  //   update();
  // }
}
