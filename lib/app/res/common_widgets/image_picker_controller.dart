// app/res/common_widgets/image_picker_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  // === তোমার আগের ফাংশন (অপরিবর্তিত) ===
  void showAlertDialog(BuildContext context, Function(File) onImagePicked) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Select Image Source"),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final picked = await ImagePicker().pickImage(
                source: ImageSource.camera,
                imageQuality: 85,
              );
              if (picked != null) {
                onImagePicked(File(picked.path));
              }
            },
            child: const Text("Camera"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final pickedImages = await ImagePicker().pickMultiImage(
                imageQuality: 85,
              );
              if (pickedImages.isNotEmpty) {
                for (var img in pickedImages) {
                  onImagePicked(File(img.path));
                }
              }
            },
            child: const Text("Gallery"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // === নতুন ফাংশন: শুধু মাল্টিপল ইমেজ (Gallery) ===
  /// শুধু Gallery থেকে একাধিক ছবি সিলেক্ট করবে
  /// কোনো ডায়ালগ দেখাবে না – সরাসরি Gallery খুলবে
  Future<void> showMultiImagePicker(
    BuildContext context,
    Function(File) onImagePicked,
  ) async {
    try {
      final pickedImages = await ImagePicker().pickMultiImage(
        imageQuality: 85,
      );

      if (pickedImages.isNotEmpty) {
        for (var img in pickedImages) {
          onImagePicked(File(img.path));
        }
      }
    } catch (e) {
      debugPrint("Multi Image Picker Error: $e");
      // অপশনাল: স্ন্যাকবার দেখাতে পারো
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to pick images")),
      );
    }
  }

  // === অপশনাল: ক্যামেরা + গ্যালারি ছাড়া শুধু গ্যালারি (ডায়ালগ সহ) ===
  void showGalleryOnlyDialog(BuildContext context, Function(File) onImagePicked) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Choose from Gallery"),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final pickedImages = await ImagePicker().pickMultiImage(
                imageQuality: 85,
              );
              if (pickedImages.isNotEmpty) {
                for (var img in pickedImages) {
                  onImagePicked(File(img.path));
                }
              }
            },
            child: const Text("Select Multiple"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}