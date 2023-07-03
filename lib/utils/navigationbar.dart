import 'package:chat_app/view/call_screen/view.dart';
import 'package:chat_app/view/home_screen/logic.dart';
import 'package:chat_app/view/home_screen/view.dart';
import 'package:chat_app/view/login/logic.dart';
import 'package:chat_app/view/profile_screen/logic.dart';
import 'package:chat_app/view/profile_screen/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/call_screen/logic.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  late List screen = [];
  var username = Get.arguments;
  // final homeLogic = Get.find<HomeScreenLogic>();
  @override
  void initState() {
    super.initState();
    Get.put(HomeScreenLogic());
    Get.put(CallScreenLogic());
    Get.put(ProfileScreenLogic());
    screen = [
      HomeScreenPage(),
      CallScreenPage(),
      ProfileScreenPage(),
    ];
  }

  void refersh(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: context.theme.canvasColor,
        selectedItemColor: context.theme.hintColor,
        unselectedItemColor: context.theme.hoverColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Call'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: screen[_selectedIndex],
    );
  }
}
