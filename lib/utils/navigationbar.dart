import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../screen/call_screen.dart';
import '../screen/home_screen.dart';
import '../screen/profile_screen.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  late List screen = [];
  var username = Get.arguments;
  @override
  void initState() {
    super.initState();
    screen = [
      HomeScreen(),
     CallScreen(),
      ProfileScreen(),
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
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: context.theme.canvasColor,
        selectedItemColor: context.theme.hintColor,
        unselectedItemColor: context.theme.hoverColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat),label: 'chat'),
          BottomNavigationBarItem(icon: Icon(Icons.call),label: 'Call'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile')
        ],
        onTap: (int index){
          setState(() {
            _selectedIndex= index;
          });
        },
      ),
      body: screen[_selectedIndex],
    );
  }
}
