// otp_verify_controller.dart
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/authentication/controller/sign_up_controller.dart';
import 'package:sandrofp/app/modules/authentication/views/reset_password_screen.dart';
import 'package:sandrofp/app/modules/authentication/views/sign_in_screen.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class OtpVerifyController extends GetxController {
  final RxInt secondsRemaining = 60.obs;
  final RxBool canResend = false.obs;
  final RxBool isLoading = false.obs;

  final pinCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RxString email = ''.obs; // RxString করে reactive করা
  String token = '';
  late bool isVerify;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
    // arguments check onReady-এ করব যাতে build complete হয়
  }

  @override
  void onReady() {
    super.onReady();
    _readArguments();
  }

  void _readArguments() {
    final args = Get.arguments;

    print('RAW ARGUMENTS: $args');

    if (args == null || args is! Map<String, dynamic>) {
      showError('No data received!');
      Get.back();
      return;
    }

    final String? receivedEmail = args['email']?.toString().trim();
    token = args['token']?.toString().trim() ?? '';
    isVerify = args['isVerify'] == true;

    if (receivedEmail == null || receivedEmail.isEmpty || token.isEmpty) {
      showError('Invalid data. Please try again.');
      Get.back();
      return;
    }

    email.value = receivedEmail; // RxString update

    print('EMAIL: ${email.value}');
    print('TOKEN: $token');
    print('IS VERIFY: $isVerify');
  }

  void _startTimer() {
    canResend(false);
    secondsRemaining(60);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value <= 1) {
        timer.cancel();
        canResend(true);
      } else {
        secondsRemaining.value--;
      }
    });
  }

  Future<void> resendOtp() async {
    if (!canResend.value) return;
    showLoadingOverLay(asyncFunction: _performResend, msg: 'Resending...');
  }

  Future<void> _performResend() async {
    pinCtrl.clear();
    update();
    try {
      final resp = await NetworkCaller().postRequest(
        Urls.resendUrl,
        body: {"email": email.value},
      );
      if (resp.isSuccess) {
        showSuccess('New OTP sent!');
        token = resp.responseData['data']['token'];
        print('UPDATE TOKEN: $token');
        _startTimer();
      } else {
        showError(resp.errorMessage);
      }
    } catch (e) {
      showError('Network error');
    }
  }

  Future<void> verifyOtp() async {
    if (pinCtrl.text.trim().length != 6) {
      showError('Enter 6-digit code');
      return;
    }
    showLoadingOverLay(asyncFunction: _performVerify, msg: 'Verifying...');
  }

  Future<void> _performVerify() async {
    try {
      final resp = await NetworkCaller().postRequest(
        Urls.otpVerifyUrl,
        accessToken: token,
        customTokenName: 'token',
        body: {"otp": pinCtrl.text.trim()},
      );

      if (resp.isSuccess) {
        // SignUp data clear করা (যদি sign-up flow হয়)
        if (isVerify && Get.isRegistered<SignUpController>()) {
          final signUpController = Get.find<SignUpController>();
          signUpController.usernameCtrl.clear();
          signUpController.emailCtrl.clear();
          signUpController.phoneCtrl.clear();
          signUpController.passwordCtrl.clear();
          signUpController.confirmPasswordCtrl.clear();
        }

        isVerify
            ? Get.offAll(() => SignInScreen())
            : Get.to(
                () => ResetPasswordScreen(),
                arguments: {'email': email.value, 'token': token},
              );
      } else {
        showError(resp.errorMessage);
      }
    } catch (e) {
      showError('Verification failed');
    }
  }
}
