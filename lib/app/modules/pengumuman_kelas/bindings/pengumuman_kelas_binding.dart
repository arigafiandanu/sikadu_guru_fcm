import 'package:get/get.dart';

import '../controllers/pengumuman_kelas_controller.dart';

class PengumumanKelasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengumumanKelasController>(
      () => PengumumanKelasController(),
    );
  }
}
