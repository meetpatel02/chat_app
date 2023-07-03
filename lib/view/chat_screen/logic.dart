import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'state.dart';

class ChatScreenLogic extends GetxController {
  final ChatScreenState state = ChatScreenState();
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
  ScrollController scrollController = ScrollController();
  KeyboardVisibilityController _keyboardVisibilityController =
      KeyboardVisibilityController();
  bool _isKeyboardVisible = false;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getWallpaper();
    wallpaper;
    _keyboardVisibilityController.onChange.listen((bool visible) {
      _isKeyboardVisible = visible;

      if (!visible) {
        // Scroll the list when the keyboard closes
        scrollToBottom();
      }
    });
    update();
  }

  getWallpaper() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('wallpaper');
    wallpaper = data??'';
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
