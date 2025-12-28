// app/modules/profile/views/profile_screen.dart
import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
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
  ProfileScreen({super.key}) {
    Get.put(ProfileScreenController());
  }

  // Current location থেকে address বের করার ফাংশন
  Future<String> _getCurrentAddress() async {
    try {
      // Permission চেক করা
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return "Location permission denied";
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return "Location permission permanently denied";
      }

      // Current position নেওয়া
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Reverse geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return [
          if (place.subLocality?.isNotEmpty ?? false) place.subLocality,
          if (place.locality?.isNotEmpty ?? false) place.locality,
          if (place.administrativeArea?.isNotEmpty ?? false)
            place.administrativeArea,
          if (place.country?.isNotEmpty ?? false) place.country,
        ].where((e) => e != null).join(", ");
      }

      return "${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
    } catch (e) {
      debugPrint("Location error: $e");
      return "Unable to fetch location";
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final MyProductController myProductController =
        Get.find<MyProductController>();

    // Realtime address এর জন্য RxString
    final RxString currentAddress = "Fetching location...".obs;

    // Screen load হওয়ার সাথে সাথে location fetch করা
    _getCurrentAddress().then((address) {
      currentAddress.value = address.isEmpty
          ? "Location not available"
          : address;
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        leading: Container(),
        isBack: false,
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heightBox12,

                // Avatar + Level Badge
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
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: NetworkImage(
                            profileController.profileData?.profile ?? '',
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
                          border: Border.all(color: Colors.white, width: 3),
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
                              profileController.profileData?.status ?? 'User',
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

                heightBox12,

                // Name + Verified
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      profileController.profileData?.name ?? 'User Name',
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
                      profileController.profileData?.avgRating?.toStringAsFixed(
                            1,
                          ) ??
                          '0.0',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                    widthBox8,
                    Text(
                      '(${profileController.profileData?.avgRating ?? 0})',
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

                // User Info Card – এখানে realtime address দেখানো হচ্ছে
                _buildInfoCard('User information', [
                  FeatureRow(
                    title: 'Location',
                    widget: SizedBox(
                      width: Get.width * 0.45,
                      child: Text(
                        currentAddress.value,
                        style: const TextStyle(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  heightBox8,
                  FeatureRow(
                    title: 'Gender',
                    widget: Text(
                      profileController.profileData?.gender ?? 'N/A',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ]),

                heightBox12,

                // About Me
                _buildInfoCard('About me', [
                  Text(
                    profileController.profileData?.about ?? 'No bio added yet.',
                    style: GoogleFonts.poppins(fontSize: 12),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ]),

                heightBox20,

                // My Products Section
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
                      ],
                    ),
                    heightBox10,
                    SizedBox(
                      height: Get.height * 0.60,
                      child: Obx(() {
                        if (myProductController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (myProductController.allProductItems.isEmpty) {
                          return const Center(
                            child: Text(
                              'No products found',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }

                        final items = myProductController.allProductItems;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (context, i) {
                            final product = items[i];
                            return SizedBox(
                              width: 300,
                              child: HomeProductCard(
                                onTap: () {},
                                price: (product.price! - product.discount!)
                                    .toStringAsFixed(0),
                                imagePath: product.images.isEmpty
                                    ? ''
                                    : product.images.first.url,
                                title: product.name ?? 'No Brand',
                                description: product.descriptions ?? '',

                                discount: product.discount?.toString() ?? '0',
                                rating:
                                    product.author?.avgRating?.toString() ??
                                    '0',

                                profile: product.author?.profile ?? '',
                                ownerName: product.author?.name ?? 'Unknown',
                                address: 'N/A',
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),

                heightBox20,

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
            ),
          ),
        );
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
