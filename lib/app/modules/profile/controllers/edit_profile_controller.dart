// controllers/edit_profile_controller.dart
// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/profile/controllers/profile_controller.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/res/common_widgets/image_picker_controller.dart';
import 'package:sandrofp/app/services/location/address_fetcher.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/network_caller/network_response.dart';
import 'package:sandrofp/app/services/network_caller/validator_service.dart';
import 'package:sandrofp/app/urls.dart';

class EditProfileController extends GetxController {
  final ProfileController profileController = Get.find<ProfileController>();
  final ImagePickerHelper imagePicker = ImagePickerHelper();
  final formKey = GlobalKey<FormState>();
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final aboutCtrl = TextEditingController();

  // Image
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString networkImageUrl = ''.obs;

  // Location
  final Rx<LatLng?> selectedLatLng = Rx<LatLng?>(null);
  final RxString selectedAddress = ''.obs;

  // Gender
  final RxString selectedGender = ''.obs;
  final List<String> genderOptions = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];

  final RxBool isLoading = false.obs;

  void setLocation(LatLng latLng, String address) {
    selectedLatLng.value = latLng;
    selectedAddress.value = address;
  }

  void clearLocation() {
    selectedLatLng.value = null;
    selectedAddress.value = '';
  }

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
  }

  void _loadProfile() {
    final data = profileController.profileData;
    if (data != null) {
      var lat = data.location?.coordinates[0];
      var lng = data.location?.coordinates[1];
      var address = AddressHelper.getAddress(lat, lng);

      usernameCtrl.text = data.name ?? '';
      emailCtrl.text = data.email ?? '';
      phoneCtrl.text = data.phoneNumber ?? '';
      aboutCtrl.text = data.about ?? '';
      locationCtrl.text = address;
      selectedGender.value = data.gender ?? '';

      // ========= সবচেয়ে সেফ চেক =========
      final profileUrl = (data.profile ?? '').toString().trim();
      if (profileUrl.isNotEmpty && Uri.tryParse(profileUrl)?.hasScheme == true) {
        networkImageUrl.value = profileUrl;
      } else {
        networkImageUrl.value = ''; // invalid হলে খালি রাখো
      }
      // ====================================
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
      Map<String, dynamic> jsonFields = {
        'name': usernameCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
        'phone': phoneCtrl.text.trim(),
        'about': aboutCtrl.text.trim(),
        'gender': selectedGender.value,
        "location": selectedLatLng.value != null
            ? {
                "type": "Point",
                "coordinates": [
                  selectedLatLng.value!.latitude,
                  selectedLatLng.value!.longitude,
                ],
              }
            : null,
      };

      final NetworkResponse response = await Get.find<NetworkCaller>().patchRequest(
        Urls.updateProfileUrl,
        body: jsonFields,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        image: selectedImage.value,
        keyNameImage: 'profile',
      );

      if (response.isSuccess) {
        await profileController.getMyProfile();
        showSuccess('Profile updated successfully!');
        Navigator.pop(Get.overlayContext!);
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