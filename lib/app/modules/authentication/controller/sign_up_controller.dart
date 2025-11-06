// sign_up_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/network_caller/validator_service.dart';
import 'package:sandrofp/app/urls.dart';
import '../views/verification_screen.dart';

class SignUpController extends GetxController {
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxBool isLoading = false.obs;
  final RxBool isAgree = false.obs;

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

  void togglePasswordVisibility() => obscurePassword.toggle();
  void toggleConfirmPasswordVisibility() => obscureConfirmPassword.toggle();

  void signUp() {
    if (!ValidatorService.validateAndSave(formKey)) return;

    showLoadingOverLay(
      asyncFunction: _performSignUp,
      msg: 'Creating your account...',
    );
  }

  Future<void> _performSignUp() async {
    try {
      isLoading(true);

      final response = await _networkCaller.postRequest(
        Urls.signUpUrl,
        body: {
          "name": usernameCtrl.text.trim(),
          "email": emailCtrl.text.trim(),
          "phoneNumber": phoneCtrl.text.trim(),
          "password": passwordCtrl.text.trim(),
          "registerWith": "credentials",
        },
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData['data'];
        final message = response.responseData['message'] ?? 'Account created!';
        final token = data?['otpToken']?['token']?.toString();

        if (token == null || token.isEmpty) {
          showError('Token missing from server');
          return;
        }

        print('TOKEN পাঠানো হচ্ছে: $token');
        showSuccess(message);

        // FIXED: Get.off() → Get.to()
        Get.to(
          () => OtpVerifyScreen(),
          arguments: {
            'email': emailCtrl.text.trim(),
            'isVerify': true,
            'token': token,
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