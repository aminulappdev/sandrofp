import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/authentication/widget/label_name_widget.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController newPasswordCtrl = TextEditingController();

  // final ForgotPasswordController forgotPasswordController = Get.put(
  //   ForgotPasswordController(),
  // );

  // final ResetPasswordController resetPasswordController = Get.put(
  //   ResetPasswordController(),
  // );

  bool showButton = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Terms of Service', leading: Container()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms of Service',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox4,
              Text(
                'Welcome to Sotroca! These Terms and Conditions outline the rules and regulations for the use of our exchange platform. By accessing or using our app, you agree to these terms.',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
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
