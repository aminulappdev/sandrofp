// lib/app/modules/product/controller/all_product_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/home/controller/home_controller.dart';
import 'package:sandrofp/app/modules/product/model/product_model.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class AllProductController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  // প্রোডাক্ট ডেটা
  final Rx<AllProductModel?> _allProductModel = Rx<AllProductModel?>(null);
  List<AllProductItemModel> get allProductItems =>
      _allProductModel.value?.data?.data ?? [];

  // লোডিং স্টেট
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getAllProduct();
    getAllProductByCategory(null);
  }

  // API কল
  Future<void> getAllProduct() async {
    isLoading(true);
    try {
      final response = await _networkCaller.getRequest(
        Urls.productUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
      );

      if (response.isSuccess && response.responseData != null) {
        _allProductModel.value = AllProductModel.fromJson(
          response.responseData,
        );
      } else {
        showError(response.errorMessage);
        _allProductModel.value = null;
      }
    } catch (e) {
      showError('Network error: $e');
      _allProductModel.value = null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> getAllProductByCategory(String? categoryId) async {
    isLoading(true);
    try {
      final Map<String, dynamic> params =
          (categoryId == null || categoryId.isEmpty)
          ? {}
          : {'category': categoryId};

      final response = await _networkCaller.getRequest(
        Urls.productUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        queryParams: params,
      );

      if (response.isSuccess && response.responseData != null) {
        _allProductModel.value = AllProductModel.fromJson(
          response.responseData,
        );
      } else {
        showError(response.errorMessage);
        _allProductModel.value = null;
      }
    } catch (e) {
      showError('Network error: $e');
      _allProductModel.value = null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> getAllProductByLocation(
    double latitude,
    double longitude,
  ) async {
    isLoading(true);
    try {
      final Map<String, dynamic> params = {
        'latitude': latitude,
        'longitude': longitude,
      };

      final response = await _networkCaller.getRequest(
        Urls.productUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        queryParams: params,
      );

      if (response.isSuccess && response.responseData != null) {
        _allProductModel.value = AllProductModel.fromJson(
          response.responseData,
        );
      } else {
        showError(response.errorMessage);
        _allProductModel.value = null;
      }
    } catch (e) {
      showError('Network error: $e');
      _allProductModel.value = null;
    } finally {
      isLoading(false);
    }
  }

  // lib/app/modules/product/controller/all_product_controller.dart
  void goToProductDetails(AllProductItemModel data) {
    Get.find<HomeController>().goToProductDetails(data);
  }

  // রিফ্রেশ করার জন্য
  Future<void> refreshProducts() async {
    await getAllProduct();
  }
}
