import 'package:get/get.dart';

import '../controllers/masukkan_nilai_controller.dart';

class MasukkanNilaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasukkanNilaiController>(
      () => MasukkanNilaiController(),
    );
  }
}
