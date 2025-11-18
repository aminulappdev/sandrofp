import 'package:get/get.dart';
import 'package:sandrofp/app/modules/authentication/controller/forget_password_controller.dart';
import 'package:sandrofp/app/modules/authentication/controller/otp_verify_controller.dart';
import 'package:sandrofp/app/modules/authentication/controller/reset_password_controller.dart';
import 'package:sandrofp/app/modules/authentication/controller/sign_in_controller.dart';
import 'package:sandrofp/app/modules/authentication/controller/sign_up_controller.dart';
import 'package:sandrofp/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:sandrofp/app/modules/home/controller/category_controller.dart';
import 'package:sandrofp/app/modules/home/controller/home_controller.dart';
import 'package:sandrofp/app/modules/home/controller/view_all_item_controller.dart';
import 'package:sandrofp/app/modules/product/controller/all_product_controller.dart';
import 'package:sandrofp/app/modules/product/controller/cart_controller.dart';
import 'package:sandrofp/app/modules/product/controller/product_details_controller.dart';
import 'package:sandrofp/app/modules/profile/controllers/my_product_controller.dart';
import 'package:sandrofp/app/modules/profile/controllers/profile_controller.dart';
import 'package:sandrofp/app/modules/settings/controller/content_controller.dart';
import 'package:sandrofp/app/modules/settings/controller/exchange_history_controller.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkCaller());
    Get.put(ProfileController());
    Get.put(SignUpController());
    Get.put(SignInController());
    Get.lazyPut(() => OtpVerifyController());
    Get.lazyPut(() => ForgotPasswordController());
    Get.lazyPut(() => ResetPasswordController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => AllProductController());
    Get.lazyPut(() => MyProductController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ContentController());
    Get.lazyPut(() => ExchangeHistoryController());

    // এই লাইনটা যোগ করো
    Get.lazyPut<ViewAllItemController>(
      () => ViewAllItemController(),
      fenix: true,
    );
    Get.lazyPut<ProductDetailsController>(
      () => ProductDetailsController(),
      fenix: true,
    );
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
  }
}
