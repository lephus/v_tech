import 'package:get/get.dart';

import '../controllers/infor_product_controller.dart';

class InforProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InforProductController>(
      () => InforProductController(),
    );
  }
}
