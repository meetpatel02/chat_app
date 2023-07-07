import 'dart:async';
import 'dart:convert';

import 'package:chat_app/service/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/user_profile_model.dart';
import '../../route/routes.dart';
import 'state.dart';

class SplashLogic extends GetxController with SingleGetTickerProviderMixin {
  final SplashState state = SplashState();
  AnimationController? _animationController;
  Animation<double>? animation;
  Timer? timer;
  Color? color;
  final user = FirebaseAuth.instance.currentUser;
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
    user;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.fastOutSlowIn,
    );

    _animationController!.forward();
    if (user != null) {
      // getUserData();
      getProfileData();
      Timer(
          const Duration(seconds: 3), () => Get.toNamed(RoutesClass.getHome()));
    } else {
      Timer(const Duration(seconds: 3),
          () => Get.toNamed(RoutesClass.getLogin()));
    }
  }

  // void getUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var result = await api.userExists(prefs.getString('phone'));
  //   if (result != null) {
  //     String result1 = jsonEncode(result.data());
  //     prefs.setString('userData', result1);
  //     print(prefs.getString('phone'));
  //   }
  // }

  ///Data Get for HomeScreen and ProfileScreen
  void getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profileModel = await api.getCurrentUserData();
    name = profileModel.name.toString();
    profilePic = profileModel.profilePic.toString();
    phoneNo = profileModel.phone.toString();
    id = profileModel.id.toString();
    prefs.setString('userId', id);
    print(prefs.getString('userId'));
    update();
  }

}
