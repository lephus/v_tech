import 'package:get/get.dart';

import '../controllers/recent_files_controller.dart';

class RecentFilesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecentFilesController>(
      () => RecentFilesController(),
    );
  }
}
