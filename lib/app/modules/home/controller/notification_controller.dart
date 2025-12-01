// controllers/notification_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/home/model/notification_model.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class NotificationController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  final Rx<NotificationsModel?> _notificationModel = Rx<NotificationsModel?>(
    null,
  );
  List<NotificationItemModel> get notificationItems =>
      _notificationModel.value?.data ?? [];

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
        Urls.notificationUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
      );

      if (response.isSuccess && response.responseData != null) {
        _notificationModel.value = NotificationsModel.fromJson(
          response.responseData,
        );
      } else {
        // showError(response.errorMessage);
        _notificationModel.value = null;
      }
    } catch (e) {
      showError('Network error: $e');
      _notificationModel.value = null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> readAllNotification() async {
    isLoading(true);
    try {
      final response = await _networkCaller.patchRequest(
        Urls.notificationUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
      );

      if (response.isSuccess && response.responseData != null) {
        getAllNotification();
      } else {
        // showError(response.errorMessage);
      }
    } catch (e) {
      showError('Network error: $e');
    } finally {
      isLoading(false);
    }
  }

  var notifications = <Map<String, dynamic>>[].obs;

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
