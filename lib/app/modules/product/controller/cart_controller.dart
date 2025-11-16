// app/modules/cart/controller/cart_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/authentication/views/sign_in_screen.dart';
import 'package:sandrofp/app/modules/product/model/product_model.dart';
import 'package:sandrofp/app/modules/profile/controllers/my_product_controller.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class CartController extends GetxController {

   final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirm = true.obs;

  late String email;
  late String? token; // OTP token (optional)

  final NetworkCaller _networkCaller = NetworkCaller();
  
  final MyProductController myProductController = Get.find<MyProductController>();

  AllProductItemModel? productData;

  // Exchange price (the product we are exchanging with)
  final RxDouble exchangePrice = 0.0.obs;

  // Selected product IDs
  var selectedProductIds = <String>[].obs;

  // Computed values
  var selectedTotal = 0.0.obs;
  var remainingPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    productData = args?['data'] as AllProductItemModel?;
    exchangePrice.value = productData?.price?.toDouble() ?? 0.0;
    remainingPrice.value = exchangePrice.value;

    // Listen to selection changes and update totals
    ever(selectedProductIds, (_) => _calculateTotals());

    print('EXCHANGE PRICE: ${exchangePrice.value}');
  }

  void _calculateTotals() {
    double total = 0.0;
    final products = myProductController.allProductItems;

    for (var id in selectedProductIds) {
      final product = products.firstWhereOrNull((p) => p.id.toString() == id);
      if (product != null) {
        total += (product.price?.toDouble() ?? 0.0);
      }
    }

    selectedTotal.value = total;
    remainingPrice.value = (exchangePrice.value - total).clamp(0.0, double.infinity);
  }

  void toggleSelection(String productId) {
    final products = myProductController.allProductItems;
    final product = products.firstWhereOrNull((p) => p.id.toString() == productId);
    if (product == null) return;

    final newPrice = product.price?.toDouble() ?? 0.0;

    if (selectedProductIds.contains(productId)) {
      // Deselect
      selectedProductIds.remove(productId);
    } else {
      // Try to select
      final currentTotal = selectedTotal.value;
      if (currentTotal + newPrice > exchangePrice.value) {
        // Show snackbar or toast (optional)
        Get.snackbar(
          "Limit Exceeded",
          "Cannot select this item. Total would exceed exchange value.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
        return;
      }
      selectedProductIds.add(productId);
    }
  }

  bool get canProceed => selectedTotal.value > 0;

  Future<void> _performReset() async {
    try {
      isLoading(true);

      final body = {
        "newPassword": passwordCtrl.text,
        "confirmPassword": confirmPasswordCtrl.text,
      };

      final response = await _networkCaller.patchRequest(
        accessToken: token,
        customTokenName: 'token',
        Urls.resetPasswordUrl,
        body: body,
      );

      if (response.isSuccess) {
        showSuccess('Password reset successfully!');
        Get.offAll(() => SignInScreen());
      } else {
        showError(response.errorMessage);
      }
    } catch (e) {
      print('Reset Password Error: $e');
      showError('Something went wrong');
    } finally {
      isLoading(false);
    }
  }
}