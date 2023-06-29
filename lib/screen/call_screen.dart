// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  List callUserList = ['Meet', 'Kush', 'Jimil', 'Prince'];
  List<Color> callUserColor = [
    Color(0xFF808080),
    Color(0xFFFF0000),
    Color(0xFF808080),
    Color(0xFFFF0000),
  ];
  List<Icon> callIcon = [
    Icon(Icons.videocam),
    Icon(Icons.call),
    Icon(Icons.videocam),
    Icon(Icons.call)
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              color: context.theme.canvasColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: context.theme.cardColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                            child: Image(
                          image: AssetImage('assets/images/Male Memojis.png'),
                        )),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: context.theme.cardColor,
                              borderRadius: BorderRadius.circular(25)),
                          child: Theme(
                            data: theme.copyWith(
                              colorScheme: theme.colorScheme.copyWith(
                                surfaceVariant: Colors.transparent,
                              ),
                            ),
                            child: TabBar(
                              indicator: BoxDecoration(
                                color: Color(0xFF024DFC),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              indicatorColor: Colors.transparent,
                              labelColor: Colors.white,
                              unselectedLabelColor: Color(0xFF51557E),
                              labelPadding: EdgeInsets.zero,
                              tabs: [
                                Container(
                                  width: 300,
                                  child: Tab(
                                    child: Text(
                                      'All',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  child: Tab(
                                    child: Text(
                                      'Missed',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: context.theme.cardColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.notifications,
                            size: 30,
                            // color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: TabBarView(
                      children: [
                        ///Call Screen
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: SizedBox(
                                height: 45,
                                child: CupertinoSearchTextField(
                                  prefixInsets: EdgeInsets.only(left: 10),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Flexible(
                              child: ListView.builder(
                                itemCount: callUserList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 10,
                                    ),
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      right: 5,
                                      top: 10,
                                    ),
                                    height: 70,
                                    width: Get.width - 30,
                                    decoration: BoxDecoration(
                                        color: context.theme.cardColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/Male Memojis.png'),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        callUserList[index],
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: callUserColor[
                                                              index],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          callIcon[index],
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text('Incoming')
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    DateFormat('dd/MM/yy')
                                                        .format(DateTime.now()),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.info),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        ///MissedCall Screen
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: SizedBox(
                                height: 45,
                                child: CupertinoSearchTextField(
                                  prefixInsets: EdgeInsets.only(left: 10),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Flexible(
                              child: ListView.builder(
                                itemCount: callUserList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 10,
                                    ),
                                    padding: EdgeInsets.only(
                                        left: 10, right: 5, top: 10),
                                    height: 70,
                                    width: Get.width - 30,
                                    decoration: BoxDecoration(
                                        color: context.theme.cardColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/Male Memojis.png'),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        callUserList[index],
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        children: [
                                                          callIcon[index],
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text('Incoming')
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('Sunday'),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.info),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
