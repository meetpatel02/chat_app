// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../route/routes.dart';
import '../utils/custome_loader.dart';
import 'keyboard_custome.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  String phoneNumber = "";
  final phoneController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool keyBoardShow = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Login With Phone',
        ),
        backgroundColor: context.theme.canvasColor,
      ),
      backgroundColor: context.theme.canvasColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Center(
                  child: Image(
                    image: AssetImage('assets/images/holding-phone.png'),
                    height: 125,
                  ),
                ),
                const Text(
                  'You\'ll receive a 4 digit \n code to verify next.',
                  style: TextStyle(color: Colors.grey, fontSize: 23),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            padding: EdgeInsets.only(left: 10, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: context.theme.shadowColor,
                  blurRadius: 20.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75),
                ),
              ],
              color: context.theme.canvasColor,
            ),
            child: Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      _focusNode.requestFocus();
                      keyBoardShow = true;
                      // _openCustomKeyboard();
                      setState(() {});
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        focusNode: _focusNode,
                        showCursor: false,
                        readOnly: true,
                        controller: phoneController,
                        style: TextStyle(
                          // color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Your Number',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    var userPhoneNumber = phoneController.text;
                    print(phoneNumber);
                    if (phoneController.text.trim().isEmpty) {
                      Get.snackbar('Error', 'Please Enter your number',
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red);
                    } else if (phoneController.text.length < 10) {
                      Get.snackbar('Error', 'Please Check your number',
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red);
                    } else if (phoneController.text.length > 10) {
                      Get.snackbar('Error', 'Please Check your number',
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red);
                    } else {
                      hideProgressDialog();
                      print(phoneController.text);
                      keyBoardShow = false;
                      phoneController.clear();
                      Get.toNamed(RoutesClass.getOtpScreen(),
                          arguments: [userPhoneNumber]);

                    }
                  },
                  child:
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8863F9).withOpacity(0.90),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // keyBoardShow ? NumericPad(onNumberSelected: onKeyPress) : Container()
          Spacer(),
          AnimatedOpacity(
            opacity: keyBoardShow ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.bounceInOut,
            child: keyBoardShow
                ? NumericPad(onNumberSelected: onKeyPress)
                : Container(),
          ),
          // NumericPad(
          //   onNumberSelected: (key) {
          //     setState(() {
          //       final currentText = phoneController.text;
          //       if (key == -1) {
          //         if (currentText.isNotEmpty) {
          //           phoneController.text =
          //               currentText.substring(0, currentText.length - 1);
          //         }
          //       } else {
          //         phoneController.text = currentText + key.toString();
          //       }
          //     });
          //   },
          // ),
        ],
      ),
    );
  }

  void onKeyPress(var key) {
    setState(() {
      final currentText = phoneController.text;
      if (key == -1) {
        if (currentText.isNotEmpty) {
          phoneController.text =
              currentText.substring(0, currentText.length - 1);
        }
      } else {
        phoneController.text = currentText + key.toString();
      }
    });
  }

  void _openCustomKeyboard() {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _, curve: Curves.easeInOut),
          ),
          child: NumericPad(onNumberSelected: onKeyPress),
        );
      },
    ));
  }
}
