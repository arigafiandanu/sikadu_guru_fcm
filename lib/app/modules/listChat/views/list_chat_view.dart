import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/list_chat_controller.dart';

class ListChatView extends GetView<ListChatController> {
  const ListChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Material(
            elevation: 5,
            child: Container(
              margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(96, 161, 161, 161),
                  ),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Pesan Masuk",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Material(
                  //   borderRadius: BorderRadius.circular(30),
                  //   child: InkWell(
                  //     onTap: () {},
                  //     borderRadius: BorderRadius.circular(30),
                  //     child: const Padding(
                  //       padding: EdgeInsets.all(10.0),
                  //       child: Icon(
                  //         Icons.delete_sweep_rounded,
                  //         size: 25,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.chatdata(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  var listChat = snapshot.data!.docs;

                  if (listChat.isEmpty) {
                    return Center(
                      child: Container(
                        height: Get.height * 0.7,
                        width: Get.width * 0.7,
                        child: Lottie.asset(
                          "assets/lottie/empty.json",
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: listChat.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                          stream: controller
                              .friendStream(listChat[index]['connection']),
                          builder: (context, snapshot2) {
                            if (snapshot2.connectionState ==
                                ConnectionState.active) {
                              var data = snapshot2.data?.data();

                              return Card(
                                margin: const EdgeInsets.all(5),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  onTap: () => controller.goToChatRoom(
                                    listChat[index].id,
                                    data?['email'],
                                    listChat[index]["connection"],
                                  ),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: data?["foto"] == "foto kosong"
                                          ? Lottie.asset(
                                              "assets/lottie/avatar.json",
                                            )
                                          : Image.network(
                                              "${data?["foto"]}",
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  title: Text(
                                    "${data?["nama"]}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  trailing: listChat[index]["total_unread"] == 0
                                      ? SizedBox()
                                      : Chip(
                                          backgroundColor: Colors.green[900],
                                          label: Text(
                                            "${listChat[index]["total_unread"]}",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      },
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
