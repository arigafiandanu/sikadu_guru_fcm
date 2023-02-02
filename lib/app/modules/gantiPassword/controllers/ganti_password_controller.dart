import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GantiPasswordController extends GetxController {
  RxBool hidePassword = true.obs;
  RxBool isLoading = false.obs;
  TextEditingController passC = TextEditingController();
  TextEditingController newPassC = TextEditingController();
  TextEditingController conNewPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePass() async {
    if (passC.text.isNotEmpty &&
        newPassC.text.isNotEmpty &&
        conNewPassC.text.isNotEmpty) {
      if (newPassC.text == conNewPassC.text) {
        isLoading.value = true;
        try {
          String? emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: emailUser, password: passC.text);

          await auth.currentUser!.updatePassword(newPassC.text);
          Get.back();
          Get.snackbar("Update Password berhasil",
              "Password baru telah berhasil diupdate");
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar("Terjadi Kesalahan", "Pasword yang dimasukkan salah");
          } else {
            Get.snackbar("Terjadi Kesalahan", e.code.toLowerCase());
          }
          Get.snackbar("Terjadi Kesalahan", "Tidak dapat Update Password");
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar("Password Tidak Sama", "Konfirmasi password tidak sama");
      }
    } else {
      Get.snackbar("Password Kosong", "Input Semua Data...");
    }
  }
}
