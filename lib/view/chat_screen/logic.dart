import 'dart:async';
import 'dart:io';
import 'package:chat_app/Model/messageModel.dart';
import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/typingModel.dart';
import '../../service/firebase.dart';
import 'state.dart';

class ChatScreenLogic extends GetxController {
  final ChatScreenState state = ChatScreenState();
  var nameData = Get.arguments;
  var userId = '';
  TextEditingController messageController = TextEditingController();
  final addUser = FirebaseFirestore.instance.collection('messages');
  final ref = FirebaseFirestore.instance.collection('messages').doc();
  File? image;
  List<XFile> imagelist = [];
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles = [];
  List<MessageModel>? messages = [];
  List<Typing>? typing = [];

  var wallpaper = '';
  ScrollController scrollController = ScrollController();
  KeyboardVisibilityController _keyboardVisibilityController =
      KeyboardVisibilityController();
  bool _isKeyboardVisible = false;
  MessageModel messageModel = MessageModel();
  String? id = '';
  bool? isTyping = false;
  Typing? ty;
  bool hasMore = true;
  bool isLoading = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getUserId();
    id = nameData[3];
    userId = nameData[2];
    print(userId);
    print(id);
    getWallpaper();
    getMessage();
    getTyping();
    wallpaper;
    // _keyboardVisibilityController.onChange.listen((bool visible) {
    //   _isKeyboardVisible = visible;
    //   if (!visible) {
    //     scrollToBottom();
    //   }
    // });
    scrollController.addListener(_scrollController);
    Future.delayed(Duration.zero, () {
      api.readMessage(Constants.userId, nameData[2]);
      update();
    });
  }

  ///send Messages
  Future sendMessage(MessageModel messageModel) async {
    await api.sendMessage(nameData[3].toString(), nameData[2], messageModel);
    update();
  }

  _scrollController() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadMoreMessage(nameData[3], nameData[2]);
    }
  }

  ///getMessages
  getMessage() {
    api
        .getMessage(nameData[2], nameData[3])
        .listen((QuerySnapshot querySnapshot) {
      messages = querySnapshot.docs
          .map((e) => MessageModel.fromDocumentSnapshot(e))
          .toList();
      update();
    });
  }

  // fetchMessage(String receiverId, String senderId) {
  //   List<String>? ids = [receiverId, senderId];
  //   ids.sort();
  //   String chatRoomId = ids.join("_");
  //   var query = FirebaseFirestore.instance
  //       .collection('chat_room')
  //       .doc(chatRoomId)
  //       .collection('message')
  //       .orderBy('timestamp', descending: true)
  //       .limit(15);
  //   query.snapshots().listen((QuerySnapshot querySnapshot) {
  //     messages?.addAll(querySnapshot.docs
  //         .map((e) => MessageModel.fromDocumentSnapshot(e))
  //         .toList());
  //     update();
  //   });
  //   update();
  // }

  loadMoreMessage(String receiverId, String senderId) {
    List<String>? ids = [receiverId, senderId];
    ids.sort();
    String chatRoomId = ids.join("_");
    if (isLoading) return;
      isLoading = true;
      update();

    var query = FirebaseFirestore.instance
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: true)
        .startAfter([messages?.last.timestamp]).limit(15);
    query.get().then((querySnapshot) {
      messages?.addAll(querySnapshot.docs
          .map((e) => MessageModel.fromDocumentSnapshot(e))
          .toList());
      isLoading = false;
      update();
    });
    update();
  }


  ///getIsTyping
  getTyping() {
    api
        .getIsTyping(nameData[2], nameData[3])
        .listen((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        ty = Typing.fromDocumentSnapshot(querySnapshot.docs.last);
        isTyping = ty?.isTyping;
        update();
      }
    });
    update();
  }

  ///getWallpaper
  getWallpaper() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('wallpaper');
    wallpaper = data ?? '';
    update();
  }

  scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 50,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  void pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
      update();
    }
  }

  Future camerapickimage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imagetemp = File(image.path);
      this.image = imagetemp;
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
