import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccess(String msg) {
  Get.snackbar(
    'Success',
    msg,
    backgroundColor: Colors.green,
    colorText: Colors.white,
  );
}

void showError(String msg) {
  Get.snackbar(
    'Failed',
    msg,
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}
