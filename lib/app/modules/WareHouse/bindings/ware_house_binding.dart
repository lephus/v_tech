import 'package:get/get.dart';

import '../controllers/ware_house_controller.dart';

class WareHouseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WareHouseController>(
      () => WareHouseController(),
    );
  }
}
