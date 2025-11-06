// forgot_password_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/authentication/controller/forget_password_controller.dart';
import 'package:sandrofp/app/modules/authentication/widget/auth_header_widget.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/services/network_caller/validator_service.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
   
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox30,

                // Header
                const AuthHeaderWidget(
                  title: 'Forgot Password',
                  subtitle: 'Enter your email to receive a reset link.',
                ),

                heightBox30,

                // Email Field
                 TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.emailCtrl,
                      validator: ValidatorService.validateEmailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                    ),

                heightBox30,

                // Submit Button
                Obx(() => CustomElevatedButton(
                      title: 'Send email',
                      onPress: controller.isLoading.value
                          ? null
                          : controller.forgotPassword,
                    )),

                heightBox20,
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}