// app/modules/cart/controller/cart_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/product/model/product_model.dart';
import 'package:sandrofp/app/modules/profile/controllers/my_product_controller.dart';

class CartController extends GetxController {
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirm = true.obs;

  late String email;
  late String? token;

  final MyProductController myProductController =
      Get.find<MyProductController>();

  AllProductItemModel? productData;

  // Exchange price (the product we are exchanging with)
  final RxDouble exchangePrice = 0.0.obs;

  // Selected product IDs
  var selectedProductIds = <String>[].obs;

  // Computed values
  var selectedTotal = 0.0.obs;
  var remainingPrice = 0.0.obs;
  var extraTokens = 0.0.obs; // New: Extra tokens to earn

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    productData = args?['data'] as AllProductItemModel?;
    final price = productData?.price?.toDouble() ?? 0.0;
    final discount = productData?.discount?.toDouble() ?? 0.0;
    final updatePrice = price - discount;
    exchangePrice.value = updatePrice;
    remainingPrice.value = updatePrice;

    // Listen to selection changes and update totals
    ever(selectedProductIds, (_) => _calculateTotals());

    print('EXCHANGE PRICE: $updatePrice');
  }

  void _calculateTotals() {
    double total = 0.0;
    final products = myProductController.allProductItems;

    for (var id in selectedProductIds) {
      final product = products.firstWhereOrNull((p) => p.id.toString() == id);
      if (product != null) {
        var price = product.price?.toDouble() ?? 0.0;
        var discount = product.discount?.toDouble() ?? 0.0;
        var updatePrice = price - discount;
        total += updatePrice;
      }
    }

    selectedTotal.value = total;
    
    // Calculate remaining price and extra tokens
    if (total > exchangePrice.value) {
      // User's products are worth more - they earn tokens
      extraTokens.value = total - exchangePrice.value;
      remainingPrice.value = 0.0;
    } else {
      // User's products are worth less - they need to add more
      extraTokens.value = 0.0;
      remainingPrice.value = exchangePrice.value - total;
    }
  }

  void toggleSelection(String productId) {
    final products = myProductController.allProductItems;
    final product = products.firstWhereOrNull(
      (p) => p.id.toString() == productId,
    );
    if (product == null) return;

    if (selectedProductIds.contains(productId)) {
      // Deselect
      selectedProductIds.remove(productId);
    } else {
      // Allow any selection - we'll show extra tokens if user's products exceed exchange value
      selectedProductIds.add(productId);
    }
  }

  bool get canProceed => selectedTotal.value > 0;
}