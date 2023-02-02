import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/userModel.dart';
import '../routes/app_pages.dart';


class AuthCController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  RxBool hidepass = true.obs;
  User? _currentUser;

  Stream<User?> get streamStatusAuth => auth.userChanges();

  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  static Future<void> getFirebaseMessage () async {
    NotificationSettings settings = await fMessaging.requestPermission(
                  alert: true,
                  announcement: true,
                  badge: true,
                  carPlay: false,
                  criticalAlert: false,
                  provisional: false,
                  sound: true,);

    log("User granted permission: ${settings.authorizationStatus}");
    await fMessaging.getToken().then((t) {
      log("token firebase: $t");
    });
  }

  @override
  void onInit() {
    super.onInit();
  }



  void lupaPass(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
            title: "Berhasil",
            middleText:
                "Berhasil megirimkan reset password ke $email , silahkan cek email anda",
            onConfirm: () {
              Get.back();
              Get.back();
            },
            textConfirm: "oke");
      } catch (e) {
        Get.defaultDialog(
          title: "terjadi kesalahan",
          middleText:
              "Tidak bisa mengirim verifikasi ulang, coba beberapa saat lagi",
        );
      }
    } else {
      Get.defaultDialog(
        title: "terjadi kesalahan",
        middleText: "Email belum terdaftar",
      );
    }
  }

  Future<void> login(String email, String password) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        UserCredential userlog = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        if (userlog.user!.emailVerified) {
          if (userlog != null) {
            _currentUser = FirebaseAuth.instance.currentUser;
            final userId = _currentUser?.email;

            await FirebaseFirestore.instance
                .collection("users")
                .doc(userId)
                .set( {
                  'token': await fMessaging.getToken(),
                }, SetOptions(merge: true));

            await FirebaseFirestore.instance
                .collection("users")
                .doc(userId)
                .get()
                .then((value) {
              if (value.data()?['role'] == 'Guru') {
                Get.offAllNamed(Routes.DASHBOARD);
                getFirebaseMessage();
                
              } else {
                Get.snackbar("bukan Guru",
                    "Silahkan hubungi admin untuk info lebih lanjut");
              }
            });
            // CollectionReference users = firestore.collection('users');
            // print("proses simpan di model");
            // final currUser = await users.doc(_currentUser?.email).get();
            // final currUserData = currUser.data() as Map<String, dynamic>;
            // print(currUserData);
          }
        } else {
          Get.defaultDialog(
            title: "verifikasi email",
            middleText:
                "silahkahkan verifikasi emaail dahulu sebelum login, apakah kamu ingin mengirim verifikasi ulang?",
            onConfirm: () async {
              await userlog.user!.sendEmailVerification();
              Get.back();
            },
            textConfirm: "kirim ulang",
            onCancel: () {
              Get.back();
            },
            textCancel: "kembali",
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.defaultDialog(
              title: "Akun Tidak ditemukan",
              middleText: "Silahkan melakukan pendaftaran akun",
              onConfirm: () => Get.back(),
              textConfirm: "oke");
        } else if (e.code == 'wrong-password') {
          Get.defaultDialog(
              title: "Password Salah",
              middleText: "Masukkan Password Yang Benar",
              onConfirm: () => Get.back(),
              textConfirm: "oke");
        }
      }
    } else {
      Get.snackbar("Email tidak valid", "masukkan email dengan benar");
    }
  }

  // Logout User

  void logut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN_PAGE);
  }


  //new chat

  void addNewChat(String friendEmail) async {
    _currentUser = FirebaseAuth.instance.currentUser;

    bool flagNewConnection = false;
    var chat_id;
    String date = DateTime.now().toIso8601String();
    CollectionReference chats = firestore.collection("chats");
    CollectionReference users = firestore.collection("users");

    final docChats =
        await users.doc(_currentUser!.email).collection("chats").get();

    if (docChats.docs.length != 0) {
      // user sudah pernah chat dengan siapapun
      final checkConnection = await users
          .doc(_currentUser!.email)
          .collection("chats")
          .where("connection", isEqualTo: friendEmail)
          .get();

      if (checkConnection.docs.isNotEmpty) {
        // sudah pernah buat koneksi dengan => friendEmail
        flagNewConnection = false;

        //chat_id from chats collection
        chat_id = checkConnection.docs[0].id;
      } else {
        // blm pernah buat koneksi dengan => friendEmail
        // buat koneksi ....
        flagNewConnection = true;
      }
    } else {
      // blm pernah chat dengan siapapun
      // buat koneksi ....
      flagNewConnection = true;
    }

    if (flagNewConnection) {
      // cek dari chats collection => connections => mereka berdua...
      final chatsDocs = await chats.where(
        "connections",
        whereIn: [
          [
            _currentUser!.email,
            friendEmail,
          ],
          [
            friendEmail,
            _currentUser!.email,
          ],
        ],
      ).get();

      if (chatsDocs.docs.isNotEmpty) {
        // terdapat data chats (sudah ada koneksi antara mereka berdua)
        final chatDataId = chatsDocs.docs[0].id;
        final chatsData = chatsDocs.docs[0].data() as Map<String, dynamic>;

        await users
            .doc(_currentUser!.email)
            .collection("chats")
            .doc(chatDataId)
            .set({
          "connection": friendEmail,
          "lastTime": chatsData["lastTime"],
          "total_unread": 0,
        });

        final listChats =
            await users.doc(_currentUser!.email).collection("chats").get();

        if (listChats.docs.isNotEmpty) {
          List<ChatUser> dataListChats = List<ChatUser>.empty(growable: true);
          for (var element in listChats.docs) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              total_unread: dataDocChat["total_unread"],
            ));
          }
          // .update((user) {
          //   useuserr!.chats = dataListChats;
          // });
        } 
        // else {
        //   user.update((user) {
        //     user!.chats = [];
        //   });
        // }

        chat_id = chatDataId;

        // user.refresh();
      } else {
        // buat baru , mereka berdua benar2 belum ada koneksi
        final newChatDoc = await chats.add({
          "connections": [
            _currentUser!.email,
            friendEmail,
          ],
        });

        chats.doc(newChatDoc.id).collection("chat");

        await users
            .doc(_currentUser!.email)
            .collection("chats")
            .doc(newChatDoc.id)
            .set({
          "connection": friendEmail,
          "lastTime": date,
          "total_unread": 0,
        });

        final listChats =
            await users.doc(_currentUser!.email).collection("chats").get();

        if (listChats.docs.isNotEmpty) {
          List<ChatUser> dataListChats = List<ChatUser>.empty(growable: true);
          for (var element in listChats.docs) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              total_unread: dataDocChat["total_unread"],
            ));
          }
          // user.update((user) {
          //   user!.chats = dataListChats;
          // });
        } 
        // else {
        //   user.update((user) {
        //     user!.chats = [];
        //   });
        // }

        chat_id = newChatDoc.id;

        // user.refresh();
      }
    }

    print(chat_id);

    final updateStatusChat = await chats
        .doc(chat_id)
        .collection("chat")
        .where("isRead", isEqualTo: false)
        .where("penerima", isEqualTo: _currentUser!.email)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chat_id)
          .collection("chat")
          .doc(element.id)
          .update({"isRead": true});
    });

    await users
        .doc(_currentUser!.email)
        .collection("chats")
        .doc(chat_id)
        .update({"total_unread": 0});

    var token = await FirebaseMessaging.instance.getToken();
    Get.toNamed(
      Routes.CHAT,
      arguments: {
        "chat_id": "$chat_id",
        "friendEmail": friendEmail,
        "token": token,
      },
    );
  }
}
