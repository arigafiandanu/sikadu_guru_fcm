import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../controllers/detail_pengumuman_controller.dart';

class DetailPengumumanView extends GetView<DetailPengumumanController> {
  const DetailPengumumanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var dataPengumuman = Get.arguments;
    List<Container> tempImage =
        (dataPengumuman['fotoPengumuman'] as List).map((item) {
      return Container(
        child: Image.network(
          item,
          fit: BoxFit.cover,
        ),
      );
    }).toList();
    print("isi data ${ dataPengumuman['fotoPengumuman']}");
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
        title:  Text(
          dataPengumuman['judul'],
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
         tempImage.isNotEmpty
              ? CarouselSlider(
                  items: tempImage,
                  options: CarouselOptions(
                    height: Get.height / 3.5,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                  ),
                )
              : Container(
                  height: Get.height / 3.5,
                  width: Get.width,
                  child: Lottie.asset(
                    "assets/lottie/pengumuman_kosong.json",
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: Get.width * 0.2,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  dataPengumuman['kategori'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text(
              "${dataPengumuman['judul']}".toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  (DateFormat.yMMMMd()
                      .format(DateTime.parse(dataPengumuman['tanggalBuat']))),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  dataPengumuman['pembuat'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue[50],
            ),
            child: Text(
              dataPengumuman['isi'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
