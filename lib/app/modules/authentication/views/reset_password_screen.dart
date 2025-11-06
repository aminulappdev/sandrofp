// reset_password_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/authentication/controller/reset_password_controller.dart';
import 'package:sandrofp/app/modules/authentication/widget/auth_header_widget.dart';
import 'package:sandrofp/app/modules/authentication/widget/label_name_widget.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/services/network_caller/validator_service.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox30,
              AuthHeaderWidget(
                title: 'Reset Password',
                subtitle: 'Enter your new password below',
              ),
              heightBox30,

              Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelName(label: 'New Password'),
                    heightBox8,
                    Obx(
                      () => TextFormField(
                        controller: controller.passwordCtrl,
                        obscureText: controller.obscurePassword.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'Enter new password',
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
                    LabelName(label: 'Confirm Password'),
                    heightBox8,
                    Obx(
                      () => TextFormField(
                        controller: controller.confirmPasswordCtrl,
                        obscureText: controller.obscureConfirm.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'Re-enter password',
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
                        validator: (value) =>
                            ValidatorService.validateConfirmPassword(
                              value,
                              controller.passwordCtrl.text,
                            ),
                      ),
                    ),

                    heightBox40,

                    Obx(
                      () => CustomElevatedButton(
                        title: 'Reset Password',
                        onPress: controller.isLoading.value
                            ? null
                            : controller.resetPassword,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
