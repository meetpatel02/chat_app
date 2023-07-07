// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/view/profile_screen/logic.dart';
import 'package:chat_app/view/splash/logic.dart';
import 'package:chat_app/view/user_create/logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../route/routes.dart';
import 'logic.dart';

class HomeScreenPage extends StatelessWidget {
  HomeScreenPage({Key? key}) : super(key: key);

  // final logic = Get.find<HomeScreenLogic>();
  final state = Get.find<HomeScreenLogic>().state;
  final profileLogic = Get.put(ProfileScreenLogic());
  HomeScreenLogic logic = Get.put(HomeScreenLogic());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: GetBuilder(
            init: logic,
            builder: (controller) {
              return SafeArea(
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
                                image: DecorationImage(
                                    image: NetworkImage(logic.profilePic),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.theme.cardColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
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
                                            'Message',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 300,
                                        child: Tab(
                                          child: Text(
                                            'Group',
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
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return GetBuilder(
                                      init: logic,
                                      builder: (controller) {
                                        return Container(
                                          height: Get.height - 100,
                                          decoration: BoxDecoration(
                                              color: context.theme.canvasColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(''),
                                                  Text(
                                                    'New Chat',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: Icon(
                                                          FontAwesomeIcons
                                                              .close),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: SizedBox(
                                                  height: 45,
                                                  child:
                                                      CupertinoSearchTextField(
                                                    controller: logic
                                                        .newChatSearchController,
                                                    prefixInsets:
                                                        EdgeInsets.only(
                                                            left: 10),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    onChanged: (value) {
                                                      logic.newChatSearchUser();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              logic.newChatSearchController.text
                                                      .isEmpty
                                                  ? Flexible(
                                                      child: ListView.builder(
                                                        itemCount:
                                                            logic.users?.length,
                                                        itemBuilder:
                                                            (ctx, int index) {
                                                          var names = logic
                                                              .users?[index]
                                                              .name;
                                                          var image = logic
                                                              .users?[index]
                                                              .profilePic;
                                                          var phoneno = logic
                                                              .users?[index]
                                                              .phone
                                                              .toString();
                                                          var isMe1 =
                                                              logic.isMe;
                                                          var id = logic
                                                              .users?[index].id;
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 10),
                                                            child: Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.toNamed(
                                                                        RoutesClass
                                                                            .getChat(),
                                                                        arguments: [
                                                                          names,
                                                                          image,
                                                                          isMe1,
                                                                          id,
                                                                        ]);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 70,
                                                                    width:
                                                                        Get.width -
                                                                            30,
                                                                    decoration: BoxDecoration(
                                                                        color: context
                                                                            .theme
                                                                            .cardColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10.0,
                                                                          right:
                                                                              10,
                                                                          top:
                                                                              10,
                                                                          bottom:
                                                                              10),
                                                                      child:
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
                                                                                  color: Colors.black,
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(image),
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(100),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    names!,
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 17,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    phoneno!,
                                                                                    style: TextStyle(
                                                                                      color: Colors.grey,
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.end,
                                                                            children: [
                                                                              Text(
                                                                                DateFormat('hh:mm a').format(DateTime.now()),
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 17,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                height: 20,
                                                                                width: 20,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.red),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    '1',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  : Flexible(
                                                      child: ListView.builder(
                                                        itemCount: logic
                                                            .resultList1
                                                            .length,
                                                        itemBuilder:
                                                            (ctx, int index) {
                                                          var names = logic.resultList1[index]['name'];
                                                          var image = logic.resultList1[index]['profilePic'];
                                                          var phoneno = logic.resultList1[index]['phone'].toString();
                                                          var isMe1 = logic.isMe;
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 10),
                                                            child: Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.toNamed(
                                                                        RoutesClass
                                                                            .getChat(),
                                                                        arguments: [
                                                                          names,
                                                                          image,
                                                                          isMe1
                                                                        ]);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 70,
                                                                    width:
                                                                        Get.width -
                                                                            30,
                                                                    decoration: BoxDecoration(
                                                                        color: context
                                                                            .theme
                                                                            .cardColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10.0,
                                                                          right:
                                                                              10,
                                                                          top:
                                                                              10,
                                                                          bottom:
                                                                              10),
                                                                      child:
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
                                                                                  color: Colors.black,
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(image),
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(100),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    names!,
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 17,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    phoneno,
                                                                                    style: TextStyle(
                                                                                      color: Colors.grey,
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.end,
                                                                            children: [
                                                                              Text(
                                                                                DateFormat('hh:mm a').format(DateTime.now()),
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 17,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                height: 20,
                                                                                width: 20,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.red),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    '1',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: context.theme.cardColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.chat,
                                    size: 30,
                                    // color: Colors.black,
                                  ),
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
                              ///Message Screen
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: SizedBox(
                                      height: 45,
                                      child: CupertinoSearchTextField(
                                        controller: logic.searchController,
                                        prefixInsets: EdgeInsets.only(left: 10),
                                        borderRadius: BorderRadius.circular(20),
                                        style: TextStyle(color: Colors.white),
                                        onChanged: (value) {
                                          logic.searchUser();
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  logic.searchController.text.isEmpty
                                      ? Flexible(
                                          child: ListView.builder(
                                            itemCount: logic.users?.length,
                                            itemBuilder: (ctx, int index) {
                                              var names =
                                                  logic.users?[index].name;
                                              var image = logic
                                                  .users?[index].profilePic;
                                              var phoneno = logic
                                                  .users?[index].phone
                                                  .toString();
                                              var isMe1 = logic.isMe;
                                              var id = logic.users?[index].id;
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            RoutesClass
                                                                .getChat(),
                                                            arguments: [
                                                              names,
                                                              image,
                                                              isMe1,
                                                              id,
                                                            ]);
                                                      },
                                                      child: Container(
                                                        height: 70,
                                                        width: Get.width - 30,
                                                        decoration: BoxDecoration(
                                                            color: context.theme
                                                                .cardColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  right: 10,
                                                                  top: 10,
                                                                  bottom: 10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height: 50,
                                                                    width: 50,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: NetworkImage(
                                                                            image),
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
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        names!,
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              17,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        phoneno!,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    DateFormat(
                                                                            'hh:mm a')
                                                                        .format(
                                                                            DateTime.now()),
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          17,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        color: Colors
                                                                            .red),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        '1',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : Flexible(
                                          child: ListView.builder(
                                            itemCount: logic.resultList.length,
                                            itemBuilder: (ctx, int index) {
                                              var names = logic
                                                  .resultList[index]['name'];
                                              var image =
                                                  logic.resultList[index]
                                                      ['profilePic'];
                                              var phoneno = logic
                                                  .resultList[index]['phone']
                                                  .toString();
                                              var isMe1 = logic.isMe;

                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            RoutesClass
                                                                .getChat(),
                                                            arguments: [
                                                              names,
                                                              image,
                                                              isMe1
                                                            ]);
                                                      },
                                                      child: Container(
                                                        height: 70,
                                                        width: Get.width - 30,
                                                        decoration: BoxDecoration(
                                                            color: context.theme
                                                                .cardColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0,
                                                                  right: 10,
                                                                  top: 10,
                                                                  bottom: 10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height: 50,
                                                                    width: 50,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      image:
                                                                          DecorationImage(
                                                                        image: NetworkImage(
                                                                            image),
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
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        names!,
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              17,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        phoneno!,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    DateFormat(
                                                                            'hh:mm a')
                                                                        .format(
                                                                            DateTime.now()),
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          17,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50),
                                                                        color: Colors
                                                                            .red),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        '1',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                ],
                              ),

                              ///Group Screen
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
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
                                      itemCount: 10,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 70,
                                                width: Get.width - 30,
                                                decoration: BoxDecoration(
                                                    color:
                                                        context.theme.cardColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10,
                                                          top: 10,
                                                          bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            width: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: Center(
                                                              child: Image(
                                                                image: AssetImage(
                                                                    'assets/images/Male Memojis.png'),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Group',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 17,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Meet',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            DateFormat(
                                                                    'hh:mm a')
                                                                .format(DateTime
                                                                    .now()),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                color:
                                                                    Colors.red),
                                                            child: Center(
                                                              child: Text(
                                                                '1',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
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
              );
            },
          ),
        ),
      ),
    );
  }
}
