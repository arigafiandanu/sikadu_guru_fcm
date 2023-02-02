import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sikadu_guru/app/routes/app_pages.dart';

import '../controllers/nilai_siswa_controller.dart';

class NilaiSiswaView extends GetView<NilaiSiswaController> {
  const NilaiSiswaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Nilai Siswa",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot<Object?>>(
        future: controller.streamSiswa(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            var listData = snapshot.data!.docs;
            if (listData.isEmpty) {
              return const Center(
                child: Text("Belum ada siswa di ini"),
              );
            } else {
              return ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  var dataItem = listData[index].data() as Map<String, dynamic>;
                  return Card(
                    margin: const EdgeInsets.all(5),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      onTap: () {
                        Get.toNamed(Routes.MASUKKAN_NILAI, arguments: dataItem);
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: ClipRect(
                          child: dataItem['foto'] != 'foto kosong'
                              ? Image.network(
                                  dataItem['foto'],
                                  fit: BoxFit.cover,
                                )
                              : Lottie.asset(
                                  "assets/lottie/avatar.json",
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      title: Text(dataItem['nama']),
                      // subtitle: Text(dataItem['nip']),
                      trailing: const Icon(Icons.arrow_right),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(
              child: Text("error"),
            );
          }
        },
      ),
    );
  }
}
