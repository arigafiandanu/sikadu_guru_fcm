import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../controllers/pengumuman_kelas_controller.dart';

class PengumumanKelasView extends GetView<PengumumanKelasController> {
  const PengumumanKelasView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Pengumuman Kelas',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamPengumuman(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            var data = snapshot.data!.docs;
            if (data.isEmpty) {
              return Column(
                children: [
                  SizedBox(
                    height: Get.height / 4,
                  ),
                  Center(
                    child: SizedBox(
                      height: Get.height / 3,
                      width: Get.width,
                      child: Lottie.asset(
                        "assets/lottie/list_pengumuman_kosong.json",
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Belum ada pengumuman baru",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              );
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var isiData = data[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            Routes.DETAIL_PENGUMUMAN,
                            arguments: isiData,
                          );
                        },
                           onLongPress: () {
                        Get.defaultDialog(
                          title: "Hapus Pengumuman ini ?",
                          middleText: "Pengumuman yang sudah dihapus tidak bisa dikembalikan",
                          textCancel: "Batal",
                          textConfirm: "Hapus",
                          onCancel: () {
                            Get.back();
                          },
                          onConfirm: () {
                            controller.deteteDocument(isiData['id']);
                          }
                        );
                      },
                        borderRadius: BorderRadius.circular(10),
                        focusColor: Colors.green[100],
                        splashColor: Colors.green[150],
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade100),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 10, top: 10),
                                alignment: Alignment.center,
                                width: Get.width / 7.5,
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  isiData['kategori'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                width: Get.width * 0.8,
                                height: Get.height * 0.075,
                                child: Text(
                                  "${isiData['judul']}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  (DateFormat.yMMMMd().format(
                                      DateTime.parse(isiData['tanggalBuat']))),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(
              child: Text("data error"),
            );
          }
        },
      ),
    );
  }
}
