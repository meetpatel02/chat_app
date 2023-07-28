// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:bouncing_button/bouncing_button.dart';
import 'package:chat_app/Model/messageModel.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/custome_button.dart';
import 'logic.dart';

class ChatScreenPage extends StatelessWidget {
  ChatScreenPage({Key? key}) : super(key: key);

  final logic = Get.find<ChatScreenLogic>();
  final state = Get.find<ChatScreenLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: logic,
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: NetworkImage(logic.nameData[1]),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(logic.nameData[0].toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20),),
                        Visibility(
                            visible: logic.isTyping!,
                            child: Text(
                              'typing...',
                              style: TextStyle(fontSize: 13),
                            )),
                      ],
                    ),
                  )
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
                    image: AssetImage(logic.wallpaper != ''
                        ? logic.wallpaper.toString()
                        : 'assets/images/b1.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: ListView.builder(
                    reverse: true,
                    controller: logic.scrollController,
                    itemCount: logic.messages?.length,
                    itemBuilder: (BuildContext context, int index) {
                      MessageModel message = logic.messages![index];
                      Timestamp? timestamp = message.timestamp;
                      String formattedTime =
                          DateFormat('hh:mm a').format(timestamp!.toDate());
                      bool? read = message.read;
                      if (read == false) {
                        api.readMessage(Constants.userId, logic.nameData[2]);
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment:
                            message.senderId == logic.nameData[3]
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5),
                            child: Wrap(
                              direction: Axis.vertical,
                              crossAxisAlignment:
                                  message.senderId == logic.nameData[3]
                                      ? WrapCrossAlignment.end
                                      : WrapCrossAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 5),
                                  // height: 50,
                                  decoration: message.senderId ==
                                          logic.nameData[3]
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
                                        child: Column(
                                          crossAxisAlignment:
                                              message.senderId ==
                                                      logic.nameData[3]
                                                  ? CrossAxisAlignment.end
                                                  : CrossAxisAlignment.start,
                                          children: [
                                            message.audio!.isEmpty
                                                ? Text(
                                                    message.message.toString(),
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                : GestureDetector(
                                                    onTap: () async {
                                                      // logic.PlayAudio(message.audio.toString());
                                                      if (logic.isPlaying) {
                                                        await logic.audio
                                                            .pause();
                                                        logic.isPlaying = false;
                                                        logic.update();
                                                      } else {
                                                        await logic.audio
                                                            .play(UrlSource(
                                                                message.audio
                                                                    .toString()))
                                                            .then((value) {
                                                          logic.isPlaying =
                                                              true;
                                                          logic.update();
                                                        });
                                                      }
                                                    },
                                                    child: Icon(logic.isPlaying
                                                        ? Icons.pause
                                                        : Icons.play_arrow)),
                                            Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Text(
                                                  formattedTime,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                message.senderId ==
                                                        logic.nameData[3]
                                                    ? read == false
                                                        ? Icon(
                                                            Icons.done,
                                                            size: 19,
                                                          )
                                                        : Icon(
                                                            Icons.done_all,
                                                            size: 19,
                                                            color: Color(
                                                                0xFF024DFC),
                                                          )
                                                    : Text('')
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  )),
                  TypingIndicator(
                    showIndicator: logic.isTyping!,
                  ),
                  logic.showLock == true?
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Column(
                      children: [
                        Icon(Icons.lock_outline,color: Colors.white,),
                        Icon(Icons.keyboard_arrow_up,color: Colors.white,),
                      ],
                    ),
                  ):Container(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 6.0, right: 5, top: 10, bottom: 20),
                    child: Row(
                      children: [
                        !logic.showTextField
                            ? Container(
                                height: 50,
                                width: Get.width - 70,
                                decoration: BoxDecoration(
                                    color: context.theme.cardColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 10),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                          child: TextField(
                                        controller: logic.messageController,
                                        onChanged: (val) async {
                                          if (logic.messageController.text
                                              .isNotEmpty) {
                                            // print('true');
                                            List<String>? ids = [
                                              Constants.userId,
                                              logic.nameData[2].toString()
                                            ];
                                            ids.sort();
                                            String chatRoomId = ids.join("_");
                                            QuerySnapshot<Map<String, dynamic>>
                                                ref = await FirebaseFirestore
                                                    .instance
                                                    .collection('typing')
                                                    .doc(chatRoomId)
                                                    .collection('typing')
                                                    .where('senderId',
                                                        isEqualTo:
                                                            Constants.userId)
                                                    .where('isTyping',
                                                        isEqualTo: false)
                                                    .get();
                                            ref.docs.forEach((element) {
                                              element.reference
                                                  .update({'isTyping': true});
                                            });

                                            Future.delayed(Duration(seconds: 3),
                                                () async {
                                              // print('stop typing');
                                              List<String>? ids = [
                                                Constants.userId,
                                                logic.nameData[2].toString()
                                              ];
                                              ids.sort();
                                              String chatRoomId = ids.join("_");

                                              QuerySnapshot<
                                                      Map<String, dynamic>>
                                                  ref = await FirebaseFirestore
                                                      .instance
                                                      .collection('typing')
                                                      .doc(chatRoomId)
                                                      .collection('typing')
                                                      .where('senderId',
                                                          isEqualTo:
                                                              Constants.userId)
                                                      .where('isTyping',
                                                          isEqualTo: true)
                                                      .get();
                                              ref.docs.forEach((element) {
                                                element.reference.update(
                                                    {'isTyping': false});
                                              });
                                            });
                                            // api.typing(Constants.userId, logic.nameData[2].toString());
                                          }
                                          logic.update();
                                        },
                                        onSubmitted: (val) async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          if (logic.messageController.text
                                              .trim()
                                              .isNotEmpty) {
                                            ///Message Store in to Firebase
                                            logic.messages?.clear();
                                            logic.scrollController.animateTo(
                                              0.0,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeOut,
                                            );
                                            logic.sendMessage(
                                              MessageModel(
                                                  senderId: logic.nameData[3],
                                                  receiverId: logic.nameData[2],
                                                  message: logic
                                                      .messageController.text,
                                                  read: false,
                                                  audio: '',
                                                  timestamp: Timestamp.now()),
                                            );
                                          }
                                          logic.messageController.clear();
                                        },
                                        minLines: 1,
                                        maxLines: null,
                                        keyboardType: TextInputType.multiline,
                                        textInputAction: TextInputAction.send,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Type Here...',
                                          hintStyle: TextStyle(
                                              color:
                                                  context.theme.indicatorColor),
                                        ),
                                      )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          PermissionStatus storage =
                                              await Permission.storage
                                                  .request();
                                          if (storage ==
                                              PermissionStatus.granted) {
                                            logic.pickImage();
                                          } else if (storage ==
                                              PermissionStatus.denied) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'This permission is required')));
                                          } else if (storage ==
                                              PermissionStatus
                                                  .permanentlyDenied) {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                backgroundColor:
                                                    Color(0XFFc4c4c4),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                title: const Text(
                                                    'Chat App does not have access to your photos.To enable access,tap Setting and turn on Photos.'),
                                                actions: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            color: Color(
                                                                0XFFc4c4c4),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 100,
                                                          child: Button(
                                                            child: Text(
                                                                'Setting',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )),
                                                            onPressed: () {
                                                              openAppSettings();
                                                              Get.back();
                                                            },
                                                            color: Color(
                                                                0XFFc4c4c4),
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
                              )
                            : Container(
                                height: 50,
                                width: Get.width - 70,
                                decoration: BoxDecoration(
                                    color: context.theme.cardColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      logic.width <= 30?
                                      Row(
                                        children: [
                                          Icon(Icons.mic,color: Colors.red,),
                                          Text(
                                            'Timer: ${logic.formatDuration(Duration(seconds: logic.timerValueInSeconds))}',
                                          ),
                                        ],
                                      ):Stack(
                                        children: [
                                          Positioned(
                                            child: AnimatedBuilder(
                                              animation: controller,
                                              builder: (context, child) {
                                                return Opacity(
                                                  opacity: 1 -
                                                      logic.controller!.value,
                                                  child:
                                                  Transform.translate(
                                                    offset: logic.moveAnimation!
                                                        .value,
                                                    child: child,
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 20.0),
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      Shimmer.fromColors(
                                          baseColor: Colors.grey,
                                          highlightColor: Colors.grey.shade100,
                                          direction: ShimmerDirection.rtl,
                                          enabled: true,
                                          child: Text(
                                            'Slide to cancel <',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          )),
                                      SizedBox(
                                        width: logic.width,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 5,
                        ),
                        logic.messageController.text.trim().isEmpty
                            ? GestureDetector(

                                onLongPressMoveUpdate: (details) {
                                  ///leftSwipe detect

                                  if (details.localPosition.dx < 0) {
                                    if (logic.width <= 35) {
                                      logic.width++;
                                      logic.startAnimation();
                                      logic.update();
                                    }
                                  }
                                  ///UpSwipe detect
                                  else if(details.localPosition.dy <=5){
                                    logic.showMic = true;
                                    logic.showTextField = true;
                                    print('up');
                                  }
                                  },
                                onLongPress: () async {
                                  logic.showTextField = true;
                                  logic.showLock = true;
                                  logic.startTimer();
                                  logic.update();
                                  // final status =
                                  //     await Permission.microphone.request();
                                  // if (status == PermissionStatus.granted) {
                                  //   logic.startRecording();
                                  //   logic.audio.getDuration();
                                  // }
                                },
                                onLongPressEnd: (details) {
                                  if(logic.showMic == true){
                                    logic.showTextField = true;
                                  }
                                  logic.stopTimer();
                                  logic.showLock = false;
                                  // logic.showTextField = false;
                                  logic.width = 0;
                                  logic.update();
                                  // logic.stopRecording().then((value) {
                                  //   print(logic.audio.getDuration());
                                  // });
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(logic.showMic ? Icons.send :FontAwesomeIcons.microphone ),
                                ))
                            : BouncingButton(
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
                                    logic.messages?.clear();
                                    logic.scrollController.animateTo(
                                      0.0,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeOut,
                                    );
                                    logic.sendMessage(MessageModel(
                                        senderId: logic.nameData[3],
                                        receiverId: logic.nameData[2],
                                        message:
                                            logic.messageController.text ?? '',
                                        read: false,
                                        audio: '',
                                        timestamp: Timestamp.now()));

                                    // logic.messages
                                    //     .add(logic.messageController.text.toString());

                                    // logic.scrollToBottom();
                                  }
                                  logic.messageController.clear();
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({
    super.key,
    this.showIndicator = false,
    this.bubbleColor = const Color(0xFF646b7f),
    this.flashingCircleDarkColor = const Color(0xFF333333),
    this.flashingCircleBrightColor = const Color(0xFFaec1dd),
  });

  final bool showIndicator;
  final Color bubbleColor;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _appearanceController;

  late Animation<double> _indicatorSpaceAnimation;

  late Animation<double> _smallBubbleAnimation;
  late Animation<double> _mediumBubbleAnimation;
  late Animation<double> _largeBubbleAnimation;

  late AnimationController _repeatingController;
  final List<Interval> _dotIntervals = const [
    Interval(0.25, 0.8),
    Interval(0.35, 0.9),
    Interval(0.45, 1.0),
  ];

  @override
  void initState() {
    super.initState();

    _appearanceController = AnimationController(
      vsync: this,
    )..addListener(() {});

    _indicatorSpaceAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ).drive(Tween<double>(
      begin: 0.0,
      end: 60.0,
    ));

    _smallBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    );
    _mediumBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.2, 0.6, curve: Curves.easeOut),
    );
    _largeBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    _repeatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    if (widget.showIndicator) {
      _showIndicator();
    }
  }

  @override
  void didUpdateWidget(TypingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showIndicator != oldWidget.showIndicator) {
      if (widget.showIndicator) {
        _showIndicator();
      } else {
        _hideIndicator();
      }
    }
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    _repeatingController.dispose();
    super.dispose();
  }

  void _showIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 750)
      ..forward();
    _repeatingController.repeat();
  }

  void _hideIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 150)
      ..reverse();
    _repeatingController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _indicatorSpaceAnimation,
      builder: (context, child) {
        return SizedBox(
          height: _indicatorSpaceAnimation.value,
          child: child,
        );
      },
      child: Stack(
        children: [
          AnimatedBubble(
            animation: _smallBubbleAnimation,
            left: 8,
            bottom: 8,
            bubble: CircleBubble(
              size: 8,
              bubbleColor: widget.bubbleColor,
            ),
          ),
          AnimatedBubble(
            animation: _mediumBubbleAnimation,
            left: 10,
            bottom: 10,
            bubble: CircleBubble(
              size: 16,
              bubbleColor: widget.bubbleColor,
            ),
          ),
          AnimatedBubble(
            animation: _largeBubbleAnimation,
            left: 12,
            bottom: 12,
            bubble: StatusBubble(
              repeatingController: _repeatingController,
              dotIntervals: _dotIntervals,
              flashingCircleDarkColor: widget.flashingCircleDarkColor,
              flashingCircleBrightColor: widget.flashingCircleBrightColor,
              bubbleColor: widget.bubbleColor,
            ),
          ),
        ],
      ),
    );
  }
}

class CircleBubble extends StatelessWidget {
  const CircleBubble({
    super.key,
    required this.size,
    required this.bubbleColor,
  });

  final double size;
  final Color bubbleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bubbleColor,
      ),
    );
  }
}

class AnimatedBubble extends StatelessWidget {
  const AnimatedBubble({
    super.key,
    required this.animation,
    required this.left,
    required this.bottom,
    required this.bubble,
  });

  final Animation<double> animation;
  final double left;
  final double bottom;
  final Widget bubble;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      bottom: bottom,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.scale(
            scale: animation.value,
            alignment: Alignment.bottomLeft,
            child: child,
          );
        },
        child: bubble,
      ),
    );
  }
}

class StatusBubble extends StatelessWidget {
  const StatusBubble({
    super.key,
    required this.repeatingController,
    required this.dotIntervals,
    required this.flashingCircleBrightColor,
    required this.flashingCircleDarkColor,
    required this.bubbleColor,
  });

  final AnimationController repeatingController;
  final List<Interval> dotIntervals;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;
  final Color bubbleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        color: bubbleColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlashingCircle(
            index: 0,
            repeatingController: repeatingController,
            dotIntervals: dotIntervals,
            flashingCircleDarkColor: flashingCircleDarkColor,
            flashingCircleBrightColor: flashingCircleBrightColor,
          ),
          FlashingCircle(
            index: 1,
            repeatingController: repeatingController,
            dotIntervals: dotIntervals,
            flashingCircleDarkColor: flashingCircleDarkColor,
            flashingCircleBrightColor: flashingCircleBrightColor,
          ),
          FlashingCircle(
            index: 2,
            repeatingController: repeatingController,
            dotIntervals: dotIntervals,
            flashingCircleDarkColor: flashingCircleDarkColor,
            flashingCircleBrightColor: flashingCircleBrightColor,
          ),
        ],
      ),
    );
  }
}

class FlashingCircle extends StatelessWidget {
  const FlashingCircle({
    super.key,
    required this.index,
    required this.repeatingController,
    required this.dotIntervals,
    required this.flashingCircleBrightColor,
    required this.flashingCircleDarkColor,
  });

  final int index;
  final AnimationController repeatingController;
  final List<Interval> dotIntervals;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: repeatingController,
      builder: (context, child) {
        final circleFlashPercent = dotIntervals[index].transform(
          repeatingController.value,
        );
        final circleColorPercent = sin(pi * circleFlashPercent);

        return Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(
              flashingCircleDarkColor,
              flashingCircleBrightColor,
              circleColorPercent,
            ),
          ),
        );
      },
    );
  }
}

class FakeMessage extends StatelessWidget {
  const FakeMessage({
    super.key,
    required this.isBig,
  });

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      height: isBig ? 128 : 36,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.grey.shade300,
      ),
    );
  }
}
