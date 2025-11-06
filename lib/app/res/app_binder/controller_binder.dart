import 'package:get/get.dart';
import 'package:sandrofp/app/modules/authentication/controller/forget_password_controller.dart';
import 'package:sandrofp/app/modules/authentication/controller/otp_verify_controller.dart';
import 'package:sandrofp/app/modules/authentication/controller/reset_password_controller.dart';
import 'package:sandrofp/app/modules/authentication/controller/sign_in_controller.dart';
import 'package:sandrofp/app/modules/authentication/controller/sign_up_controller.dart';
import 'package:sandrofp/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:sandrofp/app/modules/profile/controllers/profile_controller.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkCaller());
    Get.put(ProfileController());
    Get.put(SignUpController());
    
    Get.lazyPut(() => SignInController());
    // Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => OtpVerifyController());
    Get.lazyPut(() => ForgotPasswordController());
    Get.lazyPut(() => ResetPasswordController());
    Get.lazyPut(() => DashboardController());
  }
}
