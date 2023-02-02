import 'package:get/get.dart';

import '../controllers/nilai_siswa_controller.dart';

class NilaiSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NilaiSiswaController>(
      () => NilaiSiswaController(),
    );
  }
}
