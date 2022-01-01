import 'package:get/get.dart';

import '../controllers/list_order_controller.dart';

class ListOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListOrderController>(
      () => ListOrderController(),
    );
  }
}
