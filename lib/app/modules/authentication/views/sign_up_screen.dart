import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/authentication/controller/sign_up_controller.dart';
import 'package:sandrofp/app/modules/authentication/widget/agree_condition_widget.dart';
import 'package:sandrofp/app/modules/authentication/widget/auth_header_widget.dart';
import 'package:sandrofp/app/modules/authentication/widget/label_name_widget.dart';
import 'package:sandrofp/app/modules/authentication/widget/liner_widger.dart';
import 'package:sandrofp/app/modules/authentication/widget/sign_in_widget.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/services/network_caller/validator_service.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox30,
                const AuthHeaderWidget(
                  title: 'Sign up',
                  subtitle:
                      'There are many variations of passages of Lorem Ipsum available, but the majority...',
                ),
                heightBox20,

                // Username
                LabelName(label: 'Username'),
                heightBox10,
                TextFormField(
                  validator: (value) => ValidatorService.validateSimpleField(
                    controller.usernameCtrl.text,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.usernameCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                  ),
                ),
                heightBox20,

                // Email
                LabelName(label: 'Email'),
                heightBox10,
                TextFormField(
                  validator: (value) => ValidatorService.validateEmailAddress(
                    controller.emailCtrl.text,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                ),
                heightBox20,

                // Phone Number
                LabelName(label: 'Phone Number'),
                heightBox10,
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,
                  controller: controller.phoneCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Enter your phone number',
                  ),
                ),
                heightBox20,

                // Password
                LabelName(label: 'Password'),
                heightBox10,
                Obx(
                  () => TextFormField(
                    validator: (value) => ValidatorService.validatePassword(
                      controller.passwordCtrl.text,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controller.passwordCtrl,
                    obscureText: controller.obscurePassword.value,
                    decoration: InputDecoration(
                      hintText: '************',

                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),
                ),
                heightBox20,

                // Confirm Password
                LabelName(label: 'Confirm password'),
                heightBox10,
                Obx(
                  () => TextFormField(
                    validator: (value) =>
                        ValidatorService.validateConfirmPassword(
                          value,
                          controller.passwordCtrl.text,
                        ),
                    controller: controller.confirmPasswordCtrl,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: controller.obscureConfirmPassword.value,
                    decoration: InputDecoration(
                      hintText: '************',

                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureConfirmPassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ), 
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                    ),
                  ),
                ),
                heightBox10,

                // Terms & Conditions
                AgreeConditionCheck(
                  onChanged: (bool value) {
                    controller.isAgree.value = value;
                  },
                ),

                heightBox20,

                Obx(
                  () => Opacity(
                    opacity: controller.isAgree.value ? 1.0 : 0.5,
                    child: CustomElevatedButton(
                      title: 'Sign up',
                      onPress: controller.isAgree.value
                          ? controller.signUp
                          : null,
                    ),
                  ),
                ),
                heightBox10,
                const Liner(title: 'Continue'),
                heightBox10,

                CustomElevatedButton(
                  color: Colors.transparent,
                  textColor: Colors.black,
                  borderColor: Colors.grey,
                  iconData: Assets.images.google.keyName,
                  title: 'Login with Google',
                  onPress: () {},
                ),

                heightBox20,
                const Center(child: SignInWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
