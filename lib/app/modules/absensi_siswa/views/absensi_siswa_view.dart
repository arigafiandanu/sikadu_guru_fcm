import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/absensi_siswa_controller.dart';

class AbsensiSiswaView extends GetView<AbsensiSiswaController> {
  const AbsensiSiswaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AbsensiSiswaView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AbsensiSiswaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
