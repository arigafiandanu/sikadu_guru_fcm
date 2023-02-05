import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sikadu_guru/app/routes/app_pages.dart';

import '../controllers/masukkan_nilai_controller.dart';

class MasukkanNilaiView extends GetView<MasukkanNilaiController> {
  var dataSiswa = Get.arguments;

  List<Tab> myTab = const [
    Tab(
      text: "Semester 1",
    ),
    Tab(
      text: "Semester 2",
    )
  ];

  MasukkanNilaiView({Key? key}) : super(key: key);
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
        title: Text(
          'Nilai ${dataSiswa["nama"]}',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          DefaultTabController(
            length: myTab.length,
            child: Column(
              children: [
                TabBar(
                  tabs: myTab,
                  labelColor: Colors.black,
                ),
                SizedBox(
                  height: Get.height * 0.85,
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller.streamPelajaran(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Text("Waiting data lecture"),
                        );
                      }
                      if (snapshot.hasData) {
                        return StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                          stream: controller.streamGrade(),
                          builder: (context, snapshotGrade) {
                            if (snapshotGrade.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: Text("Waiting data Grade"),
                              );
                            }
                            if (snapshot.hasData) {
                              var dataPelajaran = snapshot.data!.docs;
                              var gradeData = snapshotGrade.data!;
                              var kelas = dataSiswa['kelas'];
                              var gradeMid =
                                  gradeData?['nilai'][kelas]?['semester 1'];

                              print(gradeMid);
                              print("isi grade middddddd");
                              var gradeFinal =
                                  gradeData?['nilai'][kelas]?['semester 2'];

                              return TabBarView(children: [
                                // Tab semester 1
                                Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            width: Get.width / 2,
                                            child: const Text(
                                              "Mata Pelajaran",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            width: Get.width / 5,
                                            child: const Text(
                                              "PTS",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            width: Get.width / 5,
                                            child: const Text(
                                              "PAS",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: Get.width / 10,
                                          )
                                        ],
                                      ),
                                    ),
                                    _inputGradeMid(
                                        dataPelajaran, gradeData, kelas)
                                  ],
                                ),

                                // tabbar semester 2
                                Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            width: Get.width / 2,
                                            child: const Text(
                                              "Mata Pelajaran",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            width: Get.width / 5,
                                            child: const Text(
                                              "PTS",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            width: Get.width / 5,
                                            child: const Text(
                                              "PAS",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: Get.width / 10,
                                          )
                                        ],
                                      ),
                                    ),
                                    _inputGradeFinal(
                                        dataPelajaran, gradeData, kelas)
                                  ],
                                ),
                              ]);
                            } else {
                              return const Center(
                                child: Text("Error data Grade"),
                              );
                            }
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("Error data lecture"),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _inputGradeFinal(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dataPelajaran,
      DocumentSnapshot<Map<String, dynamic>> gradeData,
      kelas) {
    return Expanded(
      child: ListView.builder(
        itemCount: dataPelajaran.length,
        itemBuilder: ((context, index) {
          var dataPelajaranIndex = dataPelajaran[index].data();
          var pelajaran = dataPelajaranIndex['pelajaran'];

          var grade = gradeData?['nilai'][kelas]?['semester 2']?[pelajaran];
          var pts = grade?['PTS'] ?? "0";
          var pas = grade?['PAS'] ?? "0";

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 250,
            color: Colors.blue.withOpacity(0.05),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 20,
                      ),
                      width: Get.width / 2,
                      child: Text(
                        "${dataPelajaranIndex['pelajaran']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      width: Get.width / 5,
                      child: Text(
                        pts.toString(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      width: Get.width / 5,
                      child: Text(
                        pas.toString(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                        right: 20,
                      ),
                      width: Get.width / 10,
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(
                            Routes.EDIT_NILAI,
                            arguments: {
                              "pelajaran": dataPelajaranIndex['pelajaran'],
                              "dataSiswa": dataSiswa,
                              "nilaiUts": grade?['nilaiUts'],
                              "nilaiSemester": grade?['nilaiSemester'],
                              "catatanGuru": grade?['catatanGuru'],
                              "semester": "semester 2"
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 20,
                  ),
                  width: Get.width,
                  child: const Text(
                    "Catatan : ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  height: Get.width / 5,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  child: Text(
                    grade?['catatanGuru'] ?? "Belum ada catatan",
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Expanded _inputGradeMid(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dataPelajaran,
      DocumentSnapshot<Map<String, dynamic>> gradeData,
      kelas) {
    return Expanded(
      child: ListView.builder(
        itemCount: dataPelajaran.length,
        itemBuilder: ((context, index) {
          var dataPelajaranIndex = dataPelajaran[index].data();
          var pelajaran = dataPelajaranIndex['pelajaran'];

          var grade = gradeData?['nilai'][kelas]?['semester 1']?[pelajaran];
          var pts = grade?['PTS'] ?? "0";
          var pas = grade?['PAS'] ?? "0";

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 250,
            color: Colors.blue.withOpacity(0.05),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 20,
                      ),
                      width: Get.width / 2,
                      child: Text(
                        "${dataPelajaranIndex['pelajaran']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      width: Get.width / 5,
                      child: Text(
                        pts.toString(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      width: Get.width / 5,
                      child: Text(
                        pas.toString(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                        right: 20,
                      ),
                      width: Get.width / 10,
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(
                            Routes.EDIT_NILAI,
                            arguments: {
                              "pelajaran": dataPelajaranIndex['pelajaran'],
                              "dataSiswa": dataSiswa,
                              "nilaiUts": grade?['PTS'],
                              "nilaiSemester": grade?['PAS'],
                              "catatanGuru": grade?['catatanGuru'],
                              "semester": "semester 1"
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 20,
                  ),
                  width: Get.width,
                  child: const Text(
                    "Catatan : ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  height: Get.width / 5,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  child: Text(
                    grade?['catatanGuru'] ?? "Belum ada catatan",
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
