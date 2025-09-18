// // ignore_for_file: deprecated_member_use

// import 'package:alyse_roe/app/modules/authentication/controller/forgot_password_controller.dart';
// import 'package:alyse_roe/app/modules/authentication/controller/otp_verify_controller.dart';
// import 'package:alyse_roe/app/modules/authentication/views/reset_password_screen.dart';
// import 'package:alyse_roe/app/modules/authentication/views/sign_in_screen.dart';
// import 'package:alyse_roe/app/modules/authentication/widget/auth_header_widget.dart';
// import 'package:alyse_roe/app/res/common_widgets/custom_elevated_button.dart';
// import 'package:alyse_roe/app/res/common_widgets/old/custom_snackbar.dart';
// import 'package:alyse_roe/app/res/custom_style/custom_size.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'dart:async';

// class OtpVerifyScreen extends StatefulWidget {
//   final String email;
//   final bool isVerify;
//   const OtpVerifyScreen({
//     super.key,
//     required this.email,
//     required this.isVerify,
//   });

//   @override
//   State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
// }

// class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
//   final TextEditingController pinCodeCtrl = TextEditingController();
//   final OtpVerifyController otpVerifyController = Get.put(
//     OtpVerifyController(),
//   );
//   final ForgotPasswordController forgotPasswordController = Get.put(
//     ForgotPasswordController(),
//   );
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   // Timer-related variables
//   Timer? _timer;
//   int _secondsRemaining = 60;
//   bool _canResend = false;

//   @override
//   void initState() {
//     super.initState();
//     _startTimer(); // Start the countdown timer when the screen loads
//   }

//   @override
//   void dispose() {
//     _timer?.cancel(); // Cancel the timer to prevent memory leaks
//     pinCodeCtrl.dispose();
//     super.dispose();
//   }

//   // Start the 60-second countdown timer
//   void _startTimer() {
//     _canResend = false;
//     _secondsRemaining = 60;
//     _timer?.cancel(); // Cancel any existing timer
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_secondsRemaining <= 0) {
//         timer.cancel();
//         setState(() {
//           _canResend = true; // Enable resend button when timer expires
//         });
//       } else {
//         setState(() {
//           _secondsRemaining--;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               heightBox30,
//               AuthHeader(
//                 title: 'Provide code',
//                 subtitle:
//                     'Please check your school email for the OTP Verification code',
//               ),
//               heightBox20,
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     heightBox10,
//                     PinCodeTextField(
//                       length: 6,
//                       obscureText: false,
//                       controller: pinCodeCtrl,
//                       keyboardType: TextInputType.number,
//                       animationType: AnimationType.fade,
//                       animationDuration: const Duration(milliseconds: 300),
//                       onChanged: (value) {},
//                       pinTheme: PinTheme(
//                         selectedColor: Colors.black,
//                         activeColor: Colors.grey,
//                         borderWidth: 0.5,
//                         shape: PinCodeFieldShape.circle,
//                         borderRadius: BorderRadius.circular(100.r),
//                         inactiveColor: Colors.grey,
//                         fieldHeight: 50.h,
//                         fieldWidth: 50.h,
//                         activeFillColor: Colors.white,
//                         inactiveFillColor: const Color(
//                           0xffD9A48E,
//                         ).withOpacity(0.1),
//                         selectedFillColor: Colors.white,
//                       ),
//                       backgroundColor: Colors.transparent,
//                       enableActiveFill: true,
//                       appContext: context,
//                     ),
//                     heightBox20,
//                     Obx(
//                       () => CustomElevatedButton(
//                         isLoading: otpVerifyController.inProgress,
//                         title: 'Continue',
//                         onPressedAsync: () async {
//                           await otpVerify();
//                         },
//                       ),
//                     ),
//                     heightBox20,
//                     Center(
//                       child: Column(
//                         children: [
//                           Text('Did not receive the code?'),
//                           _canResend
//                               ? TextButton(
//                                   onPressed: () async => await resendOtp(),
//                                   child: const Text(
//                                     'Resend OTP',
//                                     style: TextStyle(color: Colors.blue),
//                                   ),
//                                 )
//                               : Text(
//                                   'Time left: 00:${_secondsRemaining.toString().padLeft(2, '0')}',
//                                   style: const TextStyle(color: Colors.blue),
//                                 ),
//                         ],
//                       ),
//                     ),
//                     heightBox20,
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> otpVerify() async {
//     final bool isSuccess = await otpVerifyController.otpVerify(
//       email: widget.email,
//       otp: pinCodeCtrl.text,
//       isVerify: widget.isVerify,
//     );

//     if (isSuccess) {
//       if (mounted) {
//         if (widget.isVerify) {
//           Get.offAll(() => const SignInScreen());
//         } else {
//           Get.to(() => ResetPasswordScreen(email: widget.email));
//         }
//       }
//     } else {
//       if (mounted) {
//         showSnackBarMessage(context, otpVerifyController.errorMessage, true);
//       }
//     }
//   }

//   Future<void> resendOtp() async {
//     try {
//       final bool isSuccess = await forgotPasswordController.forgotPassword(
//         email: widget.email,
//       );

//       if (isSuccess) {
//         if (mounted) {
//           showSnackBarMessage(context, 'OTP resent successfully');
//           _startTimer(); // Restart the timer after successful resend
//         }
//       } else {
//         if (mounted) {
//           showSnackBarMessage(
//             context,
//             forgotPasswordController.errorMessage,
//             true,
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         showSnackBarMessage(context, 'An error occurred: $e', true);
//       }
//     }
//   }
// }
