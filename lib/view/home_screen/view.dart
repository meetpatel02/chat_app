// ignore_for_file: must_be_immutable

import 'package:chat_app/Model/typingModel.dart';
import 'package:chat_app/Model/user_profile_model.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/service/firebase.dart';
import 'package:chat_app/view/profile_screen/logic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../route/routes.dart';
import 'logic.dart';

class HomeScreenPage extends StatelessWidget {
  HomeScreenPage({Key? key}) : super(key: key);

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
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black,
                                image: DecorationImage(
                                    image: NetworkImage(logic.profilePic),
                                    fit: BoxFit.cover),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: context.theme.shadowColor,
                                    blurRadius: 20.0,
                                    spreadRadius: 2,
                                    offset: Offset(0.0, 0.75),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
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
                                      color: const Color(0xFF024DFC),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    indicatorColor: Colors.transparent,
                                    labelColor: Colors.white,
                                    unselectedLabelColor:
                                        const Color(0xFF51557E),
                                    labelPadding: EdgeInsets.zero,
                                    tabs: [
                                      Container(
                                        width: 300,
                                        child: const Tab(
                                          child: Text(
                                            'Message',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 300,
                                        child: const Tab(
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
                            const SizedBox(
                              width: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                logic.getContacts();
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
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20))),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(''),
                                                  const Text(
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
                                                      child: const Icon(
                                                          FontAwesomeIcons
                                                              .close),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
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
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    // style: const TextStyle(color: Colors.white),
                                                    onChanged: (value) {
                                                      logic.searchContacts(
                                                          value);
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              logic.newChatSearchController.text
                                                      .isEmpty
                                                  ? Flexible(
                                                      child: ListView.builder(
                                                        itemCount: logic
                                                            .contact.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          Contact contacts =
                                                              logic.contact[
                                                                  index];
                                                          final avatar =
                                                              contacts.avatar;
                                                          String displayText =
                                                              contacts.displayName ??
                                                                  '';

                                                          final name = contacts
                                                                  .displayName ??
                                                              '';

                                                          final phoneNumbers =
                                                              contacts.phones!
                                                                  .map((phone) =>
                                                                      phone
                                                                          .value)
                                                                  .toList();

                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 10,
                                                                    left: 10,
                                                                    right: 10),
                                                            child: Container(
                                                              width: Get.width -
                                                                  30,
                                                              decoration: BoxDecoration(
                                                                  color: context
                                                                      .theme
                                                                      .cardColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10.0,
                                                                        bottom:
                                                                            10),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              20,
                                                                        ),
                                                                        avatar != null &&
                                                                                avatar.isNotEmpty
                                                                            ? CircleAvatar(
                                                                                backgroundImage: MemoryImage(avatar),
                                                                              )
                                                                            : CircleAvatar(
                                                                                child: Text(contacts.initials()),
                                                                              ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(name),
                                                                            SizedBox(height: 8), // Add some spacing between name and phone numbers
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: phoneNumbers.map((phoneNumber) => Text(phoneNumber!)).toList(),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  : Flexible(
                                                      child: ListView.builder(
                                                        itemCount: logic
                                                            .filteredContacts
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          Contact contacts =
                                                              logic.filteredContacts[
                                                                  index];
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 10,
                                                                    left: 10,
                                                                    right: 10),
                                                            child: Container(
                                                              height: 70,
                                                              width: Get.width -
                                                                  30,
                                                              decoration: BoxDecoration(
                                                                  color: context
                                                                      .theme
                                                                      .cardColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(contacts
                                                                          .displayName ??
                                                                      ''),
                                                                  Text(contacts
                                                                          .phones
                                                                          ?.first
                                                                          .value
                                                                          .toString() ??
                                                                      ''),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                              // logic.newChatSearchController.text
                                              //         .isEmpty
                                              //     ? Flexible(
                                              //         child: ListView.builder(
                                              //           itemCount:
                                              //               logic.users?.length,
                                              //           itemBuilder:
                                              //               (ctx, int index) {
                                              //             var names = logic
                                              //                 .users?[index]
                                              //                 .name;
                                              //             var image = logic
                                              //                 .users?[index]
                                              //                 .profilePic;
                                              //             var phoneno = logic
                                              //                 .users?[index]
                                              //                 .phone
                                              //                 .toString();
                                              //
                                              //             var id = logic
                                              //                 .users?[index].id;
                                              //             return Padding(
                                              //               padding:
                                              //                   const EdgeInsets
                                              //                           .only(
                                              //                       bottom: 10),
                                              //               child: Column(
                                              //                 children: [
                                              //                   GestureDetector(
                                              //                     onTap: () {
                                              //                       Get.toNamed(
                                              //                           RoutesClass
                                              //                               .getChat(),
                                              //                           arguments: [
                                              //                             names,
                                              //                             image,
                                              //                             id,
                                              //                           ]);
                                              //                     },
                                              //                     child:
                                              //                         Container(
                                              //                       height: 70,
                                              //                       width:
                                              //                           Get.width -
                                              //                               30,
                                              //                       decoration: BoxDecoration(
                                              //                           color: context
                                              //                               .theme
                                              //                               .cardColor,
                                              //                           borderRadius:
                                              //                               BorderRadius.circular(20)),
                                              //                       child:
                                              //                           Padding(
                                              //                         padding: const EdgeInsets
                                              //                                 .only(
                                              //                             left:
                                              //                                 10.0,
                                              //                             right:
                                              //                                 10,
                                              //                             top:
                                              //                                 10,
                                              //                             bottom:
                                              //                                 10),
                                              //                         child:
                                              //                             Row(
                                              //                           mainAxisAlignment:
                                              //                               MainAxisAlignment.spaceBetween,
                                              //                           children: [
                                              //                             Row(
                                              //                               children: [
                                              //                                 Container(
                                              //                                   height: 50,
                                              //                                   width: 50,
                                              //                                   decoration: BoxDecoration(
                                              //                                     color: Colors.black,
                                              //                                     image: DecorationImage(
                                              //                                       image: NetworkImage(image),
                                              //                                     ),
                                              //                                     borderRadius: BorderRadius.circular(100),
                                              //                                   ),
                                              //                                 ),
                                              //                                 const SizedBox(
                                              //                                   width: 10,
                                              //                                 ),
                                              //                                 Column(
                                              //                                   crossAxisAlignment: CrossAxisAlignment.start,
                                              //                                   children: [
                                              //                                     Text(
                                              //                                       names!,
                                              //                                       style: const TextStyle(
                                              //                                         fontWeight: FontWeight.bold,
                                              //                                         fontSize: 17,
                                              //                                       ),
                                              //                                     ),
                                              //                                     Text(
                                              //                                       phoneno!,
                                              //                                       style: const TextStyle(
                                              //                                         color: Colors.grey,
                                              //                                         fontSize: 15,
                                              //                                       ),
                                              //                                     ),
                                              //                                   ],
                                              //                                 ),
                                              //                               ],
                                              //                             ),
                                              //                             Column(
                                              //                               crossAxisAlignment:
                                              //                                   CrossAxisAlignment.end,
                                              //                               children: [
                                              //                                 Text(
                                              //                                   DateFormat('hh:mm a').format(DateTime.now()),
                                              //                                   style: const TextStyle(
                                              //                                     fontWeight: FontWeight.bold,
                                              //                                     fontSize: 17,
                                              //                                   ),
                                              //                                 ),
                                              //                                 Container(
                                              //                                   height: 20,
                                              //                                   width: 20,
                                              //                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.red),
                                              //                                   child: const Center(
                                              //                                     child: Text(
                                              //                                       '1',
                                              //                                       style: TextStyle(color: Colors.white),
                                              //                                     ),
                                              //                                   ),
                                              //                                 )
                                              //                               ],
                                              //                             ),
                                              //                           ],
                                              //                         ),
                                              //                       ),
                                              //                     ),
                                              //                   ),
                                              //                 ],
                                              //               ),
                                              //             );
                                              //           },
                                              //         ),
                                              //       )
                                              //     : Flexible(
                                              //         child: ListView.builder(
                                              //           itemCount: logic
                                              //               .resultList1.length,
                                              //           itemBuilder:
                                              //               (ctx, int index) {
                                              //             var names = logic
                                              //                     .resultList1[
                                              //                 index]['name'];
                                              //             var image =
                                              //                 logic.resultList1[
                                              //                         index][
                                              //                     'profilePic'];
                                              //             var phoneno = logic
                                              //                 .resultList1[
                                              //                     index]
                                              //                     ['phone']
                                              //                 .toString();
                                              //             return Padding(
                                              //               padding:
                                              //                   const EdgeInsets
                                              //                           .only(
                                              //                       bottom: 10),
                                              //               child: Column(
                                              //                 children: [
                                              //                   GestureDetector(
                                              //                     onTap: () {
                                              //                       Get.toNamed(
                                              //                           RoutesClass
                                              //                               .getChat(),
                                              //                           arguments: [
                                              //                             names,
                                              //                             image,
                                              //                           ]);
                                              //                     },
                                              //                     child:
                                              //                         Container(
                                              //                       height: 70,
                                              //                       width:
                                              //                           Get.width -
                                              //                               30,
                                              //                       decoration: BoxDecoration(
                                              //                           color: context
                                              //                               .theme
                                              //                               .cardColor,
                                              //                           borderRadius:
                                              //                               BorderRadius.circular(20)),
                                              //                       child:
                                              //                           Padding(
                                              //                         padding: const EdgeInsets
                                              //                                 .only(
                                              //                             left:
                                              //                                 10.0,
                                              //                             right:
                                              //                                 10,
                                              //                             top:
                                              //                                 10,
                                              //                             bottom:
                                              //                                 10),
                                              //                         child:
                                              //                             Row(
                                              //                           mainAxisAlignment:
                                              //                               MainAxisAlignment.spaceBetween,
                                              //                           children: [
                                              //                             Row(
                                              //                               children: [
                                              //                                 Container(
                                              //                                   height: 50,
                                              //                                   width: 50,
                                              //                                   decoration: BoxDecoration(
                                              //                                     color: Colors.black,
                                              //                                     image: DecorationImage(
                                              //                                       image: NetworkImage(image),
                                              //                                     ),
                                              //                                     borderRadius: BorderRadius.circular(100),
                                              //                                   ),
                                              //                                 ),
                                              //                                 const SizedBox(
                                              //                                   width: 10,
                                              //                                 ),
                                              //                                 Column(
                                              //                                   crossAxisAlignment: CrossAxisAlignment.start,
                                              //                                   children: [
                                              //                                     Text(
                                              //                                       names!,
                                              //                                       style: const TextStyle(
                                              //                                         fontWeight: FontWeight.bold,
                                              //                                         fontSize: 17,
                                              //                                       ),
                                              //                                     ),
                                              //                                     Text(
                                              //                                       phoneno,
                                              //                                       style: const TextStyle(
                                              //                                         color: Colors.grey,
                                              //                                         fontSize: 15,
                                              //                                       ),
                                              //                                     ),
                                              //                                   ],
                                              //                                 ),
                                              //                               ],
                                              //                             ),
                                              //                             Column(
                                              //                               crossAxisAlignment:
                                              //                                   CrossAxisAlignment.end,
                                              //                               children: [
                                              //                                 Text(
                                              //                                   DateFormat('hh:mm a').format(DateTime.now()),
                                              //                                   style: const TextStyle(
                                              //                                     fontWeight: FontWeight.bold,
                                              //                                     fontSize: 17,
                                              //                                   ),
                                              //                                 ),
                                              //                                 Container(
                                              //                                   height: 20,
                                              //                                   width: 20,
                                              //                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.red),
                                              //                                   child: const Center(
                                              //                                     child: Text(
                                              //                                       '1',
                                              //                                       style: TextStyle(color: Colors.white),
                                              //                                     ),
                                              //                                   ),
                                              //                                 )
                                              //                               ],
                                              //                             ),
                                              //                           ],
                                              //                         ),
                                              //                       ),
                                              //                     ),
                                              //                   ),
                                              //                 ],
                                              //               ),
                                              //             );
                                              //           },
                                              //         ),
                                              //       ),
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
                                child: const Center(
                                  child: Icon(
                                    Icons.chat,
                                    size: 30,
                                    // color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
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
                                        prefixInsets:
                                            const EdgeInsets.only(left: 10),
                                        borderRadius: BorderRadius.circular(20),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        onChanged: (value) {
                                          logic.searchUser();
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  logic.searchController.text.isEmpty
                                      ? Flexible(
                                          child: ListView.builder(
                                              itemCount: logic.users?.length,
                                              itemBuilder: (ctx, int index) {
                                                ProfileModelForChat myData =
                                                    logic.users![index];
                                                var names =
                                                    myData.name.toString();
                                                var image = myData.profilePic
                                                    .toString();
                                                var phoneno =
                                                    myData.phone.toString();
                                                var id = myData.id.toString();
                                                var loginUserId =
                                                    Constants.userId;
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          api.userTyping(
                                                              Constants.userId,
                                                              id,
                                                              Typing(
                                                                  senderId:
                                                                      Constants
                                                                          .userId,
                                                                  receiverId:
                                                                      id,
                                                                  isTyping:
                                                                      false));
                                                          Get.toNamed(
                                                              RoutesClass
                                                                  .getChat(),
                                                              arguments: [
                                                                names,
                                                                image,
                                                                id,
                                                                loginUserId
                                                              ]);
                                                        },
                                                        child: Container(
                                                          height: 70,
                                                          width: Get.width - 30,
                                                          decoration: BoxDecoration(
                                                              color: context
                                                                  .theme
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
                                                                    bottom: 5),
                                                            child:
                                                                StreamBuilder(
                                                                    stream: api.getLastMessage(
                                                                        id,
                                                                        Constants
                                                                            .userId
                                                                            .toString()),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                              .connectionState ==
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return const Text(
                                                                            'loading');
                                                                      }
                                                                      return Row(
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
                                                                                    image: NetworkImage(image ?? ''),
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(100),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        names ?? '',
                                                                                        style: const TextStyle(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontSize: 17,
                                                                                        ),
                                                                                      ),
                                                                                      id == loginUserId
                                                                                          ? const Text(
                                                                                              '(you)',
                                                                                              style: TextStyle(
                                                                                                fontWeight: FontWeight.bold,
                                                                                                fontSize: 17,
                                                                                              ),
                                                                                            )
                                                                                          : const Text(''),
                                                                                    ],
                                                                                  ),
                                                                                  snapshot.data!.docs.isNotEmpty
                                                                                      ? Wrap(
                                                                                          crossAxisAlignment: WrapCrossAlignment.center,
                                                                                          children: [
                                                                                            snapshot.data?.docs.last['senderId'] == Constants.userId
                                                                                                ? snapshot.data?.docs.last['read'] == false
                                                                                                    ? const Icon(Icons.done, size: 20)
                                                                                                    : const Icon(
                                                                                                        Icons.done_all,
                                                                                                        size: 20,
                                                                                                        color: Color(0xFF024DFC),
                                                                                                      )
                                                                                                : const Text(''),
                                                                                            const SizedBox(
                                                                                              width: 5,
                                                                                            ),
                                                                                            snapshot.data!.docs.last['message'].toString().isNotEmpty?
                                                                                            Container(width: Get.width-210,child: Text(snapshot.data?.docs.last['message'].toString() ?? '',overflow: TextOverflow.ellipsis,)):Icon(Icons.mic,size: 22,)
                                                                                          ],
                                                                                        )
                                                                                      : const Text('')
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          snapshot.data!.docs.isNotEmpty
                                                                              ? Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    id == id
                                                                                        ? Text(
                                                                                            formatTimestamp(snapshot.data?.docs.last['timestamp'] ?? ''),
                                                                                            style: const TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              fontSize: 13,
                                                                                            ),
                                                                                          )
                                                                                        : Container(),
                                                                                    snapshot.data!.docs.last['receiverId'] == Constants.userId
                                                                                        ? snapshot.data!.docs.last['read'] == false
                                                                                            ? StreamBuilder(
                                                                                                stream: api.getUnreadMessage(id, Constants.userId),
                                                                                                builder: (context, snapshot) {
                                                                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                                    return const Center(
                                                                                                      child: CircularProgressIndicator(),
                                                                                                    );
                                                                                                  }
                                                                                                  return Container(
                                                                                                    height: 25,
                                                                                                    width: 25,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: const Color(0xFF024DFC),
                                                                                                      borderRadius: BorderRadius.circular(50),
                                                                                                    ),
                                                                                                    child: Center(
                                                                                                      child: Text(
                                                                                                        snapshot.data.toString(),
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                              )
                                                                                            : Container()
                                                                                        : Container()
                                                                                  ],
                                                                                )
                                                                              : Container()
                                                                        ],
                                                                      );
                                                                    }),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }))

                                      // Flexible(
                                      //     child: StreamBuilder(
                                      //       stream: logic.userGetRef,
                                      //       builder: (context, snapshot) {
                                      //         if (snapshot.connectionState ==
                                      //             ConnectionState.waiting) {
                                      //           return const Center(
                                      //               child:
                                      //               CircularProgressIndicator());
                                      //         }
                                      //         return ListView.builder(
                                      //           itemCount:
                                      //           snapshot.data?.docs.length,
                                      //           itemBuilder: (ctx, int index) {
                                      //             var names = snapshot
                                      //                 .data?.docs[index]['name']
                                      //                 .toString();
                                      //             var image = snapshot.data
                                      //                 ?.docs[index]['profilePic']
                                      //                 .toString();
                                      //             var phoneno = snapshot
                                      //                 .data?.docs[index]['phone']
                                      //                 .toString();
                                      //             var id = snapshot
                                      //                 .data?.docs[index]['id'];
                                      //             var loginUserId =
                                      //                 Constants.userId;
                                      //             return Padding(
                                      //               padding:
                                      //               const EdgeInsets.only(
                                      //                   bottom: 10),
                                      //               child: Column(
                                      //                 children: [
                                      //                   GestureDetector(
                                      //                     onTap: () async {
                                      //                       Get.toNamed(
                                      //                           RoutesClass
                                      //                               .getChat(),
                                      //                           arguments: [
                                      //                             names,
                                      //                             image,
                                      //                             id,
                                      //                             loginUserId
                                      //                           ]);
                                      //                     },
                                      //                     child: Container(
                                      //                       height: 70,
                                      //                       width: Get.width - 30,
                                      //                       decoration: BoxDecoration(
                                      //                           color: context
                                      //                               .theme
                                      //                               .cardColor,
                                      //                           borderRadius:
                                      //                           BorderRadius
                                      //                               .circular(
                                      //                               20)),
                                      //                       child: Padding(
                                      //                         padding:
                                      //                         const EdgeInsets
                                      //                             .only(
                                      //                             left: 10.0,
                                      //                             right: 10,
                                      //                             top: 10,
                                      //                             bottom: 5),
                                      //                         child:
                                      //                         StreamBuilder(
                                      //                             stream: api.getLastMessage(
                                      //                                 id,
                                      //                                 Constants
                                      //                                     .userId
                                      //                                     .toString()),
                                      //                             builder:
                                      //                                 (context,
                                      //                                 snapshot) {
                                      //                               if (snapshot
                                      //                                   .connectionState ==
                                      //                                   ConnectionState
                                      //                                       .waiting) {
                                      //                                 return const Text(
                                      //                                     'loading');
                                      //                               }
                                      //                               return Row(
                                      //                                 mainAxisAlignment:
                                      //                                 MainAxisAlignment.spaceBetween,
                                      //                                 children: [
                                      //                                   Row(
                                      //                                     children: [
                                      //                                       Container(
                                      //                                         height: 50,
                                      //                                         width: 50,
                                      //                                         decoration: BoxDecoration(
                                      //                                           color: Colors.black,
                                      //                                           image: DecorationImage(
                                      //                                             image: NetworkImage(image ?? ''),
                                      //                                           ),
                                      //                                           borderRadius: BorderRadius.circular(100),
                                      //                                         ),
                                      //                                       ),
                                      //                                       const SizedBox(
                                      //                                         width: 10,
                                      //                                       ),
                                      //                                       Column(
                                      //                                         crossAxisAlignment: CrossAxisAlignment.start,
                                      //                                         children: [
                                      //                                           Row(
                                      //                                             children: [
                                      //                                               Text(
                                      //                                                 names ?? '',
                                      //                                                 style: const TextStyle(
                                      //                                                   fontWeight: FontWeight.bold,
                                      //                                                   fontSize: 17,
                                      //                                                 ),
                                      //                                               ),
                                      //                                               id == loginUserId
                                      //                                                   ? const Text(
                                      //                                                 '(you)',
                                      //                                                 style: TextStyle(
                                      //                                                   fontWeight: FontWeight.bold,
                                      //                                                   fontSize: 17,
                                      //                                                 ),
                                      //                                               )
                                      //                                                   : const Text('')
                                      //                                             ],
                                      //                                           ),
                                      //                                           snapshot.data!.docs.isNotEmpty
                                      //                                               ? Wrap(
                                      //                                             crossAxisAlignment: WrapCrossAlignment.center,
                                      //                                             children: [
                                      //                                               snapshot.data?.docs.last['senderId'] == Constants.userId
                                      //                                                   ? snapshot.data?.docs.last['read'] == false
                                      //                                                   ? const Icon(Icons.done, size: 20)
                                      //                                                   : const Icon(
                                      //                                                 Icons.done_all,
                                      //                                                 size: 20,
                                      //                                                 color: Color(0xFF024DFC),
                                      //                                               )
                                      //                                                   : const Text(''),
                                      //                                               const SizedBox(
                                      //                                                 width: 5,
                                      //                                               ),
                                      //                                               Text(snapshot.data?.docs.last['message'].toString() ?? '')
                                      //                                             ],
                                      //                                           )
                                      //                                               : const Text('')
                                      //                                         ],
                                      //                                       ),
                                      //                                     ],
                                      //                                   ),
                                      //                                   snapshot.data!.docs.isNotEmpty
                                      //                                       ? Column(
                                      //                                     mainAxisAlignment: MainAxisAlignment.center,
                                      //                                     crossAxisAlignment: CrossAxisAlignment.end,
                                      //                                     children: [
                                      //                                       id == id
                                      //                                           ? Text(
                                      //                                         formatTimestamp(snapshot.data?.docs.last['timestamp'] ?? ''),
                                      //                                         style: const TextStyle(
                                      //                                           fontWeight: FontWeight.bold,
                                      //                                           fontSize: 13,
                                      //                                         ),
                                      //                                       )
                                      //                                           : Container(),
                                      //                                       snapshot.data!.docs.last['receiverId'] == Constants.userId
                                      //                                           ? snapshot.data!.docs.last['read'] == false
                                      //                                           ? StreamBuilder(
                                      //                                         stream: api.getUnreadMessage(id, Constants.userId),
                                      //                                         builder: (context, snapshot) {
                                      //                                           if (snapshot.connectionState == ConnectionState.waiting) {
                                      //                                             return const Center(
                                      //                                               child: CircularProgressIndicator(),
                                      //                                             );
                                      //                                           }
                                      //                                           return Container(
                                      //                                             height: 25,
                                      //                                             width: 25,
                                      //                                             decoration: BoxDecoration(
                                      //                                               color: const Color(0xFF024DFC),
                                      //                                               borderRadius: BorderRadius.circular(50),
                                      //                                             ),
                                      //                                             child: Center(
                                      //                                               child: Text(
                                      //                                                 snapshot.data.toString(),
                                      //                                               ),
                                      //                                             ),
                                      //                                           );
                                      //                                         },
                                      //                                       )
                                      //                                           : Container()
                                      //                                           : Container()
                                      //                                     ],
                                      //                                   )
                                      //                                       : Container()
                                      //                                 ],
                                      //                               );
                                      //                             }),
                                      //                       ),
                                      //                     ),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             );
                                      //           },
                                      //         );
                                      //       },
                                      //     ))
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
                                              var id = logic.resultList[index]
                                                      ['id']
                                                  .toString();
                                              var loginUserId =
                                                  Constants.userId;
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        Get.toNamed(
                                                            RoutesClass
                                                                .getChat(),
                                                            arguments: [
                                                              names,
                                                              image,
                                                              id,
                                                              loginUserId
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
                                                                  bottom: 5),
                                                          child: StreamBuilder(
                                                              stream: api
                                                                  .getLastMessage(
                                                                      id,
                                                                      Constants
                                                                          .userId
                                                                          .toString()),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return const Text(
                                                                      'loading');
                                                                }

                                                                return Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.black,
                                                                            image:
                                                                                DecorationImage(
                                                                              image: NetworkImage(image ?? ''),
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(100),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  names ?? '',
                                                                                  style: const TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 17,
                                                                                  ),
                                                                                ),
                                                                                id == loginUserId
                                                                                    ? const Text(
                                                                                        '(you)',
                                                                                        style: TextStyle(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontSize: 17,
                                                                                        ),
                                                                                      )
                                                                                    : const Text('')
                                                                              ],
                                                                            ),
                                                                            snapshot.data!.docs.isNotEmpty
                                                                                ? Wrap(
                                                                                    crossAxisAlignment: WrapCrossAlignment.center,
                                                                                    children: [
                                                                                      snapshot.data?.docs.last['senderId'] == Constants.userId
                                                                                          ? snapshot.data?.docs.last['read'] == false
                                                                                              ? const Icon(Icons.done, size: 20)
                                                                                              : const Icon(
                                                                                                  Icons.done_all,
                                                                                                  size: 20,
                                                                                                  color: Color(0xFF024DFC),
                                                                                                )
                                                                                          : const Text(''),
                                                                                      const SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      Text(snapshot.data?.docs.last['message'].toString() ?? '')
                                                                                    ],
                                                                                  )
                                                                                : const Text('')
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    snapshot
                                                                            .data!
                                                                            .docs
                                                                            .isNotEmpty
                                                                        ? Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.end,
                                                                            children: [
                                                                              id == id
                                                                                  ? Text(
                                                                                      formatTimestamp(snapshot.data?.docs.last['timestamp'] ?? ''),
                                                                                      style: const TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 13,
                                                                                      ),
                                                                                    )
                                                                                  : Container(),
                                                                              snapshot.data!.docs.last['receiverId'] == Constants.userId
                                                                                  ? snapshot.data!.docs.last['read'] == false
                                                                                      ? StreamBuilder(
                                                                                          stream: api.getUnreadMessage(id, Constants.userId),
                                                                                          builder: (context, snapshot) {
                                                                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                              return const Center(
                                                                                                child: CircularProgressIndicator(),
                                                                                              );
                                                                                            }
                                                                                            return Container(
                                                                                              height: 25,
                                                                                              width: 25,
                                                                                              decoration: BoxDecoration(
                                                                                                color: const Color(0xFF024DFC),
                                                                                                borderRadius: BorderRadius.circular(50),
                                                                                              ),
                                                                                              child: Center(
                                                                                                child: Text(
                                                                                                  snapshot.data.toString(),
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        )
                                                                                      : Container()
                                                                                  : Container()
                                                                            ],
                                                                          )
                                                                        : Container()
                                                                  ],
                                                                );
                                                              }),
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
                                        prefixInsets:
                                            const EdgeInsets.only(left: 10),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
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
                                                            child: const Center(
                                                              child: Image(
                                                                image: AssetImage(
                                                                    'assets/images/Male Memojis.png'),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Column(
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
                                                            style:
                                                                const TextStyle(
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
                                                            child: const Center(
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

  String formatTimestamp(Timestamp timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final dateTime = timestamp.toDate();

    return dateTime.isAfter(today)
        ? DateFormat('hh:mm a').format(dateTime)
        : dateTime.isAfter(yesterday)
            ? 'Yesterday'
            : DateFormat('MM/dd/yyyy').format(dateTime);
  }
}
