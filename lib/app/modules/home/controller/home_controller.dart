// app/modules/home/controllers/home_controller.dart
import 'package:get/get.dart';

class HomeController extends GetxController {
  // যদি পরে ডেটা লোড করতে চাও (API থেকে)
  final RxList<RxMap<String, dynamic>> matchProducts = <RxMap<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyProducts();
  }

  void loadDummyProducts() {
    // ডামি প্রোডাক্ট (তোমার HomeProductCard এর জন্য)
    matchProducts.addAll([
      {'title': 'iPhone 13', 'onTap': () => Get.toNamed('/product-details')}.obs,
      {'title': 'Upload New', 'onTap': () => Get.toNamed('/upload-product')}.obs,
      {'title': 'MacBook Pro', 'onTap': () => Get.toNamed('/product-details')}.obs,
    ]);
  }

  void goToNotifications() => Get.toNamed('/notifications');
  void goToFilters() => Get.toNamed('/filters');
  void goToViewAll() => Get.toNamed('/view-all');
}