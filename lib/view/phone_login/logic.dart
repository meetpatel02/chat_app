import 'dart:convert';

import 'package:chat_app/utils/custome_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../route/routes.dart';
import '../../service/firebase.dart';
import 'state.dart';

class PhoneLoginLogic extends GetxController {
  final PhoneLoginState state = PhoneLoginState();
  String phoneNumber = "";
  final phoneController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool keyBoardShow = false;
  var countryCode = "+91";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // phoneController.text = "+91";
  }

  void checkPhoneNo(context) async {
    var userPhoneNumber = phoneController.text;
    if (phoneController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please Enter your number',
          duration: Duration(seconds: 2), backgroundColor: Colors.red);
    } else if (phoneController.text.length < 10) {
      Get.snackbar('Error', 'Please Check your number',
          duration: Duration(seconds: 2), backgroundColor: Colors.red);
    } else if (phoneController.text.length > 10) {
      Get.snackbar('Error', 'Please Check your number',
          duration: Duration(seconds: 2), backgroundColor: Colors.red);
    } else {
      keyBoardShow = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      showProgressbarDialog(context);
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCode + phoneController.text,
        verificationCompleted: (phoneAuthCredential) {
          hideProgressDialog();
        },
        verificationFailed: (error) {
          Get.snackbar('Error', error.message.toString());
          hideProgressDialog();
        },
        codeSent: (String? verificationId, int? token) {
          hideProgressDialog();
          var id = verificationId.toString();
          print('id123:$verificationId');
          prefs.setString('phone', phoneController.text);
          print(prefs.getString('phone'));
          Get.toNamed(RoutesClass.getOtpScreen(),
              arguments: [userPhoneNumber, id]);
        },
        codeAutoRetrievalTimeout: (e) {
          Get.snackbar('TimeOut', e.toString());
          hideProgressDialog();
        },
      );
      update();
    }
  }

  void onKeyPress(var key) {
    final currentText = phoneController.text;
    if (key == -1) {
      if (currentText.isNotEmpty) {
        phoneController.text = currentText.substring(0, currentText.length - 1);
      }
    } else {
      phoneController.text = currentText + key.toString();
    }
  }
}
