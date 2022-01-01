import 'package:get/get.dart';

import '../controllers/order_assemble_controller.dart';

class OrderAssembleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderAssembleController>(
      () => OrderAssembleController(),
    );
  }
}
