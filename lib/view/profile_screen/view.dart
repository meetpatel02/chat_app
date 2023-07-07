import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/view/home_screen/logic.dart';
import 'package:chat_app/view/splash/logic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../route/routes.dart';
import 'logic.dart';
import 'dart:math' as math;

class ProfileScreenPage extends StatelessWidget {
  ProfileScreenPage({Key? key}) : super(key: key);
  final logic = Get.put(ProfileScreenLogic());

  // final logic = Get.find<ProfileScreenLogic>();
  final state = Get.find<ProfileScreenLogic>().state;
  final homeLogic = Get.find<HomeScreenLogic>();
  final splashLogic = Get.find<SplashLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
      init: logic,
      builder: (controller) {
        return SafeArea(
            child: Container(
          height: Get.height,
          width: Get.width,
          color: context.theme.canvasColor,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black,
                    image: DecorationImage(
                        image: NetworkImage(logic.profilePic),
                        fit: BoxFit.cover),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: context.theme.shadowColor,
                        blurRadius: 20.0,
                        spreadRadius: 2,
                        offset: Offset(0.0, 0.75),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  logic.name,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: Get.width - 30,
                  decoration: BoxDecoration(
                    color: context.theme.cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Edit Profile',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: Get.width - 30,
                  decoration: BoxDecoration(
                    color: context.theme.cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Transform.rotate(
                                angle: 90 * math.pi / 180,
                                child: Icon(
                                  Icons.key,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Account',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesClass.getChatBackground());
                  },
                  child: Container(
                    height: 50,
                    width: Get.width - 30,
                    decoration: BoxDecoration(
                      color: context.theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF25D366),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Icon(FontAwesomeIcons.whatsapp)),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Chats',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                      backgroundColor: context.theme.cardColor,
                      titleStyle: TextStyle(fontSize: 20),
                      cancel: ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          print(prefs.getString('phone'));
                          print(prefs.getString('userData'));
                          Get.back();
                        },
                        child: Text('No'),
                      ),
                      confirm: ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();
                          FirebaseAuth.instance.signOut();
                          Get.back();
                          Get.toNamed(RoutesClass.getLogin());
                          logic.update();
                        },
                        child: Text('Yes'),
                      ),
                      title: 'Are you sure you want to logout!!',
                      middleText: '',
                    );
                  },
                  child: Container(
                    height: 50,
                    width: Get.width - 30,
                    decoration: BoxDecoration(
                      color: context.theme.cardColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Log Out',
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    ));
  }
}
