// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AddProfileImageScreen extends StatefulWidget {
//   final String name, email, room, password, schoolName, discrictId;
//   const AddProfileImageScreen({
//     super.key,
//     required this.name,
//     required this.email,
//     required this.room,
//     required this.password,
//     required this.schoolName,
//     required this.discrictId,
//   });

//   @override
//   State<AddProfileImageScreen> createState() => _AddProfileImageScreenState();
// }

// class _AddProfileImageScreenState extends State<AddProfileImageScreen> {
//   final SignUpController signUpController = Get.put(SignUpController());
//   final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
//   File? _selectedImage; // Store the selected image file

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             heightBox30,
//             CustomAppBar(title: 'Add Profile Image'),
//             heightBox12,
//             Text(
//               '1 Photo required',
//               style: GoogleFonts.poppins(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             heightBox12,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CustomIconContainer(
//                   isSelected: false,
//                   iconHeight: 48,
//                   title: 'Take a picture',
//                   imagePath: AssetsPath.takePhoto,
//                   ontap: () {
//                     _imagePickerHelper.pickImageFromCamera(context, (
//                       File image,
//                     ) {
//                       setState(() {
//                         _selectedImage = image; // Save the selected image
//                       });
//                     });
//                   },
//                 ),
//                 CustomIconContainer(
//                   isSelected: false,
//                   iconHeight: 48,
//                   title: 'Upload a pic',
//                   imagePath: AssetsPath.uploadPhoto,
//                   ontap: () {
//                     _imagePickerHelper.pickImagesFromGallery(context, (
//                       File image,
//                     ) {
//                       setState(() {
//                         _selectedImage = image; // Save the selected image
//                       });
//                     });
//                   },
//                 ),
//               ],
//             ),
//             heightBox12,
//             // Display the selected image below the buttons
//             if (_selectedImage != null)
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 10.h),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.r),
//                   border: Border.all(color: Colors.grey, width: 1),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10.r),
//                   child: Image.file(
//                     _selectedImage!,
//                     height: 150.h,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             if (_selectedImage == null)
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 10.h),
//                 height: 150.h,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(10.r),
//                   border: Border.all(color: Colors.grey, width: 1),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'No Image Selected',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14.sp,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//             heightBox40,
//             Obx(
//               () => CustomElevatedButton(
//                 isLoading: signUpController.inProgress,
//                 title: 'Done',
//                 onPressedAsync: () async {
//                   if (_selectedImage == null) {
//                     showSnackBarMessage(
//                       context,
//                       'Please select an image',
//                       true,
//                     );
//                     return;
//                   }
//                   await signUp();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> signUp() async {
//     final bool isSuccess = await signUpController.signUp(
//       name: widget.name,
//       schoolName: widget.schoolName,
//       email: widget.email,
//       room: widget.room,
//       password: widget.password,
//       discrictId: widget.discrictId,
//       image: _selectedImage, // Pass the selected image to the controller
//     );

//     if (isSuccess) {
//       if (mounted) {
//         Get.to(() => OtpVerifyScreen(email: widget.email, isVerify: true));
//       }
//     } else {
//       if (mounted) {
//         showSnackBarMessage(context, signUpController.errorMessage, true);
//       }
//     }
//   }
// }
