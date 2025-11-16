// app/modules/home/controllers/home_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/home/views/filter_screen.dart';
import 'package:sandrofp/app/modules/home/views/notification_screen.dart';
import 'package:sandrofp/app/modules/home/views/view_all_item_screen.dart';
import 'package:sandrofp/app/modules/product/controller/all_product_controller.dart';
import 'package:sandrofp/app/modules/product/model/product_model.dart';
import 'package:sandrofp/app/modules/product/views/product_details_screen.dart';

class HomeController extends GetxController {
  // যদি পরে ডেটা লোড করতে চাও (API থেকে)
  final RxList<RxMap<String, dynamic>> matchProducts =
      <RxMap<String, dynamic>>[].obs; 

  @override
  void onInit() {
    super.onInit();

    final allProductController = Get.find<AllProductController>();
    allProductController.getAllProduct('');
  }

  void goToNotifications() => Get.to(NotificationScreen());
  void goToFilters() => Get.to(FilterScreen());
  void goToViewAll(String title, String? categoryId) => Get.to(
    () => ViewAllItemScreen(),
    arguments: {'title': title, 'category': categoryId},
  );

  void goToProductDetails(AllProductItemModel data) =>
      Get.to(() => ProductDetailsScreen(), arguments: {'data': data});
}
