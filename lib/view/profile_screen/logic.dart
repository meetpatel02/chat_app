import 'package:chat_app/Model/user_profile_model.dart';
import 'package:chat_app/service/firebase.dart';
import 'package:get/get.dart';
import 'state.dart';

class ProfileScreenLogic extends GetxController {
  final ProfileScreenState state = ProfileScreenState();
  ProfileModel profileModel = ProfileModel();

  var name = '';
  var profilePic = '';
  var phoneNo = '';
  var isOnline = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfileData();
    name;
    update();
  }

  getProfileData() async {
    profileModel = await api.getCurrentUserData();
    name = profileModel.name.toString();
    profilePic = profileModel.profilePic.toString();
    phoneNo = profileModel.phone.toString();
    update();
  }
}
