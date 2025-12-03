// screens/edit_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sandrofp/app/modules/authentication/widget/label_name_widget.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/services/location/location_picker_field.dart';
import 'package:sandrofp/app/services/location/location_services.dart';
import 'package:sandrofp/gen/assets.gen.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller initialize (যদিও Get.put আগে থেকে আছে, তবু নিশ্চিত করার জন্য)
    Get.put(EditProfileController());

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile',
        leading: Container(),
        isBack: true,
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox30,

              // Profile Picture with Camera Button
              Center(
                child: Obx(
                  () => Stack(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: const Color(0xffF3F3F5),
                        child: CircleAvatar(
                          radius: 76,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 72,
                            backgroundImage: _getImageProvider(),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: controller.pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.greenColor,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              heightBox40,

              // Username
              LabelName(label: 'Username'),
              heightBox8,
              TextFormField(
                controller: controller.usernameCtrl,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Enter username' : null,
                decoration: const InputDecoration(
                  hintText: 'Enter your username',
                  border: OutlineInputBorder(),
                ),
              ),

              heightBox20,

              // Email
              LabelName(label: 'Email'),
              heightBox8,
              TextFormField(
                controller: controller.emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Enter email' : null,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
              ),

              heightBox20,

              // Phone Number
              LabelName(label: 'Phone Number'),
              heightBox8,
              TextFormField(
                controller: controller.phoneCtrl,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.trim().isEmpty ? 'Enter phone number' : null,
                decoration: const InputDecoration(
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                ),
              ),

              heightBox20,

              // Email
              heightBox20,

              // Location
              LabelName(label: 'Location'),
              heightBox8,

              // Email
              Obx(() {
                if (controller.selectedLatLng.value != null) {
                  return Container();
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormField(
                        controller: controller.locationCtrl,

                        keyboardType: TextInputType.emailAddress,
                        enabled: false,
                      ),
                    ],
                  );
                  ;
                }
              }),

              heightBox20,
              Obx(
                () => LocationField(
                  address: controller.selectedAddress.value,
                  onPick: () async {
                    final pos =
                        controller.selectedLatLng.value ??
                        LatLng(23.8103, 90.4125);
                    final res = await Get.to(
                      () => LocationPickerScreen(initialPosition: pos),
                    );
                    if (res is Map) {
                      controller.setLocation(res['latLng'], res['address']);
                    }
                  },
                  onClear: controller.clearLocation,
                ),
              ),

              heightBox20,

              // Gender Dropdown
              LabelName(label: 'Gender'),
              heightBox8,
              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.selectedGender.value.isEmpty
                      ? null
                      : controller.selectedGender.value,
                  hint: const Text('Select your gender'),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                  ),
                  items: controller.genderOptions
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedGender.value = value;
                    }
                  },
                  validator: (value) =>
                      value == null ? 'Please select gender' : null,
                ),
              ),

              heightBox20,

              // About User
              LabelName(label: 'About you'),
              heightBox8,
              TextFormField(
                controller: controller.aboutCtrl,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Tell us about yourself',
                  border: OutlineInputBorder(),
                ),
              ),

              heightBox40,

              // Save Button
              Obx(
                () => CustomElevatedButton(
                  title: 'Save Changes',
                  onPress: controller.isLoading.value
                      ? null
                      : controller.editProfile,
                ),
              ),

              heightBox30,
            ],
          ),
        ),
      ),
    );
  }

  // Image Provider (Local / Network / Asset)
  ImageProvider _getImageProvider() {
    if (controller.selectedImage.value != null) {
      return FileImage(controller.selectedImage.value!);
    } else if (controller.networkImageUrl.value.isNotEmpty) {
      return NetworkImage(controller.networkImageUrl.value);
    } else {
      return AssetImage(Assets.images.profile.path);
    }
  }
}
