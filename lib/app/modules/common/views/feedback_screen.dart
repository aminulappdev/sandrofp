// feedback_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/common/controller/feedback_controller.dart';
import 'package:sandrofp/app/modules/common/widget/custom_rating.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';

class FeedbackScreen extends GetView<FeedbackController> {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Feedback', leading: Container()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your feedback matters',
                style: GoogleFonts.poppins(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'It takes less than 60 seconds',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: AppColors.profileData,
                ),
              ),
              heightBox24,

              // Rating
              Text(
                'Rating',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox10,
              Obx(
                () => CustomStarRating(
                  rating: controller.communicationRating.value,
                  size: 36,
                  filledColor: Colors.amber,
                  unfilledColor: Colors.grey.shade300,
                  onRatingChanged: controller.setCommunicationRating,
                ),
              ),
              heightBox24,

              // Quick Tags (Single Select)
              Text(
                'What did you think?',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox14,
              Obx(
                () => Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: controller.quickTags.map((tag) {
                    final isSelected = controller.selectedTag.value == tag;
                    return GestureDetector(
                      onTap: () => controller.selectTag(tag),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.greenColor
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.greenColor
                                : Colors.grey.shade300,
                            width: 1.8,
                          ),
                        ),
                        child: Text(
                          tag,
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              heightBox30,

              // Comments
              Text(
                'Additional comments (optional)',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              heightBox10,
              TextField(
                maxLines: 5,
                onChanged: (v) => controller.feedbackText.value = v,
                decoration: InputDecoration(
                  hintText: 'Write your experience...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  contentPadding: EdgeInsets.all(16.w),
                ),
              ),
              heightBox40,

              // Submit Button
              Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          title: 'Submit Feedback',
                          onPress: controller.submitFeedback,
                        ),
                      ),
              ),
              heightBox50,
            ],
          ),
        ),
      ),
    );
  }
}
