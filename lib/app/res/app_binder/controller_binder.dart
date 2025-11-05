
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/authentication/controller/sign_in_controller.dart';
import 'package:sandrofp/app/modules/authentication/controller/sign_up_controller.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';

class ControllerBinder extends Bindings {
  @override 
  void dependencies() {
    Get.put(NetworkCaller());
    Get.put(SignInController());
    Get.put(SignUpController());
  
  }
}
