// payment_service.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/payment/controller/payment_controller.dart';
import 'package:sandrofp/app/modules/payment/view/payment_webview_screen.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';

class PaymentService {
  final PaymentController paymentController = PaymentController();

  Future<void> payment(BuildContext context, String referenceId) async {
    final bool isSuccess = await paymentController.getPayment(referenceId);

    Map<String, dynamic> paymentData = {
      'link': paymentController.paymentData?.data,
      'reference': referenceId,
    };

    if (isSuccess) {
      // Directly use context without mounted check
      // showSuccess('Payment request done');
      Get.to(PaymentView(paymentData: paymentData));
    } else {
      // Error handling
      showError(paymentController.errorMessage ?? 'There was a problem');
    }
  }
}
