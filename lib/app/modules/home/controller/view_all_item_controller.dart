// lib/app/modules/home/controllers/view_all_item_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/product/controller/all_product_controller.dart';

class ViewAllItemController extends GetxController {
  String? categoryId;
  String? title;

  final AllProductController allProductController = Get.find<AllProductController>();

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    categoryId = args?['category'] as String?;
    title = args?['title'] as String?;

    // API কল করুন, কিন্তু build শেষ হওয়ার পর
    Future.delayed(Duration.zero, () {
      allProductController.getAllProduct(categoryId);
    });
  }

  Future<void> refresh() async {
    await allProductController.refreshProducts(categoryId);
  }
}