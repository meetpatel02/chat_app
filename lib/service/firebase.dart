import 'dart:async';
import 'dart:convert';

import 'package:chat_app/Model/messageModel.dart';
import 'package:chat_app/Model/user_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/typingModel.dart';

var api = FirebaseManager();

class FirebaseManager {
  var userCollection = FirebaseFirestore.instance.collection('userProfile');
  var message = FirebaseFirestore.instance.collection('message');
  bool? isTyping = false;

  ///Login Time get user
  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> userExists(
      phoneNo) async {
    var result = await userCollection.where('phone', isEqualTo: phoneNo).get();
    if (result.docs.isEmpty) {
      return null;
    } else {
      return result.docs.first;
    }
  }

  Future<ProfileModel> getCurrentUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('userData').toString();
    ProfileModel userdata = ProfileModel.fromjson(jsonDecode(data));
    return userdata;
  }



  // Future createMessage(MessageModel messageModel) async {
  //   try {
  //     await message.doc().set(messageModel.toJson());
  //   } catch (e) {
  //     if (e is PlatformException) {
  //       return e.message;
  //     }
  //     return e.toString();
  //   }
  // }
  ///sendMessage
  Future sendMessage(
      String senderId, String receiverId, MessageModel messageModel) async {
    List<String>? ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .add(messageModel.toJson());
  }




  ///getMessage
  Stream<QuerySnapshot> getMessage(String receiverId, String senderId) {
    List<String>? ids = [receiverId, senderId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return FirebaseFirestore.instance
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: true)
    .limit(15)
        .snapshots();
  }


  ///getLast Message
  Stream<QuerySnapshot> getLastMessage(String receiverId, String senderId) {
    List<String>? ids = [receiverId, senderId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return FirebaseFirestore.instance
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();
  }

  ///UnreadMessage Count
  Stream<int> getUnreadMessage(String receiverId, String senderId){
    List<String>? ids = [receiverId, senderId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return FirebaseFirestore.instance
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .where('read',isEqualTo: false)
        .snapshots()
      .map((event) => event.docs.length);
    ;
  }

  ///Read Unread Method
  Future readMessage(String senderId, String receiverId) async {
    List<String>? ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    QuerySnapshot<Map<String, dynamic>> ref = await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .where('senderId', isEqualTo: receiverId)
        .where('read', isEqualTo: false)
        .get();
    ref.docs.forEach((element) {
      element.reference.update({'read': true});
    });
  }

///User Typing method
  Future userTyping(
      String senderId, String receiverId,Typing typing) async {
    List<String>? ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await FirebaseFirestore.instance
        .collection('typing')
        .doc(chatRoomId)
        .collection('typing')
        .add(typing.toJson());
  }

  ///getIsTyping or not
  Stream<QuerySnapshot> getIsTyping(String receiverId, String senderId) {
    List<String>? ids = [receiverId, senderId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return FirebaseFirestore.instance
        .collection('typing')
        .doc(chatRoomId)
        .collection('typing')
        .where('receiverId',isEqualTo: senderId)
        .snapshots();
  }

}
