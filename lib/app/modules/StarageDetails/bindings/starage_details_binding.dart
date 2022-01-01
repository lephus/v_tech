import 'package:get/get.dart';

import '../controllers/starage_details_controller.dart';

class StarageDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StarageDetailsController>(
      () => StarageDetailsController(),
    );
  }
}
