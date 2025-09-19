import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sandrofp/app/modules/authentication/views/sign_in_screen.dart';
import 'package:sandrofp/app/modules/authentication/widget/auth_header_widget.dart';
import 'package:sandrofp/app/modules/authentication/widget/label_name_widget.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController newPasswordCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final ForgotPasswordController forgotPasswordController = Get.put(
  //   ForgotPasswordController(),
  // );

  // final ResetPasswordController resetPasswordController = Get.put(
  //   ResetPasswordController(),
  // );

  bool _obscureText = true;
  bool _confirmObscureText = true;
  bool showButton = false;

  @override
  void initState() {
    print('is email ${widget.email}');
    super.initState();
  }

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
                title: 'Reset password',
                subtitle: 'We’ll send an OTP verification to your school email',
              ),
              heightBox20,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightBox10,

                    LabelName(label: 'Password'),
                    heightBox10,
                    TextFormField(
                      controller: passwordCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      obscureText: _obscureText,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                    heightBox10,
                    LabelName(label: 'Confirm password'),
                    heightBox14,
                    TextFormField(
                      controller: newPasswordCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      obscureText: _confirmObscureText,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter confirm password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        } else if (value != passwordCtrl.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter confirm password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmObscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmObscureText = !_confirmObscureText;
                            });
                          },
                        ),
                      ),
                    ),

                    heightBox20,
                    CustomElevatedButton(
                      title: 'Continue',
                      onPress: ()  {
                        Get.to(() => SignInScreen());
                      },
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

  // Future<void> resetPassword() async {
  //   final bool isSuccess = await resetPasswordController.resetPassword(
  //     email: widget.email,
  //     password: newPasswordCtrl.text,
  //   );

  //   if (isSuccess) {
  //     if (mounted) {
  //       Get.to(() => SignInScreen());
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
