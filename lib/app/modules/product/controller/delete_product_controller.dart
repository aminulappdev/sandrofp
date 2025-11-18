// app/modules/product/controller/add_product_controller.dart

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/profile/controllers/my_product_controller.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/network_caller/network_response.dart';
import 'package:sandrofp/app/urls.dart';

class DeleteProductController extends GetxController {
  final RxBool isLoading = false.obs;
  late String productId;

  @override
  void onClose() {
    deleteProduct(productId);
    super.onClose();
  }

  void deleteProduct(String id) {
    productId = id;
    showLoadingOverLay(asyncFunction: performDeleteProduct, msg: 'Deleting...');
  }

  Future<void> performDeleteProduct() async {
    isLoading(true);
    try {
      final NetworkResponse response = await Get.find<NetworkCaller>()
          .deleteRequest(
            "${Urls.productUrl}/$productId",
            accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
          );

      if (response.isSuccess) {
        await Get.find<MyProductController>().getMyProduct();
        showSuccess('Product deleted successfully!');
        Navigator.pop(Get.overlayContext!);
      } else {
        showError(response.errorMessage);
      }
    } catch (e) {
      showError('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
