// app/modules/dashboard/controller/dashboard_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/chat/controller/all_friend_controller.dart';
import 'package:sandrofp/app/modules/profile/controllers/profile_controller.dart';

class DashboardController extends GetxController {
  final ProfileController profileController = Get.find<ProfileController>();
  final FriendController friendController = Get.put(FriendController());

  // সবসময় Home tab (index 2) দিয়ে শুরু
  final RxInt _tabIndex = 2.obs;
  int get tabIndex => _tabIndex.value;
  set tabIndex(int v) => _tabIndex.value = v;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    print('ON INIT CALL DASHBOARD');

    // সবসময় Home দিয়ে initialize
    tabIndex = 2;
    pageController = PageController(initialPage: 2);

    // ডাটা লোড
    loadInitialData();
    profileController.getMyProfile();

    _printUserInfo();
  }

  Future<void> loadInitialData() async {
    await friendController.getAllFriends();
    // অন্যান্য প্রয়োজনীয় ডাটা লোড করতে পারো
  }

  void _printUserInfo() {
    var userId = StorageUtil.getData(StorageUtil.userId);
    var token = StorageUtil.getData(StorageUtil.userAccessToken);
    print('USER ID: $userId  TOKEN: $token');
  }

  // User tap করলে tab + page change
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
