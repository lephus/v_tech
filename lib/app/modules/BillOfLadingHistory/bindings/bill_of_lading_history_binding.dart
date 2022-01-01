import 'package:get/get.dart';

import '../controllers/bill_of_lading_history_controller.dart';

class BillOfLadingHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillOfLadingHistoryController>(
      () => BillOfLadingHistoryController(),
    );
  }
}
