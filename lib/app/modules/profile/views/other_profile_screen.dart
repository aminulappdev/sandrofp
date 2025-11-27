// app/modules/other_profile/views/other_profile_screen.dart
import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/widget/feature_row.dart';
import 'package:sandrofp/app/modules/home/widget/home_product_card.dart';
import 'package:sandrofp/app/modules/home/widget/label_data.dart';
import 'package:sandrofp/app/modules/profile/widgets/comment_widget.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

import '../controllers/other_profile_controller.dart';

class OtherProfileScreen extends GetView<OtherProfileController> {
  const OtherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller ইনিশিয়ালাইজ করা (যদি binding না করে থাকো)
    Get.put(OtherProfileController());

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        leading: Container(),
        isBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heightBox12,

                // Profile Avatar + Level Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 40),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 110,
                          backgroundColor: const Color(0xffF3F3F5),
                          child: CircleAvatar(
                            radius: 102,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 94,
                              backgroundImage: NetworkImage(
                                controller.profileData?.profile ?? '',
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 50,
                          child: Container(
                            height: 42,
                            width: 138,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 1, color: Colors.white),
                              color: const Color(0xffF3F3F5),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CrashSafeImage(
                                    Assets.images.brushSheld.keyName,
                                    height: 20,
                                  ),
                                  widthBox8,
                                  Obx(
                                    () => Text(
                                      controller.level.value,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz, size: 40),
                    ),
                  ],
                ),

                heightBox12,

                // Name + Verified
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        controller.profileData?.name ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    widthBox8,
                    CrashSafeImage(Assets.images.checked.keyName, height: 30),
                  ],
                ),

                // Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CrashSafeImage(Assets.images.star.keyName, height: 30),
                    widthBox8,
                    Obx(
                      () => Text(
                        '${controller.rating.value}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    widthBox8,
                    Obx(
                      () => Text(
                        '(${controller.reviewCount.value})',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                heightBox10,

                CustomElevatedButton(
                  title: 'Message',
                  onPress: controller.goToChat,
                ),

                heightBox20,

                // User Information Card
                _buildInfoCard(),
                heightBox12,

                // Bio Card
                _buildBioCard(),
                heightBox20,

                // Clothing Items Sections
                // _buildClothingSection(
                //   'Product items',
                //   controller.clothingItems1,
                // ),

                // Client’s feedback
                Text(
                  'Client’s feedback',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ), 
                ),
                heightBox10,
                Obx(() {
                  if (controller.myFeedbackController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.myFeedbackController.myFeedbackItems.isEmpty) {
                    return const Center(child: Text('No feedback yet'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        controller.myFeedbackController.myFeedbackItems.length,
                    itemBuilder: (context, index) {
                      var item = controller
                          .myFeedbackController
                          .myFeedbackItems[index];
                      return CommentSection(
                        imagePath: item.user?.profile,
                        name: item.user?.name,
                        comment: item.review,
                        title: item.title,
                        rating: item.rating,
                      );
                    },
                  );
                }),

                heightBox100,
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xffF3F3F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User information',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          heightBox10,
          Obx(
            () => FeatureRow(
              titleWeight: FontWeight.w400,
              title: 'Location',
              widget: Text(
                controller.location.value,
                style: GoogleFonts.poppins(),
              ),
            ),
          ),
          heightBox10,
          Obx(
            () => FeatureRow(
              titleWeight: FontWeight.w400,
              title: 'Age',
              widget: Text(controller.age.value, style: GoogleFonts.poppins()),
            ),
          ),
          heightBox10,
          Obx(
            () => FeatureRow(
              titleWeight: FontWeight.w400,
              title: 'Gender',
              widget: Text(
                controller.profileData?.gender ?? 'N/A',
                style: GoogleFonts.poppins(),
              ),
            ),
          ),
          heightBox10,
          Obx(
            () => FeatureRow(
              titleWeight: FontWeight.w400,
              title: 'Height',
              widget: Text(
                controller.height.value,
                style: GoogleFonts.poppins(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBioCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xffF3F3F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          heightBox10,
          Text(
            controller.profileData?.about ?? 'N/A',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClothingSection(String title, RxList items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        heightBox10,
        SizedBox(
          height: 550,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return SizedBox(width: 300, child: HomeProductCard(onTap: () {}));
            },
          ),
        ),
      ],
    );
  }
}
