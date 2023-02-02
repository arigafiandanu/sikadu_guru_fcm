import 'package:get/get.dart';

import '../controllers/list_pegumuman_controller.dart';

class ListPegumumanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListPegumumanController>(
      () => ListPegumumanController(),
    );
  }
}
