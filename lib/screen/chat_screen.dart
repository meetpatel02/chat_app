import 'dart:math';
import 'package:bouncing_button/bouncing_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../utils/custome_button.dart';

class ChatScreen extends StatefulWidget {
  var name;
  ChatScreen({Key? key, this.name}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isMe = false;
  var nameData = Get.arguments;
  TextEditingController messageController = TextEditingController();
  List messages = [
    'Hello',
    'Hi there',
    'How are you?',
    'I\'m doing great, thanks!',
    'Flutter is awesome!',
  ];
  bool _initialValue = true;
  File? image;
  List<XFile> imagelist = [];
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles = [];
  var wallpaper = '';
  ScrollController _scrollController = ScrollController();
  KeyboardVisibilityController _keyboardVisibilityController = KeyboardVisibilityController();
  bool _isKeyboardVisible = false;
  @override
  void initState() {
    super.initState();
    getWallpaper();
    wallpaper;
    _keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });

      if (!visible) {
        // Scroll the list when the keyboard closes
        _scrollToBottom();
      }
    });

  }

  var generatedColor = Random().nextInt(Colors.primaries.length);
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
                image: NetworkImage(nameData[1]),
              )),
            ),
            SizedBox(
              width: 10,
            ),
            Text(nameData[0])
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
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(wallpaper.toString()), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: nameData[2]
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: nameData[2]
                              ? WrapCrossAlignment.end
                              : WrapCrossAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 10, bottom: 10),
                              // height: 50,
                              decoration: nameData[2]
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
                                      messages[index],
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
                            controller: messageController,
                            onSubmitted: (var text) {
                              setState(() {
                                if (messageController.text.trim().isNotEmpty) {
                                  messages.add(text);
                                  _scrollToBottom();
                                }
                                messageController.clear();
                              });
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
                                _pickImage();
                              } else if (storage == PermissionStatus.denied) {
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
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
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
                                                    fontWeight: FontWeight.w400,
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
                        if (messageController.text.trim().isNotEmpty) {
                          messages.add(messageController.text.toString());
                          _scrollToBottom();
                        }
                        messageController.clear();
                        setState(() {});
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
      ),
    );
  }

  getWallpaper() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('wallpaper');
    wallpaper = data!;
    setState(() {});
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  Future camerapickimage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imagetemp = File(image.path);
      setState(() {
        this.image = imagetemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 50,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

// void _sendMessage(String text) {
//   // Handle sending the message
//   messages.add(text);
//   print('Sending message: $text');
// }
