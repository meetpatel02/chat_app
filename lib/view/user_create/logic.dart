import 'dart:convert';
import 'dart:io';

import 'package:chat_app/Model/user_profile_model.dart';
import 'package:chat_app/view/splash/logic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../route/routes.dart';
import '../../service/firebase.dart';
import '../../utils/custome_loader.dart';
import 'state.dart';

class UserCreateLogic extends GetxController {
  final UserCreateState state = UserCreateState();
  var number = Get.arguments;
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  String path = '';
  final addUser = FirebaseFirestore.instance.collection('userProfile');
  final docId = FirebaseFirestore.instance.collection('userProfile').doc();
  List profilePicUrl = [];
  final logic = Get.find<SplashLogic>();
  ProfileModel profileModel = ProfileModel();
  var name = '';
  var profilePic = '';
  var phoneNo = '';
  var id = '';
  var isLoaded = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    phoneController.text = number[0];
  }

  void checkName(BuildContext context) {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please Enter Your Name',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
    } else {
      createUserProfile(
          context,
          ProfileModel(
            id: docId.id,
            name: nameController.text.trim().toString(),
            profilePic: profilePicUrl.last
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', ''),
            phone: phoneController.text,
          ));
    }
    update();
  }

  Future getCameraImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      showProgressbarDialog(context);
      final ref = FirebaseStorage.instance.ref().child(image.name);
      path = image.path.toString();
      await ref.putFile(File(image.path));
      ref.getDownloadURL().then((value) {
        profilePicUrl.add(value);
        print(profilePicUrl);
      });

    } else {
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
    }
    hideProgressDialog();
    update();
  }

  Future getGalleryImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      showProgressbarDialog(context);
      final ref = FirebaseStorage.instance.ref().child(image.name);
      path = image.path.toString();
      await ref.putFile(File(image.path));
      ref.getDownloadURL().then((value) {
        profilePicUrl.add(value);
        print(profilePicUrl);
      });
    } else {
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
    }
    hideProgressDialog();
    update();
  }

  createUserProfile(context, ProfileModel profileModel) async {
    var id = docId.id;
    var name = nameController.text.trim().toString();
    var profilePic = profilePicUrl.last
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '');
    var phone = phoneController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await addUser.add(profileModel.toMap());
    await docId.set(profileModel.toMap());
    getUserData();
    Get.toNamed(RoutesClass.getPrivacyPolicy());
    update();
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await api.userExists(prefs.getString('phone'));
    if (result != null) {
      String result1 = jsonEncode(result.data());
      prefs.setString('userData', result1);
    }
    update();
  }

  // void getUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.getString('phone');
  //   var result = await api.userExists(prefs.getString('phone'));
  //   if (result != null) {
  //     String result1 = jsonEncode(result.data());
  //     prefs.setString('userData', result1);
  //   }
  // }
}
