import 'package:get/get.dart';

import '../controllers/lupa_pass_controller.dart';

class LupaPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LupaPassController>(
      () => LupaPassController(),
    );
  }
}
