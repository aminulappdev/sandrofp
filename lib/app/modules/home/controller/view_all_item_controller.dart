// app/modules/home/controllers/view_all_item_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/product/controller/all_product_controller.dart';

class ViewAllItemController extends GetxController {
  final AllProductController allProductController =
      Get.find<AllProductController>();

  String? title;
  String? type; // 'all', 'category', 'nearby'

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    title = args?['title'] as String? ?? 'Products';
    type = args?['type'] as String?;

    // Load data based on type
    Future.delayed(Duration.zero, () {
      if (type == 'category') {
        final categoryId = args?['category'] as String?;
        allProductController.getAllProductByCategory(categoryId);
      } else if (type == 'nearby') {
        final lat = args?['latitude'] as double?;
        final lng = args?['longitude'] as double?;
        if (lat != null && lng != null) {
          allProductController.getAllProductByLocation(lat, lng);
        }
      } else if (type == 'filter') {
        final categoryId = args?['categoryId'] as String?;
        final color = args?['color'] as String?;
        final size = args?['size'] as String?;
        allProductController.getAllProductByFilter(
          categoryId ?? '',
          color ?? '',
          size ?? '',
        );
      } else {
        // Default: All products
        allProductController.getAllProduct();
      }
    });
  }

  Future<void> refresh() async {
    if (type == 'category') {
      final categoryId = Get.arguments?['category'] as String?;
      await allProductController.getAllProductByCategory(categoryId);
    } else if (type == 'nearby') {
      final lat = Get.arguments?['latitude'] as double?;
      final lng = Get.arguments?['longitude'] as double?;
      if (lat != null && lng != null) {
        await allProductController.getAllProductByLocation(lat, lng);
      }
    } else {
      await allProductController.getAllProduct();
    }
  }
}
