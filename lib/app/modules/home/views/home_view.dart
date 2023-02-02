import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../../../style/textStyle.dart';
import '../../../widget/cardBesarW.dart';
import '../../../widget/cardButtonW.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(
              top: true,
              left: true,
              right: true,
              child: Container(),
            ),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.streamUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  Map<String, dynamic>? dataUser = snapshot.data!.data();
                  return Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Hallo, ${dataUser?['nama']}",
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Text(
                                    "Bagaimana Keadaan siswa hari ini ?",
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              ClipOval(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.biruTerang,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: dataUser?['foto'] != "foto kosong"
                                      ? Image.network(
                                          dataUser?['foto'],
                                          fit: BoxFit.cover,
                                        )
                                      : Lottie.asset(
                                          "assets/lottie/avatar.json",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Data Gagal Dimuat"),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                width: Get.width,
                height: Get.height * 0.02,
                child: const Text(
                  "Dashboard Guru",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              height: Get.height * 0.5,
              width: Get.width,
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                padding: const EdgeInsets.all(15),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  cardhomepage(
                    ontap: () {
                      Get.toNamed(Routes.BUAT_PENGUMUMAN);
                    },
                    warnaTerang: AppColors.grayshade,
                    warna: AppColors.lightblue,
                    icon: const Icon(
                      Icons.new_releases_outlined,
                      size: 35,
                    ),
                    kategori: "Buat Pengumuman Baru",
                  ),
                  cardhomepage(
                    ontap: () {
                      Get.toNamed(Routes.LIHAT_SUSWA);
                    },
                    warnaTerang: AppColors.grayshade,
                    warna: AppColors.blue,
                    icon: const Icon(
                      Icons.person_pin_circle,
                      size: 35,
                    ),
                    kategori: "Lihat Siswa",
                  ),
                  // cardhomepage(
                  //   ontap: () {
                  //     Get.toNamed(Routes.ABSENSI_SISWA);
                  //   },
                  //   warnaTerang: AppColors.grayshade,
                  //   warna: AppColors.blue,
                  //   icon: const Icon(
                  //     Icons.co_present_outlined,
                  //     size: 35,
                  //   ),
                  //   kategori: "Absensi Siswa",
                  // ),
                  cardhomepage(
                    ontap: () {
                      Get.toNamed(Routes.NILAI_SISWA);
                    },
                    warnaTerang: AppColors.grayshade,
                    warna: AppColors.blue,
                    icon: const Icon(
                      Icons.poll_outlined,
                      size: 35,
                    ),
                    kategori: "Nilai Siswa",
                  ),
                   cardhomepage(
                    ontap: () {
                      Get.toNamed(Routes.PENGUMUMAN_KELAS);
                    },
                    warnaTerang: AppColors.grayshade,
                    warna: AppColors.blue,
                    icon: const Icon(
                      Icons.co_present_outlined,
                      size: 35,
                    ),
                    kategori: "Pengumuman Kelas",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: SizedBox(
                width: Get.width,
                height: Get.height * 0.02,
                child: const Text(
                  "Pengumuman",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot<Object?>>(
                stream: controller.streamJmlPengumuman(),
                builder: (context, snapshotPengumuman) {
                  if (snapshotPengumuman.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshotPengumuman.hasData) {
                    var jmlPengumuman = snapshotPengumuman.data!.docs.length;
                    return CardBesarW(
                      ontap: () {
                        Get.toNamed(Routes.LIST_PEGUMUMAN);
                      },
                      colorCard: (Colors.indigo[50])!,
                      splashColor: (Colors.indigoAccent.withAlpha(50)),
                      title: "Semua Pengumuman",
                      jumlahSiswa: "Info $jmlPengumuman",
                      icon: const Icon(
                        Icons.add_alert_rounded,
                        color: Colors.indigoAccent,
                        size: 40,
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("data pengumuan error"),
                    );
                  }
                }),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
