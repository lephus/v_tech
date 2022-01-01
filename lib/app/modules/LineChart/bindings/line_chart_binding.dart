import 'package:get/get.dart';

import '../controllers/line_chart_controller.dart';

class LineChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LineChartController>(
      () => LineChartController(),
    );
  }
}
