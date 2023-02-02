import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ListChatController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? _currentUser;

  Stream<QuerySnapshot<Map<String, dynamic>>> chatdata() {
    String? email = auth.currentUser!.email;

    Query<Map<String, dynamic>> users = firestore
        .collection("users")
        .doc(email)
        .collection("chats")
        .orderBy("lastTime", descending: true);
    return users.snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> friendStream(String email) {
    return firestore.collection('users').doc(email).snapshots();
  }

  void goToChatRoom(String chat_id, String email, String friendEmail) async {
    CollectionReference chats = firestore.collection('chats');
    CollectionReference users = firestore.collection('users');

    String? email1 = auth.currentUser!.email;

    final updateStatusChat = await chats
        .doc(chat_id)
        .collection("chat")
        .where("isRead", isEqualTo: false)
        .where("penerima", isEqualTo: email)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chat_id)
          .collection("chat")
          .doc(element.id)
          .update({"isRead": true});
    });

    await users
        .doc(email1)
        .collection("chats")
        .doc(chat_id)
        .update({"total_unread": 0});

    Get.toNamed(
      Routes.CHAT,
      arguments: {
        "chat_id": chat_id,
        "friendEmail": friendEmail,
      },
    );
  }
}
