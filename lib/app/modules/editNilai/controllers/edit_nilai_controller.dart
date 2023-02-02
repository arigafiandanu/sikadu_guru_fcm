import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditNilaiController extends GetxController {
  TextEditingController nilaiUts = TextEditingController();
  TextEditingController nilaiSemester = TextEditingController();
  TextEditingController catatanGuru = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  //function to add grade student and comment teacher
  Future<void> tambahNilaiSiswa(
      String semester, String email, String mataPelajaran) async {
    var waliKelas = await firestore
        .collection("Guru")
        .doc(auth.currentUser!.email)
        .get()
        .then((value) => value.data()?['mengajarKelas']);

    var siswa = firestore.collection("Siswa").doc(email);

    try {
      await siswa.set(
        {
          "nilai": {
            "$waliKelas": {
              semester: {
                mataPelajaran: {
                  "nilaiUts": int.tryParse(nilaiUts.text) ?? 0,
                  "nilaiSemester": int.tryParse(nilaiSemester.text) ?? 0,
                  "catatanGuru": catatanGuru.text
                }
              }
            }
          }
        },
        SetOptions(merge: true),
      );

      Get.back();
      Get.snackbar(
        "Berhasil",
        "Pelajaran berhasil ditambah",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
        borderRadius: 10,
        snackStyle: SnackStyle.FLOATING,
        icon: const Icon(
          Icons.donut_large,
          color: Colors.green,
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Gagal menambahkan Nilai Siswa",
        "Coba Berberapa saat lagi ",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        borderRadius: 10,
        snackStyle: SnackStyle.FLOATING,
        icon: const Icon(
          Icons.warning,
          color: Colors.red,
        ),
      );
    }
  }
}
