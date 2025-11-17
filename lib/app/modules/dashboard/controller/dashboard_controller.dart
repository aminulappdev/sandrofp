// app/modules/dashboard/controller/dashboard_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/profile/controllers/profile_controller.dart';

class DashboardController extends GetxController {
  final ProfileController profileController = Get.find<ProfileController>();
  
  final RxInt _tabIndex = 2.obs; // ডিফল্ট Home
  int get tabIndex => _tabIndex.value;
  set tabIndex(int v) => _tabIndex.value = v;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    profileController.getMyProfile();
    pageController = PageController(initialPage: tabIndex);
    _printUserInfo();
    _handleArguments(); // প্রথমবারের জন্য
  }

  @override
  void onReady() {
    super.onReady();
    _handleArguments(); // প্রতিবার Dashboard ওপেন হলে চেক করবে (মূল সমাধান)
  }

  void _handleArguments() {
    final arguments = Get.arguments as Map<String, dynamic>?;
    final int? targetIndex = arguments?['index'] as int?;

    if (targetIndex != null && targetIndex >= 0 && targetIndex <= 4) {
      tabIndex = targetIndex;

      // UI রেন্ডার হওয়ার পর jump করবে
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (pageController.hasClients) {
          pageController.jumpToPage(targetIndex);
        }
      });
    }
  }

  void _printUserInfo() {
    var userId = StorageUtil.getData(StorageUtil.userId);
    var token = StorageUtil.getData(StorageUtil.userAccessToken);
    print('USER ID: $userId  TOKEN: $token');
  }

  void changeTab(int index) {
    tabIndex = index;
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}