import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../route/routes.dart';
import 'state.dart';

class UserCreateLogic extends GetxController {
  final UserCreateState state = UserCreateState();
  var number = Get.arguments;
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  RxString path = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    phoneController.text = number[0].toString().replaceAll('[', '').replaceAll(']', '');
    update();
  }
  void checkName(){
    var userName = nameController.text.toString();
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please Enter Your Name',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
    } else {
      Get.toNamed(RoutesClass.getHome(),
          arguments: [userName]);
    }
  }
  Future getCameraImage()async{
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if(image != null){
      path.value = image.path.toString();
    }else{
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
    }
  }
  Future getGalleryImage()async{
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      path.value = image.path.toString();
    }else{
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
    }
  }
}
