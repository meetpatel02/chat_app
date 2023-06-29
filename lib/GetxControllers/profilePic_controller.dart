import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class ProfilePicController extends GetxController{
  RxString path = ''.obs;
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