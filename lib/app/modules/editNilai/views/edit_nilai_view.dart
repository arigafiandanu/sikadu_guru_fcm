import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sikadu_guru/app/widget/textFieldNilai.dart';

import '../../../widget/buttonW.dart';
import '../../../widget/textFieldCatatan.dart';
import '../controllers/edit_nilai_controller.dart';

class EditNilaiView extends GetView<EditNilaiController> {
  var mataPelajaran = Get.arguments['pelajaran'] ?? "";
  var dataSiswa = Get.arguments['dataSiswa'] ?? "";
  var nilaiPTS = Get.arguments['nilaiUts'] ?? 0;
  var nilasPAS = Get.arguments['nilaiSemester'] ?? 0;
  var catatanGuru = Get.arguments['catatanGuru'] ?? "";
  var semester = Get.arguments['semester'] ?? "";

  EditNilaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.nilaiPTS.text = (nilaiPTS ?? 0).toString();
    controller.nilaiPAS.text = (nilasPAS ?? 0).toString();
    controller.catatanGuru.text = catatanGuru ?? "catatan untuk siswa";
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
          '$mataPelajaran',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20),
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
                  padding: const EdgeInsets.only(right: 20),
                  width: Get.width / 4,
                  child: const Text(
                    "Nilai UTS",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  width: Get.width / 4,
                  child: const Text(
                    "Nilai Semester",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
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
                        "$mataPelajaran",
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
                      width: Get.width / 4,
                      child: TextFormNilai(
                        hint: (nilaiPTS ?? 0).toString(),
                        controller: controller.nilaiPTS,
                        readOnly: false,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      width: Get.width / 4,
                      child: TextFormNilai(
                        hint: (nilasPAS ?? 0).toString(),
                        controller: controller.nilaiPAS,
                        readOnly: false,
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
                  alignment: Alignment.topLeft,
                  child: TextFieldCatatan(
                    hint: catatanGuru ?? "masukkan catatan",
                    controller: controller.catatanGuru,
                    readOnly: false,
                  ),
                )
              ],
            ),
          ),
          ButtonW(
            onTap: () {
              controller.tambahNilaiSiswa(
                semester,
                dataSiswa['email'],
                mataPelajaran,
              );
            },
            text: "Input Nilai",
          )
        ],
      ),
    );
  }
}
