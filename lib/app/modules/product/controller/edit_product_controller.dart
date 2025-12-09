// app/modules/product/controller/edit_product_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/product/model/product_model.dart';
import 'package:sandrofp/app/modules/profile/controllers/my_product_controller.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart'; 

class EditProductController extends GetxController {
  late AllProductItemModel product;

  // Text Controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final materialController = TextEditingController();
  final colorController = TextEditingController();
  final quantityController = TextEditingController();

  // Reactive
  final RxString selectedCategoryId = ''.obs;
  final RxString selectedSize = ''.obs;

  // শুধু একটা লিস্ট – UI + Upload দুটোর জন্যই
  final RxList<String> currentImagePaths = <String>[].obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['data'] is AllProductItemModel) {
      product = args['data'];
      _loadProductData();
    }
  }

  void _loadProductData() {
    nameController.text = product.name ?? '';
    descriptionController.text = product.descriptions ?? '';
    locationController.text = product.name ?? 'Not set';
    priceController.text = product.price?.toString() ?? '';
    discountController.text = product.discount?.toString() ?? '';
    materialController.text = product.materials ?? '';
    colorController.text = product.colors ?? '';
    quantityController.text = product.quantity ?? '1';

    selectedSize.value = product.size ?? '';
    selectedCategoryId.value = product.category?.id ?? '';

    // পুরোনো ইমেজের URL গুলো লোড করা
    currentImagePaths.value = product.images.map((img) => img.url!).toList();
  }

  // নতুন ইমেজ যোগ করা
  void addNewImage(File file) {
    currentImagePaths.add(file.path);
  }

  // যেকোনো ইমেজ রিমুভ করা (URL বা File)
  void removeImage(String path) {
    currentImagePaths.remove(path);
  }

  // শুধু নতুন ফাইলগুলো (যেগুলো আপলোড করতে হবে)
  List<File> get _uploadableImages {
    return currentImagePaths
        .where(
          (path) => path.startsWith('/') || path.contains('file://'),
        ) // local path
        .map((path) => File(path))
        .toList();
  }

  Future<void> updateProduct() async {
    if (nameController.text.trim().isEmpty) {
      showError('Product name is required');
      return;
    }

    isLoading(true);
    try {
      final Map<String, dynamic> body = {
        "name": nameController.text.trim(),
        "descriptions": descriptionController.text.trim(),
        "size": selectedSize.value,
        "materials": materialController.text,
        "location": {
          "type": "Point",
          "coordinates": [40.712776, -74.005974],
        },
        "colors": colorController.text,
        "tags": ["Tag1", "Tag2"],
        "category": selectedCategoryId.value,
        "price": priceController.text.isNotEmpty
            ? int.parse(priceController.text)
            : 0,
        "quantity": priceController.text,
        "discount": discountController.text.isNotEmpty
            ? int.parse(discountController.text)
            : 0,
      };

      final uploadImages = _uploadableImages;

      final response = await Get.find<NetworkCaller>().patchRequest(
        "${Urls.productUrl}/${product.id}",
        body: body,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        images: uploadImages.isNotEmpty ? uploadImages : null,
        keyNameImage: "images",
      );

      if (response.isSuccess) {
        await Get.find<MyProductController>().getMyProduct();
        showSuccess('Product updated successfully!');
        Navigator.pop(Get.overlayContext!);
      } else {
        showError(response.errorMessage);
      }
    } catch (e) {
      debugPrint("Update Error: $e");
      showError("Something went wrong");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    priceController.dispose();
    discountController.dispose();
    materialController.dispose();
    colorController.dispose();
    quantityController.dispose();
    super.onClose();
  }
}
