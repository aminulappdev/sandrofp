// controllers/notification_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/product/model/product_model.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class NotificationController extends GetxController {
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
    getAllNotification();
  }

  // API কল
  Future<void> getAllNotification() async {
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

  var notifications = <Map<String, dynamic>>[].obs;

  @override
  void markAsRead(int index) {
    notifications[index]['isRead'] = true;
    notifications.refresh(); // Obx এর জন্য refresh
  }

  void markAllAsRead() {
    for (var notification in notifications) {
      notification['isRead'] = true;
    }
    notifications.refresh();
  }

  void deleteNotification(int index) {
    final removedItem = notifications.removeAt(index);
    Get.snackbar(
      'Deleted',
      '${removedItem['name']} is deleted',
      colorText: Colors.white,
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.TOP,
    );
  }
}
