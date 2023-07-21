import 'dart:convert';

import 'package:chat_app/Model/messageModel.dart';
import 'package:chat_app/Model/typingModel.dart';
import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/user_profile_model.dart';
import '../../service/firebase.dart';
import 'state.dart';
class HomeScreenLogic extends GetxController {
  final HomeScreenState state = HomeScreenState();
  bool isDataLoaded = false;
  ProfileModel profileModel = ProfileModel();
  var searchController = TextEditingController();
  var newChatSearchController = TextEditingController();
  var name = '';
  var profilePic = '';
  var phoneNo = '';
  var id = '';
  bool isLoaded = false;
  List<ProfileModelForChat>? users = [];
  MessageModel? messageModel;
  List searchList = [];
  List resultList = [];
  List searchList1 = [];
  List resultList1 = [];
  var userGetRef =
  FirebaseFirestore.instance.collection('userProfile').snapshots();
  String? onLoginUserId = '';
  var timeStamp = '';
  List<Contact> contact = [];
  List<Contact> filteredContacts = [];
  Typing? ty;
  bool? isTyping = false;
  List userId = [];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfileData();
    getUserId();
    getUser();
    // getTyping();
    // getLastChat();
    onLoginUserId;
  }

  @override
  void notifyChildrens() {
    // TODO: implement notifyChildrens
    super.notifyChildrens();
    searchUser();
  }


  ///Contacts Method
  getContacts() async {
    if (await Permission.contacts.request().isGranted) {
      // Permission is granted, fetch contacts
      List<Contact> contacts =
          await ContactsService.getContacts(withThumbnails: false);
      contact = contacts;
      update();
    }
  }
  ///Search Contact Method
  void searchContacts(String query) {
    filteredContacts = contact
        .where((contact) =>
            contact.displayName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    filteredContacts = contact
        .where((contact) => contact.phones!.first.value!
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    update();
  }


  ///UnreadMessage Method
  getUnreadMessage(String receiverId, String senderId) {
    api.getUnreadMessage(receiverId, senderId);
  }

  ///UserGetForChat
  getUser() {
    FirebaseFirestore.instance
        .collection('userProfile')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      users = querySnapshot.docs
          .map((e) => ProfileModelForChat.fromDocumentSnapshot(e))
          .toList();
      update();
    });
  }

  ///Typing or not
  getTyping(String id){
    api.getIsTyping(id, Constants.userId).listen((QuerySnapshot querySnapshot) {
      if(querySnapshot.docs.isNotEmpty){
        ty = Typing.fromDocumentSnapshot(querySnapshot.docs.last);
        isTyping = ty?.isTyping;
        print(ty);
      }
    });
  }

  ///GetLastChat
  getLastChat()async {
    List<String>? ids = ['3qYRA5F4mddY8D9MjY94issQsrr1', Constants.userId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return FirebaseFirestore.instance
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        messageModel =
            MessageModel.fromDocumentSnapshot(querySnapshot.docs.last);
        print(messageModel!.message);
        update();
      }
    });
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    onLoginUserId = prefs.getString('userId');
  }

  void getProfileData() async {
    profileModel = await api.getCurrentUserData();
    name = profileModel.name.toString();
    profilePic = profileModel.profilePic.toString();
    phoneNo = profileModel.phone.toString();
    id = profileModel.id.toString();
    isLoaded = true;
    update();
  }

  void searchUser() async {
    final result = await FirebaseFirestore.instance
        .collection('userProfile')
        .orderBy('name')
        .get();
    final phoneResult = await FirebaseFirestore.instance
        .collection('userProfile')
        .orderBy('phone')
        .get();
    searchList = result.docs;
    searchList = phoneResult.docs;
    searchResult();
    update();
  }

  void newChatSearchUser() async {
    final result = await FirebaseFirestore.instance
        .collection('userProfile')
        .orderBy('name')
        .get();
    final phoneResult = await FirebaseFirestore.instance
        .collection('userProfile')
        .orderBy('phone')
        .get();
    searchList1 = result.docs;
    searchList1 = phoneResult.docs;
    newChatSearchResult();
    update();
  }

  searchResult() {
    var showResult = [];
    if (searchController.text != '') {
      for (var name in searchList) {
        var names = name['name'].toString().toLowerCase();
        if (names.contains(searchController.text.toLowerCase())) {
          showResult.add(name);
        }
      }

      for (var phoneNo in searchList) {
        var phone = phoneNo['phone'].toString().toLowerCase();
        if (phone.contains(searchController.text.toLowerCase())) {
          showResult.add(phoneNo);
        }
      }
    } else {
      showResult = List.from(searchList);
    }

    resultList = showResult;
    update();
  }

  newChatSearchResult() {
    var showResult = [];
    if (newChatSearchController.text != '') {
      for (var name in searchList1) {
        var names = name['name'].toString().toLowerCase();
        if (names.contains(newChatSearchController.text.toLowerCase())) {
          showResult.add(name);
        }
      }

      for (var phoneNo in searchList1) {
        var phone = phoneNo['phone'].toString().toLowerCase();
        if (phone.contains(newChatSearchController.text.toLowerCase())) {
          showResult.add(phoneNo);
        }
      }
    } else {
      showResult = List.from(searchList1);
    }

    resultList1 = showResult;
    update();
  }
}
