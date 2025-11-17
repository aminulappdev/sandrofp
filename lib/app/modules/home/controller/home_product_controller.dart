// lib/app/modules/home/controller/home_product_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/product/model/product_model.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class HomeProductController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  // শুধু হোম পেজের জন্য আলাদা ডেটা
  final Rx<AllProductModel?> _allProducts = Rx<AllProductModel?>(null);
  List<AllProductItemModel> get allProducts => _allProducts.value?.data?.data ?? [];

  final Rx<AllProductModel?> _nearbyProducts = Rx<AllProductModel?>(null);
  List<AllProductItemModel> get nearbyProducts => _nearbyProducts.value?.data?.data ?? [];

  final RxBool isLoadingAll = true.obs;
  final RxBool isLoadingNearby = true.obs;

  @override
  void onInit() {
    super.onInit();
    getAllProducts();
    getNearbyProducts(); // অ্যাপ ওপেন করলেই লোকেশন নিয়ে নিবে
  }

  Future<void> getAllProducts() async {
    isLoadingAll(true);
    try {
      final response = await _networkCaller.getRequest(
        Urls.productUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
      );

      if (response.isSuccess && response.responseData != null) {
        _allProducts.value = AllProductModel.fromJson(response.responseData);
      } else {
        _allProducts.value = null;
      }
    } catch (e) {
      showError('Failed to load products');
    } finally {
      isLoadingAll(false);
    }
  }

  Future<void> getNearbyProducts({double? lat, double? lng}) async {
    isLoadingNearby(true);
    try {
      // যদি lat/lng না দেওয়া হয়, তাহলে current location নিবে
      if (lat == null || lng == null) {
        // আপনার আগের location logic থাকতে পারে, এখানে skip করলাম
        // অথবা default Dhaka location দিয়ে দিতে পারেন
        lat = 23.8103;
        lng = 90.4125;
      }

      final response = await _networkCaller.getRequest(
        Urls.productUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        queryParams: {'latitude': lat, 'longitude': lng},
      );

      if (response.isSuccess && response.responseData != null) {
        _nearbyProducts.value = AllProductModel.fromJson(response.responseData);
      } else {
        _nearbyProducts.value = null;
      }
    } catch (e) {
      showError('Failed to load nearby products');
    } finally {
      isLoadingNearby(false);
    }
  }

  Future<void> refresh() async {
    await Future.wait([getAllProducts(), getNearbyProducts()]);
  }
}