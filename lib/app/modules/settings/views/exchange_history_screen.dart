// app/modules/settings/views/exchange_history_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/settings/controller/exchange_history_controller.dart';
import 'package:sandrofp/app/modules/settings/views/all_history/accepted_history.dart';
import 'package:sandrofp/app/modules/settings/views/all_history/approved_history.dart';
import 'package:sandrofp/app/modules/settings/views/all_history/declined_history.dart';
import 'package:sandrofp/app/modules/settings/views/all_history/requested_history.dart';
import 'package:sandrofp/app/modules/settings/views/all_history/rejected_history.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ExchangeHistoryScreen extends GetView<ExchangeHistoryController> {
  const ExchangeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Exchange History',
        leading: Row(
          children: [
            CircleIconWidget(
              radius: 20,
              iconRadius: 20,
              color: const Color(0xffFFFFFF).withValues(alpha: 0.05),
              imagePath: Assets.images.notification.keyName,
              onTap: () {},
            ),
            widthBox10,
            CircleAvatar(
              backgroundImage: AssetImage(Assets.images.onboarding01.keyName),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox12,

            // Tab bar
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTab(title: 'Approved', index: 0),
                  widthBox12,
                  _buildTab(title: 'Accepted', index: 1),
                  widthBox12,
                  _buildTab(title: 'Requested', index: 2),
                  widthBox12,
                  _buildTab(title: 'Rejected', index: 3),
                  widthBox12,
                  _buildTab(title: 'Declined', index: 4),
                ],
              ),
            ),

            heightBox16,

            // Content
            Obx(() {
              switch (controller.selectedIndex.value) {
                case 0:
                  return ApprovedHistory();
                case 1:
                  return AccepteddHistory();
                case 2:
                  return RequestedHistory();
                case 3:
                  return RejectedHistory();
                case 4:
                  return DeclinedHistory();
                default:
                  return SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({required String title, required int index}) {
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Obx(() {
        final bool isSelected = controller.selectedIndex.value == index;
        final Color activeColor = const Color.fromARGB(255, 32, 71, 48);
        final Color inactiveColor = Colors.black;

        return Column(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
            heightBox4,
            if (isSelected)
              Container(
                height: 1,
                width: title == 'Approved'
                    ? 70
                    : title == 'Accepted'
                    ? 60
                    : title == 'Requested'
                    ? 70
                    : title == 'Rejected'
                    ? 70
                    : title == 'Declined'
                    ? 70
                    : 70,
                color: activeColor,
              ),
          ],
        );
      }),
    );
  }
}
