import 'package:get/get.dart';

import '../controllers/instance_controller.dart';

class InstanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InstanceController>(
      () => InstanceController(),
    );
  }
}
