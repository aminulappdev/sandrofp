// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/authentication/controller/sign_in_controller.dart';
import 'package:sandrofp/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:sandrofp/app/modules/authentication/widget/auth_header_widget.dart';
import 'package:sandrofp/app/modules/authentication/widget/label_name_widget.dart';
import 'package:sandrofp/app/modules/authentication/widget/liner_widger.dart';
import 'package:sandrofp/app/modules/authentication/widget/sign_up_widget.dart'; 
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/services/network_caller/validator_service.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox30,
              AuthHeaderWidget(
                showBackButton: false,
                title: 'Login',
                subtitle:
                    'There are many variations of passages of Lorem Ipsum available, but the majority...',
              ),
              heightBox20,

              Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelName(label: 'Email'),
                    heightBox10,
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.emailCtrl,
                      validator: ValidatorService.validateEmailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                    ),
                    heightBox20,

                    LabelName(label: 'Password'),
                    heightBox10,
                    Obx(
                      () => TextFormField(
                        controller: controller.passwordCtrl,
                        obscureText: controller.obscureText.value,
                        decoration: InputDecoration(
                          hintText: '*********',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                      ),
                    ),
                    heightBox10,
 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(() => const ForgotPasswordScreen());
                          },
                          child: Text(
                            'Forgot password?',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffF92833),
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightBox20,

                    CustomElevatedButton(
                      title: 'Login',
                      onPress: controller.signIn,
                    ),
                    heightBox30,

                    Liner(title: 'or'),
                    heightBox10,

                    CustomElevatedButton(
                      color: Colors.transparent,
                      textColor: Colors.black,
                      borderColor: Colors.grey,
                      iconData: Assets.images.google.keyName,
                      title: 'Login with Google',
                      onPress: () {},
                    ),
                    heightBox30,

                    Center(child: SignUpWidget()),
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
