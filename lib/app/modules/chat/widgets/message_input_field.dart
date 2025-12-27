
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandrofp/app/modules/chat/widgets/chatting_field.dart';

class MessageInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isSending;
  final String chatId; 
  final String receiverId;
  final Function(String, String, String) onSendMessage; 
 
  final String imageUrl;

  const MessageInputWidget({
    super.key, 
    required this.controller,
    required this.isSending, 
    required this.chatId,
    required this.receiverId, 
    required this.onSendMessage,
  
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          Expanded(
            child: ChattingFieldWidget(
              controller: controller,
            
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: isSending
                ? null
                : () => onSendMessage(chatId, controller.text, receiverId),
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: isSending
                  ? SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(
                      Icons.send,
                      color: (controller.text.trim().isNotEmpty || imageUrl.isNotEmpty)
                          ? Colors.black
                          : Colors.grey,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}