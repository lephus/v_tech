import 'package:get/get.dart';

import '../controllers/my_file_controller.dart';

class MyFileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyFileController>(
      () => MyFileController(),
    );
  }
}
