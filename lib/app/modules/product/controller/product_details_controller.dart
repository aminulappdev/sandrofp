// app/modules/product_details/controllers/product_details_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/product/model/product_model.dart';

class ProductDetailsController extends GetxController {
  AllProductItemModel? product;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    product = args?['data'] as AllProductItemModel?;
  }

  


 
}
