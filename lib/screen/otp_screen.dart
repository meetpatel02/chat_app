// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_app/utils/custome_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../route/routes.dart';
import 'keyboard_custome.dart';

class VerifyPhone extends StatefulWidget {
  String verificationId;
  VerifyPhone({
    Key? key,
    required this.verificationId
  }) : super(key: key);

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  String code = "";
  var phoneNo = Get.arguments;
  final otpController = TextEditingController();
  var id = Get.arguments;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: Text(
          "Verify phone",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: context.theme.canvasColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: context.theme.canvasColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      "Code is sent to " + phoneNo[0],
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF818181),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildCodeNumberBox(
                            code.length > 0 ? code.substring(0, 1) : ""),
                        buildCodeNumberBox(
                            code.length > 1 ? code.substring(1, 2) : ""),
                        buildCodeNumberBox(
                            code.length > 2 ? code.substring(2, 3) : ""),
                        buildCodeNumberBox(
                            code.length > 3 ? code.substring(3, 4) : ""),
                        buildCodeNumberBox(
                            code.length > 4 ? code.substring(4, 5) : ""),
                        buildCodeNumberBox(
                            code.length > 5 ? code.substring(5, 6) : ""),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Didn't recieve code? ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF818181),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Resend the code to the user");
                          },
                          child: Text(
                            "Request again",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF818181).withOpacity(0.65),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            decoration: BoxDecoration(color: context.theme.canvasColor),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        var userPhoneNumber = id[0];
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
                          Get.toNamed(RoutesClass.getUserCreate(),arguments: [userPhoneNumber]);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF8863F9).withOpacity(0.90),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: context.theme.shadowColor,
                              blurRadius: 20.0,
                              spreadRadius: 1,
                              offset: Offset(0.0, 0.75),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Verify and Create Account",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          NumericPad(
            onNumberSelected: (value) {
              final otp = code;
              print(value);
              setState(() {
                if (value != -1) {
                  if (code.length < 6) {
                    code = code + value.toString();
                  }
                } else {
                  if (code.length > 0) {
                    code = code.substring(0, code.length - 1);
                  }
                }
                print(code);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: 50,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.canvasColor,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: context.theme.shadowColor,
                blurRadius: 20.0,
                spreadRadius: 3,
                offset: Offset(0.0, 0.75),
              ),
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
