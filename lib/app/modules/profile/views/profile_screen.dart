// app/modules/profile/views/profile_screen.dart
import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/widget/feature_row.dart';
import 'package:sandrofp/app/modules/home/widget/home_product_card.dart';
import 'package:sandrofp/app/modules/profile/controllers/my_product_controller.dart';
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
    final MyProductController myProductController =
        Get.find<MyProductController>();

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
                      profileController.profileData?.about ?? 'N/A',
                      style: GoogleFonts.poppins(fontSize: 12),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),

                  heightBox20,

                  // Categories
                  // _buildInfoCard('Exchange Categories', [
                  //   Wrap(
                  //     spacing: 10,
                  //     children: controller.categories
                  //         .map(
                  //           (cat) => LabelData(
                  //             title: cat,
                  //             bgColor: Colors.white,
                  //             titleColor: Colors.black,
                  //           ),
                  //         )
                  //         .toList(),
                  //   ),
                  // ]),

                  // Clothing Items
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'My Products',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.offAll(
                          //       () => const DashboardScreen(),
                          //       arguments: {"index": 0},
                          //     );
                          //   },
                          //   child: Text(
                          //     'View All',
                          //     style: GoogleFonts.poppins(
                          //       fontSize: 12,
                          //       fontWeight: FontWeight.w400,
                          //       color: AppColors.greenColor,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      heightBox10,
                      SizedBox(
                        height: Get.height * 0.67,
                        child: Obx(() {
                          if (myProductController.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            var items = myProductController.allProductItems;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: items.length,
                              itemBuilder: (context, i) {
                                var product = items[i];
                                return SizedBox(
                                  width: 300,
                                  child: HomeProductCard(
                                    onTap: () {},
                                    price: product.price.toString(),
                                    imagePath: product.images.isEmpty
                                        ? ''
                                        : product.images[0].url,
                                    title: product.brands,
                                    description: product.descriptions,
                                    discount: product.discount.toString(),
                                    rating: product.name.toString(),
                                    distance: product.name.toString(),
                                    profile: product.author?.profile.toString(),
                                    ownerName: product.author?.name.toString(),
                                    address: product.author?.name.toString(),
                                  ),
                                );
                              },
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                  heightBox20,

                  // Electronics
                  // _buildProductSection(
                  //   'Electronics items',
                  //   controller.electronicItems,
                  // ),
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
}
