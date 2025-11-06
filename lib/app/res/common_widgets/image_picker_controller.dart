// image_picker_helper.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class ImagePickerHelper {
  // Function to pick an image from the camera
  Future<void> pickImageFromCamera(
      BuildContext context, Function(File) onImagePicked) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        onImagePicked(File(pickedImage.path));
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    } finally {
      if (Navigator.canPop(context)) Navigator.pop(context);
    }
  }

  // Function to pick an image from the gallery
  Future<void> pickImageFromGallery(
      BuildContext context, Function(File) onImagePicked) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        onImagePicked(File(pickedImage.path));
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    } finally {
      if (Navigator.canPop(context)) Navigator.pop(context); // Close the dialog
    }
  }

  // Function to show the image picker dialog
  Future<void> showAlertDialog(
      BuildContext context, Function(File) onImagePicked) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SizedBox(
            height: 150.h,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      pickImageFromCamera(context, onImagePicked);
                    },
                    child: Row(
                      
                      children: [
                        Icon(Icons.camera_alt, size: 30.sp),
                        widthBox10,
                        Text(
                          'Take a Photo',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  heightBox12,
                  InkWell(
                    onTap: () {
                      pickImageFromGallery(context, onImagePicked);
                    },
                    child: Row(
                     
                      children: [
                        Icon(Icons.image, size: 30.sp),
                        widthBox10,
                        Text(
                          'Choose from Gallery',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  heightBox12,
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: const Color.fromARGB(255, 77, 76, 76),
                  ),
                  heightBox12,
                  InkWell(
                    onTap: () {
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
