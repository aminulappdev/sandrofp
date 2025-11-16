// app/modules/product/controller/add_product_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/product/model/upload_product_model.dart';
import 'package:sandrofp/app/modules/product/views/upload_product_Details_screen.dart';
import 'package:sandrofp/app/modules/product/views/uplpad_product_description_screen.dart';
import 'package:sandrofp/app/modules/product/views/upload_file_screen.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/network_caller/network_response.dart';
import 'package:sandrofp/app/urls.dart';

class AddProductController extends GetxController {
  // Text Controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final materialController = TextEditingController();
  final colorController = TextEditingController();
  final quantityController = TextEditingController(); // NEW

  final RxBool isLoading = false.obs;

  // Reactive Variables
  final RxString selectedSize = ''.obs; // Single Size
  final RxString selectedCategoryId = ''.obs; // Category ID
  final selectedImages = <File>[].obs;

  // Final Product Preview
  Product? product;

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    priceController.dispose();
    discountController.dispose();
    materialController.dispose();
    colorController.dispose();
    quantityController.dispose(); // NEW
    super.onClose();
  }

  // Toggle Size Selection (Single)
  void selectSize(String size) {
    selectedSize.value = size;
  }

  // Select Category by ID
  void selectCategory(String categoryId) {
    selectedCategoryId.value = categoryId;
  }

  // Image Management
  void addImage(File file) {
    if (!selectedImages.contains(file)) {
      selectedImages.add(file);
    }
  }

  void removeImage(File file) {
    selectedImages.remove(file);
    if (selectedImages.isEmpty) selectedImages.refresh();
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
      price: double.tryParse(priceController.text) ?? 0.0,
      discount: double.tryParse(discountController.text) ?? 0.0,
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
      msg: 'Uploading...',
    );
  }

  Future<void> performUploadProduct() async {
    isLoading(true);
    try {
      if (selectedCategoryId.value.isEmpty) {
        showError('Please select a category');
        return;
      }

      Map<String, dynamic> jsonFields = {
        "name": nameController.text,
        "descriptions": descriptionController.text,
        "size": selectedSize.value,
        "materials": materialController.text,
        "location": {
          "type": "Point",
          "coordinates": [40.712776, -74.005974],
        },
        "tags": ["Casual", "Summer"],
        "colors": colorController.text,
        "category": selectedCategoryId.value,
        "price": int.tryParse(priceController.text) ?? 0,
        "quantity": quantityController.text.isNotEmpty
            ? quantityController.text
            : '1',
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
        showSuccess('Product uploaded successfully!');
        
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
