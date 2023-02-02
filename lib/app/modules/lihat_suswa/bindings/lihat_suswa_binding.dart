import 'package:get/get.dart';

import '../controllers/lihat_suswa_controller.dart';

class LihatSuswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LihatSuswaController>(
      () => LihatSuswaController(),
    );
  }
}
