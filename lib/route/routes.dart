// ignore_for_file: prefer_const_constructors

import 'package:chat_app/screen/login_screen.dart';
import 'package:chat_app/screen/splash_screen.dart';
import 'package:get/get.dart';


import '../screen/chatScreen_bgchange.dart';
import '../screen/chat_screen.dart';
import '../screen/otp_screen.dart';
import '../screen/phonelogin_screen.dart';
import '../screen/profile_screen.dart';
import '../screen/userProfile_name.dart';
import '../utils/navigationbar.dart';

class RoutesClass {
  static String splash = '/';
  static String login = '/login';
  static String home = '/home';
  static String chat = '/chat';
  static String profile = '/profile';
  static String phoneLogin = '/phoneLogin';
  static String otpScreen = '/otpScreen';
  static String userCreate = '/userCreate';
  static String chatBackground = '/chatBackground';
  static String getLogin() => login;
  static String getHome() => home;
  static String getChat() => chat;
  static String getProfile() => profile;
  static String getPhoneLogin() => phoneLogin;
  static String getOtpScreen() => otpScreen;
  static String getUserCreate() => userCreate;
  static String getChatBackground() => chatBackground;

  static List<GetPage> routes = [
    GetPage(name: splash, page: ()=>SplashScreen()),
    GetPage(name: login, page: () => LoginScreen(),transition: Transition.fade),
    GetPage(
        name: home, page: () => NavigationBar(), transition: Transition.fade),
    GetPage(name: chat, page: () => ChatScreen(), transition: Transition.fade),
    GetPage(
        name: profile,
        page: () => ProfileScreen(),
        transition: Transition.fade),
    GetPage(
        name: phoneLogin, page: () => PhoneLogin(), transition: Transition.fade),
    GetPage(
        name: otpScreen, page: () => VerifyPhone(verificationId: '',), transition: Transition.fade),
    GetPage(
        name: userCreate, page: () => UserCreate(), transition: Transition.fade),
    GetPage(
        name: chatBackground, page: () => ChatScreenBackgroundChange(), transition: Transition.fade),

  ];
}
