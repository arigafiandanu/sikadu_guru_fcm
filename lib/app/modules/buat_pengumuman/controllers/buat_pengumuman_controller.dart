import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class BuatPengumumanController extends GetxController {
  TextEditingController judulC = TextEditingController();
  TextEditingController isiC = TextEditingController();

  var kategoriP = "Umum".obs;
  var kategoriPenerima = "Semua".obs;
  List dataPengumuman = ["Umum", "Pembayaran", "Libur", "Akademik"];
  List dataPenerimaPengumuman = ["Kelas 1", "Kelas 2", "Kelas 3", "Kelas 4", "Kelas 5", "Kelas 6", "Semua"];
  final ImagePicker picker = ImagePicker();
  List<XFile> imageList = [];
  List<String> downloadUrl = [];

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> tambahPengumuman() async {
    if (judulC.text.isNotEmpty && isiC.text.isNotEmpty) {
      DocumentReference<Map<String, dynamic>> pengumuman =
          firestore.collection("pengumuman").doc();
      var email = auth.currentUser!.email;
      String? namaUser = (await firestore
          .collection("users")
          .doc(email)
          .get()
          .then((value) => value.data()?['nama'])) as String?;
      try {
        for (int i = 0; i < imageList.length; i++) {
          var data = await uplodImage(imageList[i]);
          downloadUrl.add(data.toString());
        }

        pengumuman.set(
          {
            "id": pengumuman.id,
            "judul": judulC.text,
            "isi": isiC.text,
            "pembuat": namaUser,
            "kategori": kategoriP.value,
            "kategoriPenerima": kategoriPenerima.value,
            "fotoPengumuman": downloadUrl,
            "tanggalBuat": DateTime.now().toIso8601String(),
          },
        );
        final juduls = judulC.text;
        final isis = isiC.text;
        if (kategoriPenerima.value == "Semua") {
          
          await firestore.collection('users').get().then((value) async {
            
            value.docs.forEach((element) async {
              log (element['role']);

              await firestore
                  .collection('users')
                  .doc(element['email'])
                  .get()
                  .then((value) async {
                    log("${element['email']} isinya");
                    log(value.data()?['token'].toString() ?? 'null');

                    String? tokens =
                        value.data()?['token'].toString() ?? 'null';

                    if (tokens == 'null') {
                      return;
                    }

                    final body = {
                      "to": tokens,
                      "notification": {
                        "title": "Pengumuman baru",
                        "body": juduls
                      }
                };

                var response = await post(
                    Uri.parse("https://fcm.googleapis.com/fcm/send"),
                    headers: {
                      HttpHeaders.contentTypeHeader: 'application/json',
                      HttpHeaders.authorizationHeader:
                          'key=AAAAWagXVEs:APA91bH8J8gWqCq7QqbBBe-NeZtgdjrQ5Fr1WXjXZCsw31IgLdw6pOw6CjDlYnxn3M5x7F3yNaBlqTGzZLruVkiS4BVF6SqJLWwtubpuo_cyNypaDlslNDHuBT8HGPEiKIitCqJTAur8'
                    },
                    body: jsonEncode(body));

                log(response.body.toString());
              });
            });
          });
        } else if (kategoriPenerima.value != "Semua"){
          await firestore.collection('Siswa').get().then((value) async {
            
            value.docs.forEach((element) async {
              if (element['kelas'] != kategoriPenerima.value) {
                return;
              }
        
            await firestore.collection('users').doc(element['email']).get().then((value) async {
              log("${element['email']} isinya");
              log(value.data()?['token'].toString() ?? 'null');

              String? tokens = value.data()?['token'].toString() ?? 'null';

              if (tokens == 'null') {
                return;
              }

              final body = {
                "to":tokens,
                "notification":{
                    "title": "Pengumuman baru",
                    "body": juduls
                }
              };
              
              var response = await post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
              headers: {
                      HttpHeaders.contentTypeHeader: 'application/json',
                      HttpHeaders.authorizationHeader:
                          'key=AAAAWagXVEs:APA91bH8J8gWqCq7QqbBBe-NeZtgdjrQ5Fr1WXjXZCsw31IgLdw6pOw6CjDlYnxn3M5x7F3yNaBlqTGzZLruVkiS4BVF6SqJLWwtubpuo_cyNypaDlslNDHuBT8HGPEiKIitCqJTAur8'
              },
              body: jsonEncode(body));

              log(response.body.toString());
            });
          });
        });
        }

        // await firestore.collection('Siswa').get().then((value) async {
        //   value.docs.forEach((element) async {
        
        //   await firestore.collection('users').doc(element['email']).get().then((value) async {
        //     log("${element['email']} isinya");
        //     log(value.data()?['token'].toString() ?? 'null');

        //     String? tokens = value.data()?['token'].toString() ?? 'null';

        //     if (tokens == 'null') {
        //       return;
        //     }

        //     final body = {
        //       "to":tokens,
        //       "notification":{
        //           "title": "coba pengumuman broadcast",
        //           "body": "isi"
        //       }
        //     };
            
        //     var response = await post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
        //     headers: {
        //             HttpHeaders.contentTypeHeader: 'application/json',
        //             HttpHeaders.authorizationHeader :'key=AAAAWagXVEs:APA91bH8J8gWqCq7QqbBBe-NeZtgdjrQ5Fr1WXjXZCsw31IgLdw6pOw6CjDlYnxn3M5x7F3yNaBlqTGzZLruVkiS4BVF6SqJLWwtubpuo_cyNypaDlslNDHuBT8HGPEiKIitCqJTAur8'
        //           },
        //               body: jsonEncode(body));
                  
        //           log(response.body.toString());
        //         });
        //       });
        //   });

        judulC.clear();
        isiC.clear();

        Get.back();
        Get.snackbar(
          "Berhasil",
          "Pengumuman berhasil dibuat",
          snackPosition: SnackPosition.TOP,
          borderRadius: 10,
          snackStyle: SnackStyle.FLOATING,
          icon: const Icon(
            Icons.donut_large,
            color: Colors.green,
          ),
        );
      } catch (e) {
        Get.snackbar(
          "Gagal membuat pengumuman",
          "Coba Berberapa saat lagi ",
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          snackStyle: SnackStyle.FLOATING,
          icon: const Icon(
            Icons.warning,
            color: Colors.red,
          ),
        );
      }
    } else {
      Get.snackbar(
        "Gagal Menambah kan Pengumuman",
        "Pastikan semua terisi",
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10,
        snackStyle: SnackStyle.FLOATING,
        icon: const Icon(
          Icons.warning,
          color: Colors.red,
        ),
      );
    }
  }

  void pickMultiImage() async {
    imageList = (await picker.pickMultiImage()).cast<XFile>();

    if (imageList.isEmpty) {
      return;
    } else {
      update();
    }
  }

  Future<String> uplodImage(XFile image) async {
    var idUser = auth.currentUser!;

    String? user = (await firestore
        .collection("users")
        .doc(idUser.email)
        .get()
        .then((value) => value.data()?['nama'])) as String?;
    final imgTime = DateTime.now().millisecondsSinceEpoch.toString();
    final imgName = image.name;
    File file = File(image.path);

    await storage.ref("pengumuman/$user/$imgTime+$imgName").putFile(file);
    return await storage
        .ref("pengumuman/$user/$imgTime+$imgName")
        .getDownloadURL();
  }
}
