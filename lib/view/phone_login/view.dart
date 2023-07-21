import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/keyboard_custome.dart';
import 'logic.dart';

class PhoneLoginPage extends StatelessWidget {
  PhoneLoginPage({Key? key}) : super(key: key);

  final logic = Get.find<PhoneLoginLogic>();
  final state = Get.find<PhoneLoginLogic>().state;


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
      body: GetBuilder(
        init: logic,
        builder: (controller) {
          return Column(
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
                          logic.focusNode.requestFocus();
                          logic.keyBoardShow = true;
                          logic.update();
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            focusNode: logic.focusNode,
                            showCursor: false,
                            readOnly: true,
                            controller: logic.phoneController,
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
                        logic.checkPhoneNo(context);
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
                opacity: logic.keyBoardShow ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                curve: Curves.bounceInOut,
                child: logic.keyBoardShow
                    ? NumericPad(onNumberSelected: logic.onKeyPress)
                    : Container(),
              ),
            ],
          );
        },
      ),
    );
  }

}
