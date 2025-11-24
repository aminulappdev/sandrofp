// sandrofp/app/modules/chat/widgets/chatting_field.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/chat/controller/image_decode_controller.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/res/common_widgets/image_picker_controller.dart';

class ChattingFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Function(bool)? onFocusChange;

  const ChattingFieldWidget({super.key, this.controller, this.onFocusChange});

  @override
  State<ChattingFieldWidget> createState() => _ChattingFieldWidgetState();
}

class _ChattingFieldWidgetState extends State<ChattingFieldWidget> {
  final ImageDecodeController imageDecodeController = Get.find<ImageDecodeController>();
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  File? _image;
  bool _isImageSelected = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      widget.onFocusChange?.call(_focusNode.hasFocus);
      print('Focus changed: ${_focusNode.hasFocus}');
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _pickAndDecodeImage() async {
    await _imagePickerHelper.showMultiImagePicker(context, (File pickedImage) async {
      setState(() {
        _image = pickedImage;
        _isImageSelected = true;
      });
      await imageDecodeController.imageDecode(image: pickedImage);
    });
  }

  void _clearImage() {
    setState(() {
      _image = null;
      _isImageSelected = false;
    });
    imageDecodeController.imageUrl = '';
    
  }

  void _sendMessage() {
    if (widget.controller!.text.trim().isNotEmpty || imageDecodeController.imageUrl.isNotEmpty) {
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.r),
            border: Border.all(color: Colors.grey.shade400, width: 1.w),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.h),
            child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: imageDecodeController.imageUrl.isNotEmpty ? 'Write a caption' : 'Write message',
                hintStyle: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.grey.shade600),
                prefixIcon: Obx(() => imageDecodeController.inProgress
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 20, height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : InkWell(
                        onTap: imageDecodeController.inProgress ? null : _pickAndDecodeImage,
                        child: Icon(Icons.attach_file, color: Colors.grey.shade600),
                      ),
                ),
                filled: true,
                fillColor: const Color.fromARGB(137, 255, 255, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
              style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.black),
              maxLines: 5,
              minLines: 1,
              textInputAction: TextInputAction.newline,
              onFieldSubmitted: (_) => _sendMessage(),
            ),
          ),
        ),

        // Image Preview
        Obx(() {
          if (imageDecodeController.inProgress) {
            return Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.grey.shade200,
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: const Center(child: CircularProgressIndicator()),
              ),
            );
          }

          if (imageDecodeController.imageUrl.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Stack(
                children: [
                  Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                        image: NetworkImage(imageDecodeController.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: _clearImage,
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        }),
      ],
    );
  }
}