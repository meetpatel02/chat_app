import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route/routes.dart';
import '../../screen/keyboard_custome.dart';
import 'logic.dart';

class OtpPage extends StatelessWidget {
  OtpPage({Key? key}) : super(key: key);

  final logic = Get.find<OtpLogic>();
  final state = Get.find<OtpLogic>().state;


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
      body: GetBuilder(
        init: logic,
        builder: (controller) {
          return Column(
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
                          "Code is sent to " + logic.phoneNo[0],
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
                                logic.code.length > 0 ? logic.code.substring(0, 1) : "",context),
                            buildCodeNumberBox(
                                logic.code.length > 1 ? logic.code.substring(1, 2) : "",context),
                            buildCodeNumberBox(
                                logic.code.length > 2 ? logic.code.substring(2, 3) : "",context),
                            buildCodeNumberBox(
                                logic.code.length > 3 ? logic.code.substring(3, 4) : "",context),
                            buildCodeNumberBox(
                                logic.code.length > 4 ? logic.code.substring(4, 5) : "",context),
                            buildCodeNumberBox(
                                logic.code.length > 5 ? logic.code.substring(5, 6) : "",context),
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
                            // var userPhoneNumber = id[0];
                            logic.checkOtp(context);
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
                  final otp = logic.code;
                  print(value);
                    if (value != -1) {
                      if (logic.code.length < 6) {
                        logic.code = logic.code + value.toString();
                      }
                    } else {
                      if (logic.code.length > 0) {
                        logic.code = logic.code.substring(0, logic.code.length - 1);
                      }
                    }
                    print(logic.code);
                    logic.update();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildCodeNumberBox(String codeNumber,BuildContext context) {
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
