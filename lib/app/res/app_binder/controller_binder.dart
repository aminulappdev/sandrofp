
import 'package:get/get.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';

class ControllerBinder extends Bindings {
  @override 
  void dependencies() {
    Get.put(NetworkCaller());
  
  }
}
