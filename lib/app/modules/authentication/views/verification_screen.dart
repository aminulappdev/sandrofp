// otp_verify_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sandrofp/app/modules/authentication/controller/otp_verify_controller.dart';
import 'package:sandrofp/app/modules/authentication/widget/auth_header_widget.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class OtpVerifyScreen extends GetView<OtpVerifyController> {
  const OtpVerifyScreen({super.key});

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
              const AuthHeaderWidget(
                title: 'Provide code',
                subtitle: 'We will send OTP verification to you.',
              ),
              heightBox20,
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    heightBox10, 
                    PinCodeTextField(
                      length: 6,
                      controller: controller.pinCtrl,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        borderRadius: BorderRadius.circular(100.r),
                        fieldHeight: 50.h,
                        fieldWidth: 50.h,
                        activeColor: Colors.grey,
                        inactiveColor: Colors.grey,
                        selectedColor: Colors.black,
                        activeFillColor: Colors.white,
                        inactiveFillColor: const Color(
                          0xffD9A48E,
                        ).withValues(alpha: 0.1),
                        selectedFillColor: Colors.white,
                      ),
                      enableActiveFill: true,
                      backgroundColor: Colors.transparent,
                      appContext: context,
                      onChanged: (v) {},
                    ),

                    heightBox20,

                    CustomElevatedButton(
                      title: 'Verify',
                      onPress: controller.verifyOtp,
                    ),
                    heightBox8,
                    Center(
                      child: Obx(() {
                        if (controller.canResend.value) {
                          return TextButton(
                            onPressed: controller.resendOtp,
                            child: const Text(
                              'Send code again',
                              style: TextStyle(color: AppColors.greenColor),
                            ),
                          );
                        }
                        return Text(
                          'Time left: 00:${controller.secondsRemaining.value.toString().padLeft(2, '0')}',
                          style: const TextStyle(color: AppColors.greenColor),
                        );
                      }),
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
