// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors

import 'dart:math';
import 'package:chat_app/api/user_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../route/routes.dart';

class HomeScreen extends StatefulWidget {
  // var profilePic;
  HomeScreen({super.key, });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var generatedColor = Random().nextInt(Colors.primaries.length);
  bool isMe = true;

  DataController dataController = Get.put(DataController());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    super.initState();
    dataController.getUserData();
    // widget.profilePic;
  }

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
                        // child: widget.profilePic != null
                        //     ? ClipOval(
                        //         child: Image.file(
                        //           widget.profilePic!,
                        //           fit: BoxFit.cover,
                        //         ),
                        //       )
                        //     :
                       child: ClipOval(
                                child: Image(
                                  image: NetworkImage(
                                    'https://www.goodmorningimagesdownload.com/wp-content/uploads/2021/12/Best-Quality-Profile-Images-Pic-Download-2023.jpg',
                                  ),
                                ),
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
                        ///Message Screen
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
                                child: Obx(
                              () => dataController.isDataLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      itemCount:
                                          dataController.user!.users.length,
                                      itemBuilder: (ctx, int index) {
                                        var names = dataController
                                            .user?.users[index].firstName;
                                        var image = dataController
                                            .user?.users[index].image;
                                        var isMe1 = isMe;
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(
                                                      RoutesClass.getChat(),
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
                                                      color: context
                                                          .theme.cardColor,
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
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Colors.primaries[Random().nextInt(Colors
                                                                        .primaries
                                                                        .length)],
                                                                    Colors.primaries[Random().nextInt(Colors
                                                                        .primaries
                                                                        .length)],
                                                                  ],
                                                                ),
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                          image!),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
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
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        17,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Meet',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
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
                                                                  color: Colors
                                                                      .red),
                                                              child: Center(
                                                                child: Text(
                                                                  '1',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
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
                            )),
                          ],
                        ),

                        ///Group Screen
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
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int i) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: Get.width - 30,
                                          decoration: BoxDecoration(
                                              color: context.theme.cardColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
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
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Colors.primaries[Random()
                                                                .nextInt(Colors
                                                                    .primaries
                                                                    .length)],
                                                            Colors.primaries[Random()
                                                                .nextInt(Colors
                                                                    .primaries
                                                                    .length)],
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
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
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Meet',
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
                                                      DateFormat('hh:mm a')
                                                          .format(
                                                              DateTime.now()),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: Colors.red),
                                                      child: Center(
                                                        child: Text(
                                                          '1',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
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
        ),
      ),
    );
  }
}
