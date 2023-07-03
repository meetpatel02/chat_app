import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route/routes.dart';
import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final logic = Get.find<LoginLogic>();
  final state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            color: Color(0xFFfafafa),
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                opacity: 0.25,
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 400,
              width: Get.width,
              decoration: BoxDecoration(
                  color: context.theme.canvasColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 30,
                      spreadRadius: 10,
                      color: Colors.black38,
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Enjoy the new experience of\n chating with global friends',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: context.theme.hintColor,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Connect people around the world for free',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InkWell(
                        onTap: () {
                          // Get.toNamed(RoutesClass.getHome());
                          Get.toNamed(RoutesClass.getPhoneLogin());
                          // bottomSheet(context);
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: const Color(0xFF703EFE),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                  const Color(0xFF8863F9).withOpacity(0.40),
                                  spreadRadius: 4,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                )
                              ]),
                          child: Center(
                            child: const Text(
                              'Get Started',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
