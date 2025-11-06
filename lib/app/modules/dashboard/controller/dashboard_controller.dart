import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/profile/controllers/profile_controller.dart';

class DashboardController extends GetxController {
  final ProfileController profileController = Get.find<ProfileController>();
  final RxInt _tabIndex = 2.obs;
  int get tabIndex => _tabIndex.value;
  set tabIndex(int v) => _tabIndex.value = v;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    profileController.getMyProfile();
    pageController = PageController(initialPage: tabIndex);
    _printUserInfo();
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
