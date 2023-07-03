import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../route/routes.dart';
import 'state.dart';

class SplashLogic extends GetxController with SingleGetTickerProviderMixin{
  final SplashState state = SplashState();
  AnimationController? _animationController;
  Animation<double>? animation;
  Timer? timer;
  Color? color ;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.fastOutSlowIn,
    );

    _animationController!.forward();
    // User already logged in, navigate to home screen
    Timer(const Duration(seconds: 3), () => Get.toNamed(RoutesClass.getLogin()));

  }
}

