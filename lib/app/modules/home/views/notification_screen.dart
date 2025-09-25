import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/app_const/app_const.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> notifications = List.generate(
    10,
    (index) => {
      'name': 'Sara $index',
      'message':
          'There are many variations of passages of Lorem Ipsum available...',
      'time': '1 min',
      'isRead': false,
    },
  );
  bool showButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Completed', leading: Container(),),
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
                  onTap: () {
                    setState(() {
                      for (var notification in notifications) {
                        notification['isRead'] = true;
                      }
                    });
                  },
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
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(notifications[index]['name']),
                    onDismissed: (direction) {
                      setState(() {
                        final removedItem = notifications.removeAt(index);
                        Get.snackbar(
                          'Deleted',
                          'Item is deleted',
                          colorText: Colors.white,
                          snackStyle: SnackStyle.FLOATING,
                          backgroundColor: Colors.redAccent,
                          snackPosition: SnackPosition.TOP,
                        );
                      });
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(
                          12.r,
                        ), // Border radius for background
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.r,
                        ), // Border radius for child
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.2),
                        //     spreadRadius: 1,
                        //     blurRadius: 5,
                        //     offset: Offset(0, 2),
                        //   ),
                        // ],
                      ),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              notifications[index]['isRead'] = true;
                            });
                          },
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            notifications[index]['name'],
                                            style: GoogleFonts.poppins(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  notifications[index]['isRead']
                                                  ? Colors.grey
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          notifications[index]['time'],
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
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        notifications[index]['message'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: notifications[index]['isRead']
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
          ],
        ),
      ),
    );
  }
}
