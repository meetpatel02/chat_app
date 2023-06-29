// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:material3/route/routes.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   Splash1 splashscreen = Splash1();
//   void initState() {
//     // TODO: implement initState
//     splashscreen.splash(context);
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       backgroundColor: context.theme.canvasColor,
//       body: Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//
//       // decoration: BoxDecoration(
//       //   image: DecorationImage(
//       //       image: AssetImage(
//       //         'assets/images/chatapp-logo.jpg'
//       //       ),
//       //       fit: BoxFit.cover),
//       // ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//             child: Image(width: 200, image: AssetImage( 'assets/images/logo.png')),
//           ),
//           SizedBox(height: 10,),
//           Text('Chat App',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
//         ],
//       ),
//     ),);
//   }
// }
//
// class Splash1  {
//   void splash(BuildContext context) async {
//     Timer(const Duration(seconds: 3), () => Get.toNamed(RoutesClass.getHome()));
//     // email == null ? Timer(const Duration(seconds: 3), () => Get.offAndToNamed(MyRoutes.loginRoute)) : Timer(const Duration(seconds: 3), () => Get.offAndToNamed(MyRoutes.dashboard));
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../route/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  Timer? timer;
  Color? color ;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.fastOutSlowIn,
    );

    _animationController!.forward();
      // User already logged in, navigate to home screen
      Timer(const Duration(seconds: 3), () => Get.toNamed(RoutesClass.getLogin()));

  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.canvasColor,
      body: Center(
        child: ScaleTransition(
            scale: _animation!,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 180,
                  ),
                ),
                Text('Chat App',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
              ],
            )),
      ),
    );
  }
}
