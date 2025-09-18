// import 'package:alyse_roe/app/modules/authentication/controller/google_auth_controller.dart';
// import 'package:alyse_roe/app/modules/authentication/controller/sign_in_controller.dart';
// import 'package:alyse_roe/app/modules/authentication/views/forgot_password_screen.dart';
// import 'package:alyse_roe/app/modules/authentication/widget/auth_footer.dart';
// import 'package:alyse_roe/app/modules/authentication/widget/auth_header_widget.dart';
// import 'package:alyse_roe/app/modules/authentication/widget/continue_elevated_button.dart';
// import 'package:alyse_roe/app/modules/authentication/widget/label_name_widget.dart';
// import 'package:alyse_roe/app/modules/authentication/widget/liner_widger.dart';
// import 'package:alyse_roe/app/modules/common/views/main_buttom_nav_bar.dart';
// import 'package:alyse_roe/app/modules/onboarding/views/district_screen.dart';
// import 'package:alyse_roe/app/res/app_images/assets_path.dart';
// import 'package:alyse_roe/app/res/common_widgets/custom_elevated_button.dart';
// import 'package:alyse_roe/app/res/common_widgets/old/custom_snackbar.dart';
// import 'package:alyse_roe/app/res/custom_style/custom_size.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final TextEditingController emailCtrl = TextEditingController(
//     text: 'yabopa5167@dekpal.com',
//   );
//   final TextEditingController passwordCtrl = TextEditingController(
//     text: 'password123',
//   );
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final GoogleAuthController googleAuthController = GoogleAuthController();

//   final SignInController signInController = Get.put(SignInController());

//   bool _obscureText = true;
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
//                 title: 'Login',
//                 subtitle:
//                     'There are many variations of passages of Lorem Ipsum available, but the majority...',
//               ),
//               heightBox20,
//               Center(
//                 child: Image.asset(
//                   AssetsPath.onboarding1,
//                   height: 150,
//                   width: 150,
//                 ),
//               ),
//               heightBox12,
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     LabelName(label: 'School email'),
//                     heightBox10,
//                     TextFormField(
//                       controller: emailCtrl,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (String? value) {
//                         if (value!.isEmpty) {
//                           return 'Enter email';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(hintText: 'Enter email'),
//                     ),
//                     heightBox14,
//                     LabelName(label: 'Password'),
//                     heightBox10,
//                     TextFormField(
//                       controller: passwordCtrl,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       keyboardType: TextInputType.text,
//                       obscureText: _obscureText,
//                       validator: (String? value) {
//                         if (value!.isEmpty) {
//                           return 'Enter password';
//                         }
//                         // ignore: curly_braces_in_flow_control_structures
//                         else if (value.length < 6)
//                           // ignore: curly_braces_in_flow_control_structures
//                           return 'Password must be at least 6 characters';
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Enter password',
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscureText
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureText = !_obscureText;
//                             });
//                           },
//                         ),
//                       ),
//                     ),

//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {
//                           Get.to(ForgotPasswordScreen());
//                         },
//                         child: Text(
//                           'Forget your password?',
//                           style: GoogleFonts.poppins(
//                             color: Colors.blue,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                     heightBox10,
//                     Obx(
//                       () => CustomElevatedButton(
//                         isLoading: signInController.inProgress,
//                         title: 'Continue',
//                         onPressedAsync: () async {
//                           signIn();
//                         },
//                       ),
//                     ),
//                     heightBox12,
//                     Liner(title: 'Or'),
//                     heightBox10,
//                     ContinueElevatedButton(
//                       name: 'Continue with google',
//                       logoPath: AssetsPath.googleLogoUp,
//                       ontap: () {
//                         onTapGoogleSignIn(context);
//                       },
//                     ),
//                     // heightBox10,
//                     // ContinueElevatedButton(
//                     //   name: 'Continue with apple',
//                     //   logoPath: AssetsPath.appleLogo,
//                     //   ontap: () {},
//                     // ),
//                     heightBox20,
//                     AuthenticationFooterSection(
//                       fTextName: 'Don\'t you have an account? ',
//                       fTextColor: Color.fromARGB(255, 10, 10, 10),
//                       sTextName: 'Signup',
//                       sTextColor: Colors.blue,
//                       ontap: () {
//                         Get.to(DistrictScreen());
//                       },
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

//   Future<void> signIn() async {
//     final bool isSuccess = await signInController.signIn(
//       email: emailCtrl.text,
//       password: passwordCtrl.text,
//     );

//     if (isSuccess) {
//       if (mounted) {
//         Get.offAll(() => MainButtomNavBar());
//       }
//     } else {
//       if (mounted) {
//         showSnackBarMessage(context, signInController.errorMessage, true);
//       }
//     }
//   }

//   Future<void> onTapGoogleSignIn(BuildContext context) async {
//     final bool isSuccess = await googleAuthController.signInWithGoogle();
//     if (isSuccess && context.mounted) {
//       showSnackBarMessage(
//         context,
//         'sign_in.google_success_message',
//       ); // Localized "Successfully logged in with Google"
//     } else if (context.mounted) {
//       final message =
//           googleAuthController.errorMessage ??
//           'sign_in.google_error_message'; // Localized "Google login failed"
//       if (message.contains('credentials')) {
//         await showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: Text(
//               'sign_in.account_issue_title',
//             ), // Localized "Account Issue"
//             content: Text(
//               'sign_in.account_issue_message',
//             ), // Localized "This email is already registered with email-password. Please select another Google account."
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('sign_in.ok_button'), // Localized "OK"
//               ),
//             ],
//           ),
//         );
//         await onTapGoogleSignIn(context);
//       } else {
//         showSnackBarMessage(context, message, true);
//       }
//     }
//   }
// }
