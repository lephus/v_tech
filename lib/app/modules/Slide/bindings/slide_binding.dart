import 'package:get/get.dart';

import '../controllers/slide_controller.dart';

class SlideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SlideController>(
      () => SlideController(),
    );
  }
}
