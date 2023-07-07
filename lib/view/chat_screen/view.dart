import 'dart:math';

import 'package:bouncing_button/bouncing_button.dart';
import 'package:chat_app/Model/messageModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/custome_button.dart';
import 'logic.dart';

class ChatScreenPage extends StatelessWidget {
  ChatScreenPage({Key? key}) : super(key: key);

  final logic = Get.find<ChatScreenLogic>();
  final state = Get.find<ChatScreenLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  ],
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                  child: Image(
                image: NetworkImage(logic.nameData[1]),
              )),
            ),
            SizedBox(
              width: 10,
            ),
            Text(logic.nameData[0])
          ],
        ),
        backgroundColor: context.theme.cardColor,
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.video,
                  size: 22,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.phone,
                  size: 22,
                ),
              ),
            ],
          ),
        ],
      ),
      body: GetBuilder(
        init: logic,
        builder: (controller) {
          return Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(logic.wallpaper != ''
                      ? logic.wallpaper.toString()
                      : 'assets/images/b1.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: logic.scrollController,
                    itemCount: logic.messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: logic.nameData[2]
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5),
                            child: Wrap(
                              direction: Axis.vertical,
                              crossAxisAlignment: logic.nameData[2]
                                  ? WrapCrossAlignment.end
                                  : WrapCrossAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  // height: 50,
                                  decoration: logic.nameData[2]
                                      ? BoxDecoration(
                                          color: context.theme.dividerColor,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        )
                                      : BoxDecoration(
                                          color: context.theme.focusColor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                        ),
                                  child: Column(
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: Get.width * 0.6,
                                        ),
                                        child: Text(
                                          logic.messages[index],
                                          softWrap: true,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, right: 5, top: 10, bottom: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: Get.width - 70,
                        decoration: BoxDecoration(
                            color: context.theme.cardColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.microphone,
                                color: context.theme.indicatorColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: TextField(
                                controller: logic.messageController,
                                onSubmitted: (var text) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  if (logic.messageController.text
                                      .trim()
                                      .isNotEmpty) {
                                    ///Message Store in to Firebase
                                    logic.storeMessage(
                                        context,
                                        MessageModel(
                                            messageId: logic.ref.id +
                                                logic.nameData[3],
                                            receiverId: logic.userId,
                                            timestamp: DateTime.now(),
                                            message: text,
                                            senderId:
                                                prefs.getString('userId')));

                                    logic.messages.add(text);
                                    logic.scrollToBottom();
                                  }
                                  logic.messageController.clear();
                                  logic.update();
                                },
                                minLines: 1,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.send,
                                decoration: InputDecoration.collapsed(
                                    border: InputBorder.none,
                                    hintText: 'Type Here...',
                                    hintStyle: TextStyle(
                                        color: context.theme.indicatorColor)),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  PermissionStatus storage =
                                      await Permission.storage.request();
                                  if (storage == PermissionStatus.granted) {
                                    logic.pickImage();
                                  } else if (storage ==
                                      PermissionStatus.denied) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'This permission is required')));
                                  } else if (storage ==
                                      PermissionStatus.permanentlyDenied) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        backgroundColor: Color(0XFFc4c4c4),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        title: const Text(
                                            'Chat App does not have access to your photos.To enable access,tap Setting and turn on Photos.'),
                                        actions: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: Button(
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    color: Color(0XFFc4c4c4),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: Button(
                                                    child: Text('Setting',
                                                        style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                    onPressed: () {
                                                      openAppSettings();
                                                      Get.back();
                                                    },
                                                    color: Color(0XFFc4c4c4),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                    return;
                                  }
                                  // Get.back();
                                },
                                child: Icon(
                                  Icons.image_outlined,
                                  color: context.theme.indicatorColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.emoji_emotions_outlined,
                                color: context.theme.indicatorColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      BouncingButton(
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(Icons.send),
                          ),
                          onPressed: () {
                            if (logic.messageController.text
                                .trim()
                                .isNotEmpty) {
                              logic.messages
                                  .add(logic.messageController.text.toString());
                              logic.scrollToBottom();
                            }
                            logic.messageController.clear();
                            logic.update();
                          })
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: AnimatedContainer(
                      //     height: 50,
                      //     width: 50,
                      // decoration: BoxDecoration(
                      //     color: Colors.blueAccent,
                      //     borderRadius: BorderRadius.circular(50)),
                      //     duration: const Duration(milliseconds: 100),
                      //     curve: Curves.fastLinearToSlowEaseIn,
                      //     child: Icon(
                      //       Icons.send,
                      //       color: context.theme.indicatorColor,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
