import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sandrofp/app/modules/authentication/views/reset_password_screen.dart';
import 'package:sandrofp/app/modules/authentication/widget/auth_header_widget.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final ForgotPasswordController forgotPasswordController = Get.put(
  //   ForgotPasswordController(),
  // );

  bool showButton = false;

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
                title: 'Forgot password',
                subtitle: 'We will send OTP verification to you.',
              ),
              heightBox20,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightBox10,
                    TextFormField(
                      controller: emailCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: 'Enter email'),
                    ),

                    heightBox20,
                    CustomElevatedButton(
                      title: 'Sent Code',
                      onPress: () {
                        Get.to(() => ResetPasswordScreen(email: ''));
                      },
                    ),

                    heightBox12,

                    heightBox20,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> forgotPassword() async {
  //   final bool isSuccess = await forgotPasswordController.forgotPassword(
  //     email: emailCtrl.text,
  //   );

  //   if (isSuccess) {
  //     if (mounted) {
  //       Get.to(() => OtpVerifyScreen(email: emailCtrl.text, isVerify: false));
  //     }
  //   } else {
  //     if (mounted) {
  //       showSnackBarMessage(
  //         context,
  //         forgotPasswordController.errorMessage,
  //         true,
  //       );
  //     }
  //   }
  // }
}
