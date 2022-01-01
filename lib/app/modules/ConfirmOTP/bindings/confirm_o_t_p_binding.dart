import 'package:get/get.dart';

import '../controllers/confirm_o_t_p_controller.dart';

class ConfirmOTPBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmOTPController>(
      () => ConfirmOTPController(),
    );
  }
}
