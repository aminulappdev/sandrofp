// app/modules/profile/controllers/my_product_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/product/model/product_model.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class MyProductController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  // Make this RxList so Obx can listen
  final RxList<AllProductItemModel> allProductItems = <AllProductItemModel>[].obs;

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getMyProduct();
  }

  Future<void> getMyProduct() async {
    isLoading(true);
    try {
      final response = await _networkCaller.getRequest(
        Urls.myProductUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
      );

      if (response.isSuccess) {
        final model = AllProductModel.fromJson(response.responseData);
        allProductItems.assignAll(model.data?.data ?? []);
      } else {
        showError(response.errorMessage);
      }
    } catch (e) {
      showError('Network error occurred');
    } finally {
      isLoading(false);
    }
  }
}