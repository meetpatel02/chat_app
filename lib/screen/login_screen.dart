// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../route/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

void bottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      enableDrag: true,
      builder: (BuildContext bc) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 10,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
              Text(
                'Login With Phone',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  Get.back();
                  Get.toNamed(RoutesClass.getPhoneLogin());
                },
                color: Color(0xFF8863F9),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      });
}
