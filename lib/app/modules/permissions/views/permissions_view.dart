import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/permissions_controller.dart';

class PermissionsView extends GetView<PermissionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PermissionsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PermissionsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
