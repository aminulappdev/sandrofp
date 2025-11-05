import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/network_caller/validator_service.dart';
import 'package:sandrofp/app/urls.dart';
import '../views/verification_screen.dart';

class SignUpController extends GetxController {
  // Form & Controllers
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  // Reactive States
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxBool agreeTerms = false.obs;
  final RxBool isLoading = false.obs;

  // Services
  final NetworkCaller _networkCaller = NetworkCaller();

  @override
  void onClose() {
    usernameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => obscurePassword.value = !obscurePassword.value;
  void toggleConfirmPasswordVisibility() => obscureConfirmPassword.value = !obscureConfirmPassword.value;

  void signUp() async {
    if (!agreeTerms.value) {
      Get.snackbar(
        'Terms Required',
        'Please agree to Terms & Conditions and Privacy Policy',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    if (!ValidatorService.validateAndSave(formKey)) return;

    if (isLoading.value) return;
    isLoading.value = true;

    await showLoadingOverLay(
      asyncFunction: _performSignUp,
      msg: 'Creating your account...',
    );

    isLoading.value = false;
  }

  Future<void> _performSignUp() async {
    try {
      final response = await _networkCaller.postRequest(
        Urls.signUpUrl,
        body: {
          'username': usernameCtrl.text.trim(),
          'email': emailCtrl.text.trim(),
          'phone': phoneCtrl.text.trim(),
          'password': passwordCtrl.text,
          'password_confirmation': confirmPasswordCtrl.text,
        },
      );

      if (response.isSuccess) {
        final data = response.responseData['data'];
        final message = response.responseData['message'] ?? 'Account created!';

        Get.snackbar(
          'Success',
          message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        if (data != null && data['need_verify'] == true) {
          Get.to(() => OtpVerifyScreen(email: emailCtrl.text, isVerify: true));
        } else {
          
        }
      } else {
        Get.snackbar(
          'Failed',
          response.errorMessage ?? 'Try again later.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Network error. Please check your connection.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}