// screens/notification_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/controller/notification_controller.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/app_const/app_const.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // কন্ট্রোলার ইনিশিয়ালাইজ করা হচ্ছে (যদি আগে না থাকে)
    Get.put(NotificationController());

    return Scaffold(
      appBar: CustomAppBar(title: 'Completed', leading: Container()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: GoogleFonts.poppins(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: controller.markAllAsRead,
                  child: Text(
                    'Mark as all read',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greenColor,
                    ),
                  ),
                ),
              ],
            ),
            heightBox12,
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = controller.notifications[index];
                    return Dismissible(
                      key: Key(notification['name']),
                      onDismissed: (direction) {
                        controller.deleteNotification(index);
                      },
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => controller.markAsRead(index),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 25.r,
                                  backgroundImage: NetworkImage(
                                    DemoImage.demoImage,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 220,
                                            child: Text(
                                              notification['name'],
                                              style: GoogleFonts.poppins(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600,
                                                color: notification['isRead']
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            notification['time'],
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          notification['message'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: notification['isRead']
                                                ? Colors.grey
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
