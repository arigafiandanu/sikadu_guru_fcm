import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
 int total_unread = 0;
  User? _currentUser;
  var email = FirebaseAuth.instance.currentUser?.email;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late TextEditingController chatC;
  late ScrollController scrollC;

  void newChat(String email, Map<String, dynamic> argument, String chat) async {
    if (chat != "") {
      CollectionReference chats = firestore.collection("chats");
      CollectionReference users = firestore.collection("users");

      String date = DateTime.now().toIso8601String();

      await chats.doc(argument["chat_id"]).collection("chat").add({
        "pengirim": email,
        "penerima": argument["friendEmail"],
        "msg": chat,
        "time": date,
        "isRead": false,
        "groupTime": DateFormat.yMMMMd('en_US').format(DateTime.parse(date)),
      });

      Timer(
        Duration.zero,
        () => scrollC.jumpTo(scrollC.position.maxScrollExtent),
      );

      chatC.clear();
      String? tokens;
      await users
          .doc(argument['friendEmail'])
          .get().then((value) {log(value['token'].toString()); tokens = value['token'].toString();});
      

      

      await users
          .doc(email)
          .collection("chats")
          .doc(argument["chat_id"])
          .update({
        "lastTime": date,
      });

      final checkChatsFriend = await users
          .doc(argument["friendEmail"])
          .collection("chats")
          .doc(argument["chat_id"])
          .get();

      if (checkChatsFriend.exists) {
        // exist on friend DB
        // first check total unread
        final checkTotalUnread = await chats
            .doc(argument["chat_id"])
            .collection("chat")
            .where("isRead", isEqualTo: false)
            .where("pengirim", isEqualTo: email)
            .get();

        // total unread for friend
        total_unread = checkTotalUnread.docs.length;

        await users
            .doc(argument["friendEmail"])
            .collection("chats")
            .doc(argument["chat_id"])
            .update({"lastTime": date, "total_unread": total_unread});

        String namapengirim = 'null';
        await users.doc(email).get().then((value) => namapengirim = value['nama'].toString());
        final body = {
          "to":tokens,
          "notification":{
              "title": namapengirim,
              "body": chat
          }
        };
        
        var response = await post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader :'key=AAAAWagXVEs:APA91bH8J8gWqCq7QqbBBe-NeZtgdjrQ5Fr1WXjXZCsw31IgLdw6pOw6CjDlYnxn3M5x7F3yNaBlqTGzZLruVkiS4BVF6SqJLWwtubpuo_cyNypaDlslNDHuBT8HGPEiKIitCqJTAur8'
        },
            body: jsonEncode(body));
        
        log(response.body);

      } else {
        // not exist on friend DB
        await users
            .doc(argument["friendEmail"])
            .collection("chats")
            .doc(argument["chat_id"])
            .set({
          "connection": email,
          "lastTime": date,
          "total_unread": 1,
        });
      }
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamChats(String chat_id) {
    CollectionReference chats = firestore.collection("chats");

    return chats.doc(chat_id).collection("chat").orderBy("time").snapshots();
  }

  Stream<DocumentSnapshot<Object?>> streamFriendData(String friendEmail) {
    CollectionReference users = firestore.collection("users");

    return users.doc(friendEmail).snapshots();
  }

  @override
  void onInit() {
    chatC = TextEditingController();
    scrollC = ScrollController();
    super.onInit();
  }

  @override
  void onClose() {
    chatC.dispose();
    scrollC.dispose();
    super.onClose();
  }
}
