// sign_up_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/authentication/views/verification_screen.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/network_caller/validator_service.dart';
import 'package:sandrofp/app/urls.dart';

class ForgotPasswordController extends GetxController {
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailCtrl = TextEditingController(); 
  final RxBool isLoading = false.obs;

  final NetworkCaller _networkCaller = NetworkCaller();

  void forgotPassword() {
    if (!ValidatorService.validateAndSave(formKey)) return;

    showLoadingOverLay(
      asyncFunction: _performForgotPassword,
      msg: 'Sending reset link...',
    );
  }

  Future<void> _performForgotPassword() async {
    try {
      isLoading(true);

      final response = await _networkCaller.patchRequest(
        Urls.forgetPasswordUrl,
        body: {"email": emailCtrl.text.trim()},
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData['data'];
        final message = response.responseData['message'] ?? 'Account created!';
        final token = data?['token']?.toString();

        if (token == null || token.isEmpty) {
          showError('Token missing from server');
          return;
        }

        Get.to(
          () => OtpVerifyScreen(),
          arguments: {
            'email': emailCtrl.text.trim(),
            'token': token,
            'isVerify': false,
          },
        );
      } else {
        showError(response.errorMessage);
      }
    } catch (e) {
      print('Signup Error: $e');
      showError('Something went wrong');
    } finally {
      isLoading(false);
    }
  }
}
