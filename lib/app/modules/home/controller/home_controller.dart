// app/modules/home/controllers/home_controller.dart
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sandrofp/app/modules/home/views/filter_screen.dart';
import 'package:sandrofp/app/modules/home/views/notification_screen.dart';
import 'package:sandrofp/app/modules/home/views/view_all_item_screen.dart';
import 'package:sandrofp/app/modules/product/controller/all_product_controller.dart';
import 'package:sandrofp/app/modules/product/model/product_model.dart';
import 'package:sandrofp/app/modules/product/views/product_details_screen.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';

class HomeController extends GetxController {
  final AllProductController allProductController =
      Get.find<AllProductController>();

  var lat = 0.0.obs;
  var long = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    _determinePosition(); // Get location on start
  }

  // Get current location
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showError('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showError('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showError('Location permissions are permanently denied.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    lat.value = position.latitude;
    long.value = position.longitude;
  }

  void goToNotifications() => Get.to(() => NotificationScreen());

  void goToFilters() => Get.to(() => FilterScreen());

  // View All by Category
  void goToViewAll(String title, String? categoryId) {
    Get.to(
      () => ViewAllItemScreen(),
      arguments: { 
        'title': title,
        'category': categoryId,
        'type': 'category', // new flag
      },
    );
  }

  // View All for All Products
  void goToAllProducts() {
    Get.to(
      () => ViewAllItemScreen(),
      arguments: {'title': 'All Products', 'type': 'all'},
    );
  }

  void goToAllProductsByFilter(
    
    String? categoryId,
    String? color,
    String? size,
  ) {

    print('categoryId: $categoryId, color: $color, size: $size');
    Get.to(
      () => ViewAllItemScreen(),
      arguments: {
        'title': 'Filter Products',
        'type': 'filter',
        'categoryId': categoryId,
        'color': color,
        'size': size,
      },
    );
  }

  // View All for Nearby Products
  void goToNearbyProducts() async {
    if (lat.value == 0.0 || long.value == 0.0) {
      await _determinePosition();
    }

    if (lat.value == 0.0 || long.value == 0.0) {
      showError('Could not get your location');
      return;
    }

    Get.to(
      () => ViewAllItemScreen(),
      arguments: {
        'title': 'Nearby Products',
        'type': 'nearby',
        'latitude': lat.value,
        'longitude': long.value,
      },
    );
  }

  void goToProductDetails(AllProductItemModel data) =>
      Get.to(() => ProductDetailsScreen(), arguments: {'data': data});
}
