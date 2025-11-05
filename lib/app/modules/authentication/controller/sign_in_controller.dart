import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/network_caller/validator_service.dart';
import 'package:sandrofp/app/urls.dart';

class SignInController extends GetxController {
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController(
    text: 'rafi@gmail.com',
  );
  final TextEditingController passwordCtrl = TextEditingController(
    text: '112233',
  );
  final RxBool obscureText = true.obs;
  final NetworkCaller _networkCaller = NetworkCaller();

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  void signIn() {
    if (ValidatorService.validateAndSave(formKey)) {
      showLoadingOverLay(asyncFunction: _performLogin, msg: 'Signing in...');
    }
  }

  Future<void> _performLogin() async {
    final response = await _networkCaller.postRequest(
      Urls.signInUrl,
      body: {'email': emailCtrl.text, 'password': passwordCtrl.text},
    );

    if (response.isSuccess) {
      final data = response.responseData['data'];
      if (data != null && data['need_verify'] == true) {
      } else {}
    } else {
      Get.snackbar(
        'Login Failed',
        response.errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
