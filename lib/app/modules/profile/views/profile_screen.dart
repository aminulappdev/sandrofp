// app/modules/profile/views/profile_screen.dart
import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/widget/feature_row.dart';
import 'package:sandrofp/app/modules/home/widget/home_product_card.dart';
import 'package:sandrofp/app/modules/home/widget/label_data.dart';
import 'package:sandrofp/app/modules/profile/controllers/profile_controller.dart';
import 'package:sandrofp/app/modules/profile/controllers/profile_screen_controller.dart';
import 'package:sandrofp/app/modules/profile/widgets/comment_widget.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileScreenController()); // অটো ইনজেক্ট
    final ProfileController profileController = Get.find<ProfileController>();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        leading: Container(),
        isBack: false,
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return SizedBox(
            height: Get.height,
            child: Center(child: CircularProgressIndicator()),
          );
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  heightBox12,

                  // Avatar + Level Badge
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
                                backgroundImage: AssetImage(
                                  Assets.images.onboarding01.keyName,
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
                                border: Border.all(color: Colors.white),
                                color: const Color(0xffF3F3F5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CrashSafeImage(
                                    Assets.images.brushSheld.keyName,
                                    height: 20,
                                  ),
                                  widthBox8,
                                  Text(
                                    profileController.profileData?.status ?? '',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
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
                      Text(
                        profileController.profileData?.name ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
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
                      Text(
                        profileController.profileData?.avgRating.toString() ??
                            '',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      widthBox8,
                      Text(
                        '(${controller.user['reviews']})',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),

                  heightBox10,
                  CustomElevatedButton(
                    title: 'Edit Profile',
                    onPress: controller.goToEditProfile,
                  ),

                  heightBox20,

                  // User Info Card
                  _buildInfoCard('User information', [
                    FeatureRow(
                      title: 'Location',
                      widget: Text(
                        profileController.profileData?.status ?? 'N/A',
                      ),
                    ),
                    FeatureRow(
                      title: 'Age',
                      widget: Text(profileController.profileData?.status ?? ''),
                    ),
                    FeatureRow(
                      title: 'Gender',
                      widget: Text(
                        profileController.profileData?.gender ?? 'N/A',
                      ),
                    ),
                    FeatureRow(
                      title: 'Height',
                      widget: Text(
                        profileController.profileData?.status ?? 'N/A',
                      ),
                    ),
                  ]),

                  heightBox12,

                  // Bio Card
                  _buildInfoCard('About me', [
                    Text(
                      controller.user['bio'],
                      style: GoogleFonts.poppins(fontSize: 12),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),

                  heightBox20,

                  // Categories
                  _buildInfoCard('Exchange Categories', [
                    Wrap(
                      spacing: 10,
                      children: controller.categories
                          .map(
                            (cat) => LabelData(
                              title: cat,
                              bgColor: Colors.white,
                              titleColor: Colors.black,
                            ),
                          )
                          .toList(),
                    ),
                  ]),

                  heightBox20,

                  // Clothing Items
                  _buildProductSection(
                    'Clothing items',
                    controller.clothingItems,
                  ),
                  heightBox20,

                  // Electronics
                  _buildProductSection(
                    'Electronics items',
                    controller.electronicItems,
                  ),
                  heightBox20,

                  // Feedback
                  Text(
                    'Client’s feedback',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  heightBox10,
                  ...controller.feedbacks.map(
                    (fb) => Column(children: [CommentSection(), heightBox10]),
                  ),

                  heightBox100,
                  heightBox100,
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
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
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          heightBox10,
          ...children,
        ],
      ),
    );
  }

  Widget _buildProductSection(
    String title,
    RxList<RxMap<String, dynamic>> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        heightBox10,
        SizedBox(
          height: 550,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, i) =>
                SizedBox(width: 300, child: HomeProductCard(onTap: () {})),
          ),
        ),
      ],
    );
  }
}
