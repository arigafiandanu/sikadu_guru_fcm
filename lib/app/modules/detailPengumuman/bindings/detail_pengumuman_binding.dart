import 'package:get/get.dart';

import '../controllers/detail_pengumuman_controller.dart';

class DetailPengumumanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPengumumanController>(
      () => DetailPengumumanController(),
    );
  }
}
