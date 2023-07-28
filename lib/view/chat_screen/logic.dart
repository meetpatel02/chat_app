import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/Model/messageModel.dart';
import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/typingModel.dart';
import '../../service/firebase.dart';
import 'state.dart';

class ChatScreenLogic extends GetxController with GetTickerProviderStateMixin{
  final ChatScreenState state = ChatScreenState();
  var nameData = Get.arguments;
  var userId = '';
  TextEditingController messageController = TextEditingController();
  File? image;
  List<XFile> imagelist = [];
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles = [];
  List<MessageModel>? messages = [];
  List<Typing>? typing = [];
  AnimationController? controller;
  Animation<double>? jumpAnimation;
  Animation<double>? rotateAnimation;
  Animation<Offset>? moveAnimation;
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
  FlutterSoundRecorder? audioRecorder;
  FlutterSoundPlayer? audioPlayer;
  bool isRecording = false;
  bool isPlaying = false;
  String? audioPath = '';
  double playProgress = 0.0;
  final AudioPlayer audio = AudioPlayer();
  bool showTextField = false;
  bool showLock = false;
  bool showMic = false;
  double width = 0;
  Timer? timer;
  int timerValueInSeconds = 0;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1500));
    audioRecorder = FlutterSoundRecorder();
    audioPlayer = FlutterSoundPlayer();
    audioPlayer?.openPlayer();
    id = nameData[3];
    userId = nameData[2];
    print(userId);
    print(id);
    getWallpaper();
    getMessage();
    getTyping();
    wallpaper;

    // Jump Animation
    jumpAnimation = Tween<double>(begin: 0, end: -100).animate(CurvedAnimation(
      parent: controller!,
      curve: Interval(0, 0.5, curve: Curves.easeOut),
    ));

    // Rotate Animation
    rotateAnimation = Tween<double>(begin: 0, end: 2 * 3.14).animate(CurvedAnimation(
      parent: controller!,
      curve: Interval(0.5, 0.75, curve: Curves.easeInOut),
    ));

    // Move Animation
    moveAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1.5, 0),
    ).animate(CurvedAnimation(
      parent: controller!,
      curve: Interval(0.75, 1, curve: Curves.easeIn),
    ));

    // _keyboardVisibilityController.onChange.listen((bool visible) {
    //   _isKeyboardVisible = visible;
    //   if (!visible) {
    //     scrollToBottom();
    //
    // });
    scrollController.addListener(_scrollController);
    Future.delayed(Duration.zero, () {
      api.readMessage(Constants.userId, nameData[2]);
      update();
    });
  }

  void startTimer() {
    const oneSec =  Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer t) {
      timerValueInSeconds += 1;
     update();
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void startAnimation() {
    controller?.reset();
    controller?.forward();
  }

  void stopTimer() async {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
      timerValueInSeconds =0;
    }
    update();
  }

  Future<void> startRecording() async {

    try {
      await audioRecorder!.openRecorder();
      await audioRecorder!.startRecorder(toFile: 'audio_recording.aac');

      isRecording = true;
      update();
    } catch (err) {
      print('Error starting recording: $err');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecorder!.stopRecorder();

        isRecording = false;
        update();

      uploadRecordingToFirebase(path!);

    } catch (err) {
      print('Error stopping recording: $err');
    }
  }
   PlayAudio(String url){
      audioPlayer?.startPlayer(fromURI: url);
    update();
  }
  Future<void> uploadRecordingToFirebase(String path) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.mp4';
      var ref =
          FirebaseStorage.instance.ref().child('audio').child(fileName);

      await ref.putFile(File(path));
      ref.getDownloadURL().then((value) {
        audioPath = value;
        print('Path:${audioPath}');

        ///Firebase add audioFile
        sendMessage(MessageModel(
            senderId: nameData[3],
            receiverId: nameData[2],
            message: messageController.text??'',
            read: false,
            audio: audioPath,
            timestamp: Timestamp.now()));
      });
      update();
    } catch (err) {
      print('Error uploading recording to Firebase: $err');
    }
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
