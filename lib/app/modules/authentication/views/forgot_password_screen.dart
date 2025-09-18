// import 'package:alyse_roe/app/modules/authentication/controller/forgot_password_controller.dart';
// import 'package:alyse_roe/app/modules/authentication/views/verification_screen.dart';
// import 'package:alyse_roe/app/modules/authentication/widget/auth_header_widget.dart';
// import 'package:alyse_roe/app/res/common_widgets/custom_elevated_button.dart';
// import 'package:alyse_roe/app/res/common_widgets/old/custom_snackbar.dart';
// import 'package:alyse_roe/app/res/custom_style/custom_size.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final TextEditingController emailCtrl = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final ForgotPasswordController forgotPasswordController = Get.put(
//     ForgotPasswordController(),
//   );

//   bool showButton = false;

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
//                 title: 'Forgot password',
//                 subtitle: 'We’ll send an OTP verification to your school email',
//               ),
//               heightBox20,
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     heightBox10,
//                     TextFormField(
//                       controller: emailCtrl,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (String? value) {
//                         if (value!.isEmpty) {
//                           return 'Enter your email';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(hintText: 'Enter email'),
//                     ),

//                     heightBox20,
//                     Obx(
//                       () => CustomElevatedButton(
//                         isLoading: forgotPasswordController.inProgress,
//                         title: 'Continue',
//                         onPressedAsync: () async {
//                           await forgotPassword();
//                         },
//                       ),
//                     ),
//                     heightBox12,

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

//   Future<void> forgotPassword() async {
//     final bool isSuccess = await forgotPasswordController.forgotPassword(
//       email: emailCtrl.text,
//     );

//     if (isSuccess) {
//       if (mounted) {
//         Get.to(() => OtpVerifyScreen(email: emailCtrl.text, isVerify: false));
//       }
//     } else {
//       if (mounted) {
//         showSnackBarMessage(
//           context,
//           forgotPasswordController.errorMessage,
//           true,
//         );
//       }
//     }
//   }
// }
