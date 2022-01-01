import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/line_chart_controller.dart';

class LineChartView extends GetView<LineChartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LineChartView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LineChartView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
