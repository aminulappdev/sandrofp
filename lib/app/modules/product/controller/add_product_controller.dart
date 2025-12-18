// app/modules/product/controller/add_product_controller.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:sandrofp/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:sandrofp/app/modules/product/model/upload_product_model.dart';
import 'package:sandrofp/app/modules/product/views/upload_product_Details_screen.dart';
import 'package:sandrofp/app/modules/product/views/uplpad_product_description_screen.dart';
import 'package:sandrofp/app/modules/product/views/upload_file_screen.dart';
import 'package:sandrofp/app/modules/profile/controllers/my_product_controller.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/network_caller/network_response.dart';
import 'package:sandrofp/app/urls.dart';

class AddProductController extends GetxController {
  // Text Controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController(); 
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final materialController = TextEditingController();
  final colorController = TextEditingController();
  final quantityController = TextEditingController();

  // Loading State
  final RxBool isLoading = false.obs;

  // Reactive Variables
  final RxString selectedSize = ''.obs;
  final RxString selectedCategoryId = ''.obs;
  final selectedImages = <File>[].obs;

  // Location Picker থেকে আসা ডাটা
  final Rx<LatLng?> selectedLatLng = Rx<LatLng?>(null);
  final RxString selectedAddress = ''.obs;

  // Final Product Preview
  Product? product;

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    discountController.dispose();
    materialController.dispose();
    colorController.dispose();
    quantityController.dispose();
    super.onClose();
  }

  // Size & Category
  void selectSize(String size) => selectedSize.value = size;
  void selectCategory(String categoryId) =>
      selectedCategoryId.value = categoryId;

  // Image Management
  void addImage(File file) {
    if (!selectedImages.contains(file)) selectedImages.add(file);
  }

  void removeImage(File file) {
    selectedImages.remove(file);
    selectedImages.refresh();
  }

  // Location Helper
  void setLocation(LatLng latLng, String address) {
    selectedLatLng.value = latLng;
    selectedAddress.value = address;
  }

  void clearLocation() {
    selectedLatLng.value = null;
    selectedAddress.value = '';
  }

  // Navigation
  void goToDescriptionScreen() {
    Get.to(() => const UploadProductDescriptionScreen());
  }

  void goToUploadFileScreen() {
    Get.to(() => const UploadProductFileScreen());
  }

  void goToProductDetails() {
    product = Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text,
      descriptions: descriptionController.text,
      price:
          (double.tryParse(priceController.text) ?? 0.0) -
          (double.tryParse(discountController.text) ?? 0.0),
      discount: (double.tryParse(discountController.text) ?? 0.0),
      size: selectedSize.value,
      colors: colorController.text,
      brands: materialController.text,
      images: selectedImages.map((file) => ImageUrl(url: file.path)).toList(),
      author: Author(profile: 'assets/images/onboarding01.png', name: 'You'),
    );
    Get.to(() => const UploadProductDetailsScreen());
  }

  void uploadProduct() {
    showLoadingOverLay(
      asyncFunction: performUploadProduct,
      msg: 'Uploading Product...',
    );
  }

  Future<void> performUploadProduct() async {
    isLoading(true);
    try {
      if (selectedCategoryId.value.isEmpty) {
        showError('Please select a category');
        return;
      }

      // যদি লোকেশন না পিক করে থাকে → ডিফল্ট ঢাকা দিয়ে দিবে (তোমার ইচ্ছা অনুযায়ী চেঞ্জ করতে পারো)
      final coordinates = selectedLatLng.value != null
          ? [
              selectedLatLng.value!.longitude,
              selectedLatLng.value!.latitude,
            ] // GeoJSON → [lng, lat]
          : [90.3995, 23.7944]; // Dhaka fallback

      Map<String, dynamic> jsonFields = {
        "name": nameController.text.trim(),
        "descriptions": descriptionController.text.trim(),
        "size": selectedSize.value,
        "materials": materialController.text.trim(),
        "location": {"type": "Point", "coordinates": coordinates},
        "tags": ["Casual", "Summer"],
        "colors": colorController.text.trim(),
        "category": selectedCategoryId.value,
        "price": int.tryParse(priceController.text) ?? 0,
        "quantity": quantityController.text.isNotEmpty
            ? quantityController.text
            : "1",
        "discount": int.tryParse(discountController.text) ?? 0,
      };

      final NetworkResponse response = await Get.find<NetworkCaller>()
          .postRequest(
            Urls.productUrl,
            body: jsonFields,
            accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
            images: selectedImages,
            keyNameImage: 'images',
          );
 
      if (response.isSuccess) {
        final MyProductController myProductController =
            Get.find<MyProductController>();
        await myProductController.getMyProduct();
        // force reset
        final dashboardController = Get.find<DashboardController>();
        dashboardController.tabIndex = 2;
        dashboardController.pageController.jumpToPage(2);
        Get.offAll(() => const DashboardScreen());
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
