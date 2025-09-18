// import 'package:alyse_roe/app/modules/authentication/controller/all_school_controller.dart';
// import 'package:alyse_roe/app/modules/authentication/controller/sign_up_controller.dart';
// import 'package:alyse_roe/app/modules/authentication/model/all_school_model.dart';
// import 'package:alyse_roe/app/modules/authentication/views/add_profile_image_screen.dart';
// import 'package:alyse_roe/app/modules/authentication/views/sign_in_screen.dart';
// import 'package:alyse_roe/app/modules/authentication/widget/agree_condition_widget.dart';
// import 'package:alyse_roe/app/modules/authentication/widget/auth_footer.dart';
// import 'package:alyse_roe/app/modules/authentication/widget/auth_header_widget.dart';
// import 'package:alyse_roe/app/modules/authentication/widget/continue_elevated_button.dart';
// import 'package:alyse_roe/app/modules/authentication/widget/label_name_widget.dart';
// import 'package:alyse_roe/app/modules/authentication/widget/liner_widger.dart';
// import 'package:alyse_roe/app/res/app_images/assets_path.dart';
// import 'package:alyse_roe/app/res/common_widgets/custom_elevated_button.dart';
// import 'package:alyse_roe/app/res/common_widgets/old/custom_snackbar.dart';
// import 'package:alyse_roe/app/res/custom_style/custom_size.dart';
// import 'package:crash_safe_image/crash_safe_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SignUpScreen extends StatefulWidget {
//   final String? districtId;
//   final String imagePath;
//   const SignUpScreen({super.key, this.districtId, required this.imagePath});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController firstNameCtrl = TextEditingController();
//   final TextEditingController lastNameCtrl = TextEditingController();
//   final TextEditingController emailCtrl = TextEditingController();
//   final TextEditingController roomNoCtrl = TextEditingController(); 
//   final TextEditingController passwordCtrl = TextEditingController();
//   final TextEditingController confirmPasswordCtrl = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final AllSchoolController allSchoolController = Get.put(
//     AllSchoolController(),
//   );
//   RxString selectedSchool = 'Please select'.obs;

//   bool _obscureText = true;
//   bool _confirmObscureText = true;
//   bool showButton = false;

//   @override
//   void initState() {
//     print('image path ${widget.imagePath}');
//     print('district id ${widget.districtId}');
//     allSchoolController.getAllSchool(widget.districtId);
//     super.initState();
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
//                 title: 'Create account',
//                 subtitle:
//                     'There are many variations of passages of Lorem Ipsum available, but the majority...',
//               ),
//               heightBox20,
//               Center(
//                 child: CircleAvatar(
//                   radius: 100,
//                   backgroundImage: CrashSafeImage(widget.imagePath).provider,
//                 ),
//               ),
//               heightBox12,
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     LabelName(label: 'First name'),
//                     heightBox10,
//                     TextFormField(
//                       controller: firstNameCtrl,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       keyboardType: TextInputType.text,
//                       validator: (String? value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter first name';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(hintText: 'Enter first name'),
//                     ),
//                     heightBox14,
//                     LabelName(label: 'Last name'),
//                     heightBox10,
//                     TextFormField(
//                       controller: lastNameCtrl,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       keyboardType: TextInputType.text,
//                       validator: (String? value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter last name';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(hintText: 'Enter last name'),
//                     ),
//                     heightBox14,
//                     LabelName(label: 'School email'),
//                     heightBox10,
//                     TextFormField(
//                       controller: emailCtrl,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (String? value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter email';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(hintText: 'Enter email'),
//                     ),
//                     heightBox14,
//                     LabelName(label: 'Room number'),
//                     heightBox10,
//                     TextFormField(
//                       controller: roomNoCtrl,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       keyboardType: TextInputType.text,
//                       validator: (String? value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter room number';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Enter room number',
//                       ),
//                     ),
//                     heightBox14,
//                     LabelName(label: 'School name'),
//                     heightBox10,
//                     Obx(
//                       () => Container(
//                         height: 55.h,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50.r),
//                           color: Colors.grey.shade200,
//                         ),
//                         child: allSchoolController.inProgress
//                             ? const Center(
//                                 child: SizedBox(
//                                   width: 10,
//                                   height: 10,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                   ),
//                                 ),
//                               )
//                             : allSchoolController.errorMessage.isNotEmpty
//                             ? Center(
//                                 child: Text(
//                                   allSchoolController.errorMessage,
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 14.sp,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               )
//                             : DropdownButtonFormField<String>(
//                                 value: selectedSchool.value,
//                                 decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.symmetric(
//                                     horizontal: 20.w,
//                                     vertical: 15.h,
//                                   ),
//                                   border: InputBorder.none,
//                                 ),
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black,
//                                 ),
//                                 dropdownColor: Colors.grey.shade200,
//                                 menuMaxHeight: 300.h,
//                                 items: [
//                                   const DropdownMenuItem<String>(
//                                     value: 'Please select',
//                                     child: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal: 20.0,
//                                       ),
//                                       child: Text('Please select'),
//                                     ),
//                                   ),
//                                   ...allSchoolController.allSchoolData.map((
//                                     school,
//                                   ) {
//                                     return DropdownMenuItem<String>(
//                                       value: school.name,
//                                       child: Padding(
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 20.w,
//                                         ),
//                                         child: Text(school.name ?? ''),
//                                       ),
//                                     );
//                                   }),
//                                 ],
//                                 onChanged: (String? newValue) {
//                                   selectedSchool.value =
//                                       newValue ?? 'Please select';
//                                 },
//                                 validator: (String? value) {
//                                   if (value == null ||
//                                       value == 'Please select') {
//                                     return 'Please select a school';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                       ),
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
//                         if (value == null || value.isEmpty) {
//                           return 'Enter password';
//                         } else if (value.length < 6) {
//                           return 'Password must be at least 6 characters';
//                         }
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
//                     heightBox10,
//                     LabelName(label: 'Confirm password'),
//                     heightBox14,
//                     TextFormField(
//                       controller: confirmPasswordCtrl,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       keyboardType: TextInputType.text,
//                       obscureText: _confirmObscureText,
//                       validator: (String? value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter confirm password';
//                         } else if (value.length < 6) {
//                           return 'Password must be at least 6 characters';
//                         } else if (value != passwordCtrl.text) {
//                           return 'Passwords do not match';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Enter confirm password',
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _confirmObscureText
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _confirmObscureText = !_confirmObscureText;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     heightBox10,
//                     AgreeConditionCheck(
//                       onChanged: (value) {
//                         setState(() {
//                           showButton = value;
//                         });
//                       },
//                     ),
//                     heightBox10,
//                     CustomElevatedButton(
//                       title: 'Continue',
//                       onTap: showButton
//                           ? () async => await onTabNextScreen()
//                           : null,
//                     ),
//                     heightBox12,
//                     Liner(title: 'Continue'),
//                     heightBox10,
//                     ContinueElevatedButton(
//                       name: 'Continue with google',
//                       logoPath: AssetsPath.googleLogoUp,
//                       ontap: () {},
//                     ),
//                     heightBox10,
//                     ContinueElevatedButton(
//                       name: 'Continue with apple',
//                       logoPath: AssetsPath.appleLogo,
//                       ontap: () {},
//                     ),
//                     heightBox20,
//                     AuthenticationFooterSection(
//                       fTextName: 'Do you have an account? ',
//                       fTextColor: Color.fromARGB(255, 10, 10, 10),
//                       sTextName: 'Login',
//                       sTextColor: Colors.blue,
//                       ontap: () {
//                         Get.to(SignInScreen());
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

//   Future<void> onTabNextScreen() async {
//     if (_formKey.currentState!.validate()) {
//       final String fullName =
//           '${firstNameCtrl.text.trim()} ${lastNameCtrl.text.trim()}';
//       final AllSchoolItemModel selectedSchoolData = allSchoolController
//           .allSchoolData
//           .firstWhere(
//             (school) => school.name == selectedSchool.value,
//             orElse: () => AllSchoolItemModel(
//               id: null,
//               name: null,
//               district: null,
//               createdAt: null,
//               updatedAt: null,
//               v: null,
//             ),
//           );

//       if (selectedSchoolData.id == null) {
//         showSnackBarMessage(context, 'Please select a valid school', true);
//         return;
//       }

//       if (mounted) {
//         Get.off(
//           () => AddProfileImageScreen(
//             name: fullName,
//             email: emailCtrl.text.trim(),
//             room: roomNoCtrl.text.trim(),
//             password: passwordCtrl.text.trim(),
//             schoolName: selectedSchoolData.id ?? '',
//             discrictId: widget.districtId ?? '',
//           ),
//         );
//       }
//     }
//   }
// }
