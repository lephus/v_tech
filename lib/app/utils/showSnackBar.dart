import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBarSuccess(String title, String message) {
  Get.snackbar(title, message, backgroundColor: Colors.grey[200],
      snackPosition: SnackPosition.TOP,
      colorText: Colors.green[700]);
}
showSnackBarError(String title, String message) {
  Get.snackbar(title, message, backgroundColor: Colors.grey[200],
      snackPosition: SnackPosition.TOP,
      colorText: Colors.red);
}