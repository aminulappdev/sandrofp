// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:sandrofp/app/modules/authentication/widget/auth_header_widget.dart';
import 'package:sandrofp/app/modules/authentication/widget/label_name_widget.dart';
import 'package:sandrofp/app/modules/authentication/widget/liner_widger.dart';
import 'package:sandrofp/app/modules/authentication/widget/sign_up_widhet.dart';
import 'package:sandrofp/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailCtrl = TextEditingController(
    text: 'yabopa5167@dekpal.com',
  );
  final TextEditingController passwordCtrl = TextEditingController(
    text: 'password123',
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final GoogleAuthController googleAuthController = GoogleAuthController();
  //final SignInController signInController = Get.put(SignInController());

  bool _obscureText = true;
  bool showButton = false;

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
                title: 'Login',
                subtitle:
                    'There are many variations of passages of Lorem Ipsum available, but the majority...',
              ),
              heightBox20,
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelName(label: 'Email'),
                    heightBox10,
                    TextFormField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    heightBox20,
                    LabelName(label: 'Password'),
                    heightBox10,
                    TextFormField(
                      controller: passwordCtrl,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(() => ForgotPasswordScreen());
                          },
                          child: Text(
                            'Forgot password?',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffF92833),
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightBox20,
                    CustomElevatedButton(title: 'Login', onPress: () {
                      Get.to(() => DashboardScreen());
                    }),
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

  // Future<void> signIn() async {
  //   final bool isSuccess = await signInController.signIn(
  //     email: emailCtrl.text,
  //     password: passwordCtrl.text,
  //   );

  //   if (isSuccess) {
  //     if (mounted) {
  //       Get.offAll(() => MainButtomNavBar());
  //     }
  //   } else {
  //     if (mounted) {
  //       showSnackBarMessage(context, signInController.errorMessage, true);
  //     }
  //   }
  // }

  // Future<void> onTapGoogleSignIn(BuildContext context) async {
  //   final bool isSuccess = await googleAuthController.signInWithGoogle();
  //   if (isSuccess && context.mounted) {
  //     showSnackBarMessage(
  //       context,
  //       'sign_in.google_success_message',
  //     ); // Localized "Successfully logged in with Google"
  //   } else if (context.mounted) {
  //     final message =
  //         googleAuthController.errorMessage ??
  //         'sign_in.google_error_message'; // Localized "Google login failed"
  //     if (message.contains('credentials')) {
  //       await showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //           title: Text(
  //             'sign_in.account_issue_title',
  //           ), // Localized "Account Issue"
  //           content: Text(
  //             'sign_in.account_issue_message',
  //           ), // Localized "This email is already registered with email-password. Please select another Google account."
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: Text('sign_in.ok_button'), // Localized "OK"
  //             ),
  //           ],
  //         ),
  //       );
  //       await onTapGoogleSignIn(context);
  //     } else {
  //       showSnackBarMessage(context, message, true);
  //     }
  //   }
  // }
}

