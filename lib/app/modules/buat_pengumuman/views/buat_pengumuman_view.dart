import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sikadu_guru/app/widget/textFieldIsiPengumuman.dart';

import '../../../widget/buttonW.dart';
import '../../../widget/teksFieldButtonW.dart';
import '../../../widget/textfieldTambahUser.dart';
import '../controllers/buat_pengumuman_controller.dart';

class BuatPengumumanView extends GetView<BuatPengumumanController> {
  const BuatPengumumanView({Key? key}) : super(key: key);
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
          'Buat Pengumuman',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          CustomFormFieldTambahUser(
            headingText: "Judul",
            hintText: "Judul pengumuman",
            obsecureText: false,
            suffixIcon: const SizedBox(),
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: controller.judulC,
            maxLines: 1,
          ),
          CustomFormFieldIsiPengumuman(
            headingText: "Isi Pengumuman",
            hintText: "Masukkan Pengumuman",
            obsecureText: false,
            suffixIcon: SizedBox(),
            textInputType: TextInputType.multiline,
            textInputAction: TextInputAction.next,
            controller: controller.isiC,
            maxLines: 30,
            readOnly: false,
            hint: "Masukan isi Pengumuman",
          ),
          Obx(
            () => TextFormButtonW(
              title: "Kategori",
              hint: controller.kategoriP.value,
              controller: null,
              widget: DropdownButton(
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                ),
                iconSize: 35,
                elevation: 4,
                underline: Container(
                  height: 0,
                ),
                items: controller.dataPengumuman.map((e) {
                  return DropdownMenuItem(
                    value: e.toString(),
                    child: Text(e.toString()),
                  );
                }).toList(),
                onChanged: (String? kategori) {
                  controller.kategoriP.value = kategori!;
                },
              ),
            ),
          ),
          Obx(
            () => TextFormButtonW(
              title: "Penerima Pengumuman",
              hint: controller.kategoriPenerima.value,
              controller: null,
              widget: DropdownButton(
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                ),
                iconSize: 35,
                elevation: 4,
                underline: Container(
                  height: 0,
                ),
                items: controller.dataPenerimaPengumuman.map((e) {
                  return DropdownMenuItem(
                    value: e.toString(),
                    child: Text(e.toString()),
                  );
                }).toList(),
                onChanged: (String? kategori) {
                  controller.kategoriPenerima.value = kategori!;
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GetBuilder<BuatPengumumanController>(
                  builder: (c) {
                    if (c.imageList.isNotEmpty) {
                      return Container(
                        width: Get.width,
                        height: 600,
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: c.imageList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 100,
                                height: 100,
                                child: Image.file(
                                  File(c.imageList[index].path),
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          controller.pickMultiImage();
                        },
                        child: Container(
                          width: Get.width * 0.4,
                          height: Get.height * 0.15,
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/fotoimg2.png",
                            alignment: Alignment.center,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          ButtonW(
            onTap: () {
              controller.tambahPengumuman();
            },
            text: "Buat Pengumuman",
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
