import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utils/custome_button.dart';
import 'logic.dart';

class UserCreatePage extends StatelessWidget {
  UserCreatePage({Key? key}) : super(key: key);

  final logic = Get.find<UserCreateLogic>();
  final state = Get.find<UserCreateLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Create Profile",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: context.theme.cardColor,
          centerTitle: true,
        ),
        backgroundColor: context.theme.canvasColor,
        body: GetBuilder(
          init: logic,
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.black,
                            // image: DecorationImage(
                            //   image: NetworkImage(
                            //       'https://www.goodmorningimagesdownload.com/wp-content/uploads/2021/12/Best-Quality-Profile-Images-Pic-Download-2023.jpg'),
                            // ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: context.theme.shadowColor,
                                blurRadius: 29.0,
                                spreadRadius: 1,
                                offset: Offset(0.0, 0.75),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                              backgroundImage: logic.path.isNotEmpty
                                  ? FileImage(File(logic.path.toString()))
                                  : NetworkImage(
                                          'https://www.getillustrations.com/photos/pack/3d-avatar-male_lg.png')
                                      as ImageProvider),

                        ),
                        Positioned(
                          right: 10.0,
                          bottom: 0.0,
                          child: GestureDetector(
                            onTap: () {
                              getProfilePic(context);
                            },
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.25)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: context.theme.shadowColor,
                                    blurRadius: 20.0,
                                    spreadRadius: 1,
                                    offset: Offset(0.0, 0.75),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    padding: EdgeInsets.only(left: 10, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: context.theme.shadowColor,
                          blurRadius: 20.0,
                          spreadRadius: 1,
                          offset: Offset(0.0, 0.75),
                        ),
                      ],
                      color: context.theme.canvasColor,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Profile Details',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text(
                              'Phone No : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Flexible(
                              child: TextField(
                                controller: logic.phoneController,
                                showCursor: false,
                                readOnly: true,
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Phone no',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text(
                              'Name : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Flexible(
                              child: TextField(
                                controller: logic.nameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Enter Name',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            logic.checkName(context);
                          },
                          child: Container(
                            height: 60,
                            margin: EdgeInsets.only(left: 20, right: 20),
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
                            child: Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  getProfilePic(BuildContext context) {
    Get.bottomSheet(
      backgroundColor: const Color(0xFF8863F9).withOpacity(0.90),
      barrierColor: Colors.transparent,
      Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                PermissionStatus storage = await Permission.camera.request();
                if (storage == PermissionStatus.granted) {
                  logic.getCameraImage(context);
                } else if (storage == PermissionStatus.denied) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('This permission is required')));
                } else if (storage == PermissionStatus.permanentlyDenied) {
                  Navigator.pop(context);
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: context.theme.canvasColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: const Text(
                          'Chat App does not have access to your camera.To enable access,tap Setting and turn on Camera.'),
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Button(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  color: Color(0XFFc4c4c4),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Button(
                                  child: Text('Setting',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  onPressed: () {
                                    openAppSettings();
                                    Get.back();
                                  },
                                  color: Color(0XFFc4c4c4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                  return;
                }
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Camera',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              indent: 10,
              endIndent: 10,
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () async {
                PermissionStatus storage = await Permission.storage.request();
                if (storage == PermissionStatus.granted) {
                  logic.getGalleryImage(context);
                } else if (storage == PermissionStatus.denied) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('This permission is required')));
                } else if (storage == PermissionStatus.permanentlyDenied) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: Color(0XFFc4c4c4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: const Text(
                          'Chat App does not have access to your photos.To enable access,tap Setting and turn on Photos.'),
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Button(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  color: Color(0XFFc4c4c4),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Button(
                                  child: Text('Setting',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  onPressed: () {
                                    openAppSettings();
                                    Get.back();
                                  },
                                  color: Color(0XFFc4c4c4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                  return;
                }
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
