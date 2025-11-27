// app/modules/home/controller/filter_controller.dart
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/home/controller/home_controller.dart';

class FilterController extends GetxController {
  // Get.find() দিয়ে নিলে বারবার put করতে হবে না
  final HomeController homeController = Get.find<HomeController>();

  var selectedCategoryId =
      ''.obs; // String রাখলাম (int আসলেও toString() করা হয়েছে)
  var selectedColor = ''.obs;
  var selectedSize = ''.obs;

  void clearFilters() {
    selectedCategoryId.value = '';
    selectedColor.value = '';
    selectedSize.value = '';
    debugPrint("All filters cleared");
  }

  void applyFilter() {
    final String catId = selectedCategoryId.value;
    final String color = selectedColor.value;
    final String size = selectedSize.value;

    debugPrint("Applying Filters:");
    debugPrint("   Category ID: '$catId'");
    debugPrint("   Color: '$color'");
    debugPrint("   Size: '$size'");

    homeController.goToAllProductsByFilter(
      catId.isEmpty ? null : catId,
      color.isEmpty ? null : color,
      size.isEmpty ? null : size,
    );

    // Get.back(); // অপশনাল: Apply করার পর Filter Screen বন্ধ
  }
}
