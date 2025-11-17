// reset_password_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/authentication/views/sign_in_screen.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirm = true.obs;

  late String email; 
  late String? token; // OTP token (optional)

  final NetworkCaller _networkCaller = NetworkCaller();

  @override
  void onInit() {
    super.onInit();
    // Get arguments from previous screen
    final args = Get.arguments;
    email = args['email'] ?? '';
    token = args['token'] ?? '';
  }

  @override
  void onClose() {
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => obscurePassword.toggle();
  void toggleConfirmVisibility() => obscureConfirm.toggle();

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    showLoadingOverLay(
      asyncFunction: _performReset,
      msg: 'Resetting password...',
    );
  }

  Future<void> _performReset() async {
    try {
      isLoading(true);

      final body = {
        "newPassword": passwordCtrl.text,
        "confirmPassword": confirmPasswordCtrl.text,
      };

      final response = await _networkCaller.patchRequest(
        accessToken: token,
        customTokenName: 'token',
        Urls.resetPasswordUrl,
        body: body,
      );

      if (response.isSuccess) {
        showSuccess('Password reset successfully!');
        Get.offAll(() => SignInScreen());
      } else {
        showError(response.errorMessage);
      }
    } catch (e) {
      print('Reset Password Error: $e');
      showError('Something went wrong');
    } finally {
      isLoading(false);
    } 
  }
}
