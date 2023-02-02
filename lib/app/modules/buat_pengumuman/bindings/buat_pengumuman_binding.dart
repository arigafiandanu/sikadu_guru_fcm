import 'package:get/get.dart';

import '../controllers/buat_pengumuman_controller.dart';

class BuatPengumumanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuatPengumumanController>(
      () => BuatPengumumanController(),
    );
  }
}
