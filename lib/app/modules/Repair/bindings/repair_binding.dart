import 'package:get/get.dart';

import '../controllers/repair_controller.dart';

class RepairBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RepairController>(
      () => RepairController(),
    );
  }
}
