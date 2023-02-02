import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/auth_c_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/buttonW.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  ProfilView({Key? key}) : super(key: key);
  final AuthC = Get.put(AuthCController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            var user = snapshot.data!.data();
            return Column(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15),
                      width: 180,
                      height: 180,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: user!['foto'] != "foto kosong"
                            ? Image.network(
                                user['foto'],
                                fit: BoxFit.cover,
                              )
                            : Lottie.asset(
                                "assets/lottie/avatar.json",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Text(
                      "${user['nama'].toUpperCase()}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(
                    //   "${user['noTelp'].toUpperCase()}",
                    //   style: const TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.w300,
                    //   ),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Card(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  borderOnForeground: true,
                  color: Colors.white,
                  elevation: 2,
                  child: ListTile(
                    style: ListTileStyle.list,
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_PROFIL, arguments: user);
                    },
                    leading: const Icon(Icons.person),
                    title: const Text("profil"),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),
                Card(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  borderOnForeground: true,
                  color: Colors.white,
                  elevation: 2,
                  child: ListTile(
                    style: ListTileStyle.list,
                    onTap: () {
                      Get.toNamed(Routes.GANTI_PASSWORD);
                    },
                    leading: const Icon(Icons.key),
                    title: const Text("Ganti Password"),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonW(
                  onTap: () {
                    Get.defaultDialog(
                      onConfirm: () {
                        AuthC.logut();
                      },
                      textConfirm: "Logout",
                      onCancel: () {
                        Get.back();
                      },
                      textCancel: "Tidak",
                      confirmTextColor: Colors.white,
                      title: "Keluar aplikasi",
                      middleText: "Apakah kamu ingin keluar Aplikasi?",
                    );
                  },
                  text: "Logout",
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Data error"),
            );
          }
        },
      ),
    );
  }
}
