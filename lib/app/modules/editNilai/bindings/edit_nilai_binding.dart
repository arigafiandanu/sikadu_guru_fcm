import 'package:get/get.dart';

import '../controllers/edit_nilai_controller.dart';

class EditNilaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditNilaiController>(
      () => EditNilaiController(),
    );
  }
}
