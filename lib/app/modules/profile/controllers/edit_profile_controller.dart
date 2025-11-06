// controllers/edit_profile_controller.dart
// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/profile/controllers/profile_controller.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/res/common_widgets/image_picker_controller.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/network_caller/network_response.dart';
import 'package:sandrofp/app/services/network_caller/validator_service.dart';
import 'package:sandrofp/app/urls.dart';

class EditProfileController extends GetxController {
  final ProfileController profileController = Get.find<ProfileController>();
  final ImagePickerHelper imagePicker = ImagePickerHelper(); // তোমার ক্লাস

  final formKey = GlobalKey<FormState>();
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final aboutCtrl = TextEditingController();

  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString networkImageUrl = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
  }

  void _loadProfile() {
    final data = profileController.profileData;
    if (data != null) {
      usernameCtrl.text = data.name ?? '';
      emailCtrl.text = data.email ?? '';
      phoneCtrl.text = data.phoneNumber ?? '';
      aboutCtrl.text = data.about ?? '';
      networkImageUrl.value = data.profile ?? '';
    }
  }

  void pickImage() {
    imagePicker.showAlertDialog(Get.context!, (File pickedFile) {
      selectedImage.value = pickedFile;
    });
  }

  void editProfile() {
    if (ValidatorService.validateAndSave(formKey)) {
      showLoadingOverLay(asyncFunction: performEditProfile, msg: 'Updating...');
    }
  }

  Future<void> performEditProfile() async {
    if (!formKey.currentState!.validate()) return;

    isLoading(true);
    try {
      print('Updating profile...');
      print('Image: ${selectedImage.value}');
      Map<String, dynamic> jsonFields = {
        'name': usernameCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
        'phone': phoneCtrl.text.trim(),
        'about': aboutCtrl.text.trim(),
      };

      final NetworkResponse response = await Get.find<NetworkCaller>()
          .patchRequest(
            Urls.updateProfileUrl,
            body: jsonFields,
            accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
            image: selectedImage.value,
            keyNameImage: 'profile',
          );

      if (response.isSuccess) {
        await profileController.getMyProfile();
        showSuccess('Profile updated!');
        Get.back();
      } else {
        showError(response.errorMessage);
      }
    } catch (e) {
      showError('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    usernameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    aboutCtrl.dispose();
    super.onClose();
  }
}
