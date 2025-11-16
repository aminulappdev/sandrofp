// app/modules/authentication/views/change_password_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/authentication/widget/label_name_widget.dart';
import 'package:sandrofp/app/modules/settings/controller/change_password_controller.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/services/network_caller/validator_service.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  final String email;
  const ChangePasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    // Controller inject
    final controller = Get.put(ChangePasswordController());

    return Scaffold(
      appBar: CustomAppBar(title: 'Change Password', leading: Container()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelName(label: 'Old Password'),
                heightBox8,
                Obx(
                  () => TextFormField(
                    controller: controller.passwordCtrl,
                    obscureText: controller.obscurePassword.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: 'Enter old password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) => ValidatorService.validatePassword(
                      controller.passwordCtrl.text,
                    ),
                  ),
                ),

                heightBox20,
                LabelName(label: 'New Password'),
                heightBox8,
                Obx(
                  () => TextFormField(
                    controller: controller.confirmPasswordCtrl,
                    obscureText: controller.obscureConfirm.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: 'new password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureConfirm.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: controller.toggleConfirmVisibility,
                      ),
                    ),
                    validator: (value) => ValidatorService.validatePassword(
                      controller.passwordCtrl.text,
                    ),
                  ),
                ),

                heightBox40,

                Obx(
                  () => CustomElevatedButton(
                    title: 'Change Password',
                    onPress: controller.isLoading.value
                        ? null
                        : controller.changePassword,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
