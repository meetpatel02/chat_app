import 'dart:convert';

import 'package:chat_app/Model/user_profile_model.dart';
import 'package:chat_app/utils/custome_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
var api = FirebaseManager();

class FirebaseManager{
  var userCollection = FirebaseFirestore.instance.collection('userProfile');

///Login Time get user
  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> userExists(phoneNo) async {
    var result = await userCollection
        .where('phone', isEqualTo: phoneNo)
        .get();
    if (result.docs.isEmpty) {
      return null;
    } else {
      // var loginResponse = UserDetail.fromjson(result.docs.first.data());
      return result.docs.first;
    }
  }

  Future<ProfileModel> getCurrentUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('userData').toString();
    ProfileModel userdata = ProfileModel.fromjson(jsonDecode(data));
    return userdata;
  }


///HomeScreen Chat get all user
  Future<List<ProfileModelForChat>?> getUsers() async {
    var result = await userCollection
        .get();
    if (result.docs.isEmpty) {
      return null;
    } else {
      return result.docs
          .map((docSnapshot) => ProfileModelForChat.fromDocumentSnapshot(docSnapshot))
          .toList();
    }
  }
}
