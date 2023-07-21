import 'dart:convert';

import 'package:chat_app/utils/custome_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/user_profile_model.dart';
import '../../service/firebase.dart';
import 'state.dart';

class PrivacyPolicyScreenLogic extends GetxController {
  final PrivacyPolicyScreenState state = PrivacyPolicyScreenState();
  final docId = FirebaseFirestore.instance.collection('userProfile').doc();
  ProfileModel profileModel = ProfileModel();
  var name = '';
  var profilePic = '';
  var phoneNo = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserData();
    print(name);
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


}
