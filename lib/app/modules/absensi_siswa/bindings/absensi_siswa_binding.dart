import 'package:get/get.dart';

import '../controllers/absensi_siswa_controller.dart';

class AbsensiSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbsensiSiswaController>(
      () => AbsensiSiswaController(),
    );
  }
}
