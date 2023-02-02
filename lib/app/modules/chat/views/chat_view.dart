import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sikadu_guru/app/routes/app_pages.dart';

import '../../../widget/ChatW.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  final String chat_id = (Get.arguments as Map<String, dynamic>)["chat_id"];

  ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: InkWell(
          onTap: () {
            Get.toNamed(Routes.DASHBOARD);
          },
          borderRadius: BorderRadius.circular(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 5,
              ),
              const Icon(Icons.arrow_back_rounded),
              const SizedBox(
                width: 5,
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: StreamBuilder<DocumentSnapshot<Object?>>(
                  stream: controller.streamFriendData(
                      (Get.arguments as Map<String, dynamic>)["friendEmail"]),
                  builder: (context, snapFriendUser) {
                    if (snapFriendUser.connectionState ==
                        ConnectionState.active) {
                      var dataFriend =
                          snapFriendUser.data!.data() as Map<String, dynamic>;
                      var dataEmail = (Get.arguments
                          as Map<String, dynamic>)["friendEmail"];
                      print(dataEmail);

                      if (dataFriend["foto"] == "foto kosong") {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Lottie.asset(
                            "assets/lottie/avatar.json",
                          ),
                        );
                      } else {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            dataFriend["foto"],
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Lottie.asset(
                        "assets/lottie/avatar.json",
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        title: StreamBuilder<DocumentSnapshot<Object?>>(
          stream: controller.streamFriendData(
              (Get.arguments as Map<String, dynamic>)["friendEmail"] ?? ""),
          builder: (context, snapFriendUser) {
            if (snapFriendUser.connectionState == ConnectionState.active) {
              var dataFriend =
                  snapFriendUser.data!.data() as Map<String, dynamic>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataFriend["nama"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          },
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.streamChats(chat_id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var alldata = snapshot.data!.docs;
                    Timer(
                      Duration.zero,
                      () => controller.scrollC
                          .jumpTo(controller.scrollC.position.maxScrollExtent),
                    );
                    return ListView.builder(
                      controller: controller.scrollC,
                      itemCount: alldata.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              SizedBox(height: 10),
                              Text(
                                "${alldata[index]["groupTime"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ItemChat(
                                msg: "${alldata[index]["msg"]}",
                                isSender: alldata[index]["pengirim"] ==
                                        controller.email as String
                                    ? true
                                    : false,
                                time: "${alldata[index]["time"]}",
                              ),
                            ],
                          );
                        } else {
                          if (alldata[index]["groupTime"] ==
                              alldata[index - 1]["groupTime"]) {
                            return ItemChat(
                              msg: "${alldata[index]["msg"]}",
                              isSender: alldata[index]["pengirim"] ==
                                      controller.email as String
                                  ? true
                                  : false,
                              time: "${alldata[index]["time"]}",
                            );
                          } else {
                            return Column(
                              children: [
                                Text(
                                  "${alldata[index]["groupTime"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ItemChat(
                                  msg: "${alldata[index]["msg"]}",
                                  isSender: alldata[index]["pengirim"] ==
                                          controller.email as String
                                      ? true
                                      : false,
                                  time: "${alldata[index]["time"]}",
                                ),
                              ],
                            );
                          }
                        }
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: Get.width,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: controller.chatC,
                      autocorrect: false,
                      onEditingComplete: () => controller.newChat(
                        controller.email as String,
                        Get.arguments as Map<String, dynamic>,
                        controller.chatC.text,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Material(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.blue.shade500,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      controller.newChat(
                        controller.email as String,
                        Get.arguments as Map<String, dynamic>,
                        controller.chatC.text,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
