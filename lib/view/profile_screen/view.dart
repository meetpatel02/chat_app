import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route/routes.dart';
import 'logic.dart';

class ProfileScreenPage extends StatelessWidget {
  ProfileScreenPage({Key? key}) : super(key: key);

  final logic = Get.find<ProfileScreenLogic>();
  final state = Get.find<ProfileScreenLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      // image: DecorationImage(
                      //   image: NetworkImage(
                      //       'https://www.goodmorningimagesdownload.com/wp-content/uploads/2021/12/Best-Quality-Profile-Images-Pic-Download-2023.jpg'),
                      // ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: context.theme.shadowColor,
                          blurRadius: 20.0,
                          spreadRadius: 1,
                          offset: Offset(0.0, 0.75),
                        ),
                      ],
                    ),
                    child:
                    // widget.profilePic != null
                    //     ? ClipOval(
                    //   child: Image.file(
                    //     widget.profilePic!,
                    //     fit: BoxFit.cover,
                    //   ),
                    // )
                    //     :
                    ClipOval(
                      child: Image(
                        image: NetworkImage(
                            'https://www.goodmorningimagesdownload.com/wp-content/uploads/2021/12/Best-Quality-Profile-Images-Pic-Download-2023.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'User Name',
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
                          Text(
                            'Edit Profile',
                            style: TextStyle(fontSize: 15),
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
                          Text(
                            'Account',
                            style: TextStyle(fontSize: 15),
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
                    onTap: (){
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
                            Text(
                              'Chats',
                              style: TextStyle(fontSize: 15),
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
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('No'),
                        ),
                        confirm: ElevatedButton(
                          onPressed: () async {
                            Get.back();
                            Get.toNamed(RoutesClass.getLogin()
                            );
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
          )),
    );
  }
}
