import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../route/routes.dart';
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

  void checkPhoneNo()async {
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
      // hideProgressDialog();
      // print(phoneController.text);
      keyBoardShow = false;
      // phoneController.clear();
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCode + phoneController.text,
        verificationCompleted: (phoneAuthCredential) {

      }, verificationFailed: (error) {
        Get.snackbar('Error', error.message.toString());
      }, codeSent: (String? verificationId,int? token) {
          var id = verificationId.toString();
          print('id123:$verificationId');
        Get.toNamed(RoutesClass.getOtpScreen(), arguments: [userPhoneNumber,id]);
      }, codeAutoRetrievalTimeout: (e) {
        Get.snackbar('TimeOut', e.toString());
      },);
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
