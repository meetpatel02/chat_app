// ignore_for_file: prefer_const_constructors

import 'package:chat_app/view/chat_screen/binding.dart';
import 'package:chat_app/view/chat_screen/view.dart';
import 'package:chat_app/view/login/binding.dart';
import 'package:chat_app/view/login/view.dart';
import 'package:chat_app/view/otp/binding.dart';
import 'package:chat_app/view/otp/view.dart';
import 'package:chat_app/view/phone_login/binding.dart';
import 'package:chat_app/view/phone_login/view.dart';
import 'package:chat_app/view/privacy_policy_screen/binding.dart';
import 'package:chat_app/view/privacy_policy_screen/view.dart';
import 'package:chat_app/view/splash/view.dart';
import 'package:chat_app/view/user_create/binding.dart';
import 'package:chat_app/view/user_create/view.dart';
import 'package:get/get.dart';

import '../utils/chatScreen_bgchange.dart';
import '../utils/navigationbar.dart';
import '../view/splash/binding.dart';

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
  static String privacyPolicy = '/privacyPolicy';
  static String getLogin() => login;
  static String getHome() => home;
  static String getChat() => chat;
  static String getProfile() => profile;
  static String getPhoneLogin() => phoneLogin;
  static String getOtpScreen() => otpScreen;
  static String getUserCreate() => userCreate;
  static String getChatBackground() => chatBackground;
  static String getPrivacyPolicy() => privacyPolicy;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashPage(), binding: SplashBinding()),
    GetPage(
        name: login,
        page: () => LoginPage(),
        transition: Transition.fade,
        binding: LoginBinding()),
    GetPage(
        name: home, page: () => NavigationBar(), transition: Transition.fade),
    GetPage(
        name: chat,
        page: () => ChatScreenPage(),
        transition: Transition.fade,
        binding: ChatScreenBinding()),
    GetPage(
        name: phoneLogin,
        page: () => PhoneLoginPage(),
        transition: Transition.fade,
        binding: PhoneLoginBinding()),
    GetPage(
        name: otpScreen,
        page: () => OtpPage(),
        transition: Transition.fade,
        binding: OtpBinding()),
    GetPage(
        name: userCreate,
        page: () => UserCreatePage(),
        transition: Transition.fade,
        binding: UserCreateBinding()),
    GetPage(
        name: chatBackground,
        page: () => ChatScreenBackgroundChange(),
        transition: Transition.fade),
    GetPage(
        name: privacyPolicy,
        page: () => PrivacyPolicyScreenPage(),
        transition: Transition.fade,
        binding: PrivacyPolicyScreenBinding()),
  ];
}
