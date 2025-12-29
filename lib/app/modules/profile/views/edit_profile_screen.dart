// screens/edit_profile_screen.dart - ULTIMATE CRASH-FREE VERSION
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/authentication/widget/label_name_widget.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  // সবচেয়ে সেফ ইমেজ প্রোভাইডার
   ImageProvider _safeImageProvider() {
    if (controller.selectedImage.value != null &&
        controller.selectedImage.value!.existsSync()) {
      return FileImage(controller.selectedImage.value!);
    }

    final url = controller.networkImageUrl.value.trim();
    if (url.isNotEmpty && Uri.tryParse(url)?.hasScheme == true) {
      return NetworkImage(url);
    }

    return AssetImage(Assets.images.profile.path);
  }

  @override
  Widget build(BuildContext context) {
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

              // Profile Picture - কখনো ক্র্যাশ করবে না
              Center(
                child: Obx(
                  () => Stack(
                    children: [
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          image: DecorationImage(
                            image: _safeImageProvider(),
                            fit: BoxFit.cover,
                            onError:
                                (
                                  exception,
                                  stackTrace,
                                ) {}, // সাইলেন্ট এরর হ্যান্ডলিং
                          ),
                        ),
                        child: _safeImageProvider() is AssetImage
                            ? const Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.grey,
                              )
                            : null,
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

              const LabelName(label: 'Username'),
              heightBox8,
              TextFormField(
                controller: controller.usernameCtrl,
                validator: (v) => v!.trim().isEmpty ? 'Enter username' : null,
                decoration: const InputDecoration(
                  hintText: 'Enter your username',
                  border: OutlineInputBorder(),
                ),
              ),

              heightBox20,
              const LabelName(label: 'Email'),
              heightBox8,
              TextFormField(
                controller: controller.emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v!.trim().isEmpty ? 'Enter email' : null,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
              ),

              heightBox20,
              const LabelName(label: 'Phone Number'),
              heightBox8,
              TextFormField(
                controller: controller.phoneCtrl,
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v!.trim().isEmpty ? 'Enter phone number' : null,
                decoration: const InputDecoration(
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                ),
              ),

              heightBox20,
              const LabelName(label: 'About you'),
              heightBox8,
              TextFormField(
                controller: controller.aboutCtrl,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Tell us about yourself',
                  border: OutlineInputBorder(),
                ),
              ),

              // ====== নতুন যোগ করা Gender ফিল্ড ======
              heightBox20,
              const LabelName(label: 'Gender'),
              heightBox8,
              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.selectedGender.value.isEmpty
                      ? null
                      : controller.selectedGender.value,
                  hint: const Text('Select your gender'),
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null ? 'Please select gender' : null,
                ),
              ),

              heightBox40,

              Obx(
                () => CustomElevatedButton(
                  title: controller.isLoading.value
                      ? 'Saving...'
                      : 'Save Changes',
                  onPress: controller.isLoading.value
                      ? null
                      : controller.editProfile,
                ),
              ),

              heightBox50,
            ],
          ),
        ),
      ),
    );
  }
}
