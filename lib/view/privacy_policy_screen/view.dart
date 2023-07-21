import 'package:chat_app/route/routes.dart';
import 'package:chat_app/utils/custome_button.dart';
import 'package:chat_app/utils/custome_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/firebase.dart';
import 'logic.dart';

class PrivacyPolicyScreenPage extends StatelessWidget {
  PrivacyPolicyScreenPage({Key? key}) : super(key: key);

  final logic = Get.find<PrivacyPolicyScreenLogic>();
  final state = Get.find<PrivacyPolicyScreenLogic>().state;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Welcome to ChatApp',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.hintColor),
              ),
            ),
            Container(
                height: 300,
                child: const Image(
                    image: AssetImage('assets/images/privacy.png'))),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text:
                          'ChatApp is updating our Terms and \nPrivacy Policy to reflect new features like \nChatApp callind.',
                      style: TextStyle(color: theme.hintColor, fontSize: 18)),
                  TextSpan(
                      text: ' Read ',
                      style: TextStyle(color: Colors.blue, fontSize: 18)),
                  TextSpan(
                      text:
                          'Our Terms and \nPrivacy Policy and learn about the \nchoice you have.',
                      style: TextStyle(color: theme.hintColor, fontSize: 18)),
                ])),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 60,
              width: 150,
              decoration: BoxDecoration(
                color: const Color(0xFF8863F9).withOpacity(0.90),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: context.theme.shadowColor,
                    blurRadius: 20.0,
                    spreadRadius: 1,
                    offset: Offset(0.0, 0.75),
                  ),
                ],
              ),
              child: Button(
                  onPressed: () async {
                    logic.profileModel = await api.getCurrentUserData();
                    logic.name = logic.profileModel.name.toString();
                    logic.profilePic = logic.profileModel.profilePic.toString();
                    logic.phoneNo = logic.profileModel.phone.toString();
                    print('Name:  ${logic.name}');
                    print('Name:  ${logic.profilePic}');
                    Get.offAndToNamed(RoutesClass.getHome());
                    logic.update();
                  },
                  color: Color(0xFF8863F9).withOpacity(0.90),
                  child: Text(
                    'AGREE',
                    style: TextStyle(
                        color: theme.hintColor, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
