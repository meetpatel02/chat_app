import 'package:chat_app/utils/custome_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../Model/user_profile_model.dart';
import '../../service/firebase.dart';
import 'state.dart';

class HomeScreenLogic extends GetxController {
  final HomeScreenState state = HomeScreenState();
  bool isMe = true;
  bool isDataLoaded = false;
  ProfileModel profileModel = ProfileModel();
  var searchController = TextEditingController();
  var newChatSearchController = TextEditingController();
  var name = '';
  var profilePic = '';
  var phoneNo = '';
  bool isLoaded = false;
  List<ProfileModelForChat>? users = [];
  List searchList = [];
  List resultList = [];

  List searchList1 = [];
  List resultList1 = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfileData();
    getUserForChat();
  }

  @override
  void notifyChildrens() {
    // TODO: implement notifyChildrens
    super.notifyChildrens();
    searchUser();
  }

  void getProfileData() async {
    profileModel = await api.getCurrentUserData();
    name = profileModel.name.toString();
    profilePic = profileModel.profilePic.toString();
    phoneNo = profileModel.phone.toString();
    isLoaded = true;
    update();
  }

  Future getUserForChat() async {
    users = await api.getUsers() ?? [];
    isDataLoaded;
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
