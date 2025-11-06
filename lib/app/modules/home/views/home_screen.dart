// app/modules/home/views/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/controller/home_controller.dart';
import 'package:sandrofp/app/modules/home/widget/category_header.dart';
import 'package:sandrofp/app/modules/home/widget/category_image.dart';
import 'package:sandrofp/app/modules/home/widget/home_product_card.dart';
import 'package:sandrofp/app/modules/home/widget/homepage_header.dart';
import 'package:sandrofp/app/modules/profile/controllers/profile_controller.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController c = Get.put(HomeController());
    final ProfileController profileController = Get.find<ProfileController>();
    List<Widget> _buildCards() {
      return c.matchProducts.map((product) {
        return HomeProductCard(onTap: product['onTap'] as VoidCallback);
      }).toList();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Background
            Container(
              height: 340,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                image: DecorationImage(
                  image: AssetImage(Assets.images.background.keyName),
                  fit: BoxFit.fill,
                ),
              ),
              child: Obx(() {
                if (profileController.isLoading.value) {
                  return SizedBox(
                    height: 30,
                    width: 30,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return HomepageHeader(
                    imagePath: Assets.images.profile.keyName,
                    name: profileController.profileData?.name ?? '',
                    ammount: '5000',
                    notificationAction: c.goToNotifications,
                    settingsAction: c.goToFilters,
                    arrowAction: () {},
                  );
                }
              }),
            ),
            heightBox12,

            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Exchange by items',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  heightBox8,

                  // Category Grid
                  Row(
                    children: [
                      Column(
                        children: [
                          CategoryImage(
                            height: 110,
                            width: 160,
                            imagePath: Assets.images.mobile2.keyName,
                            name: 'Electronics',
                            onTap: c.goToViewAll,
                          ),
                          heightBox8,
                          CategoryImage(
                            height: 110,
                            width: 160,
                            imagePath: Assets.images.room2.keyName,
                            name: 'Furniture',
                            onTap: c.goToViewAll,
                          ),
                        ],
                      ),
                      widthBox10,
                      Column(
                        children: [
                          CategoryImage(
                            height: 72,
                            width: 154,
                            imagePath: Assets.images.onboarding01.keyName,
                            name: 'Clothing',
                            onTap: c.goToViewAll,
                          ),
                          heightBox8,
                          CategoryImage(
                            height: 72,
                            width: 154,
                            imagePath: Assets.images.book.keyName,
                            name: 'Books',
                            onTap: c.goToViewAll,
                          ),
                          heightBox8,
                          CategoryImage(
                            height: 72,
                            width: 154,
                            imagePath: Assets.images.cycle.keyName,
                            name: 'Other',
                            onTap: c.goToViewAll,
                          ),
                        ],
                      ),
                    ],
                  ),
                  heightBox12,

                  // Matches Section 1
                  CategoryHeader(
                    name: 'Matches products',
                    onTap: c.goToViewAll,
                  ),
                  heightBox10,
                  SizedBox(
                    height: 550,
                    child: Obx(
                      () => CardSwiper(
                        padding: const EdgeInsets.only(left: 0, right: 12),
                        scale: 0.98,
                        backCardOffset: const Offset(12, 0),
                        numberOfCardsDisplayed: 2,
                        cardsCount: _buildCards().length,
                        cardBuilder: (context, index, _, __) =>
                            _buildCards()[index],
                      ),
                    ),
                  ),
                  heightBox12,

                  // Matches Section 2
                  CategoryHeader(name: 'Nearby products', onTap: c.goToViewAll),
                  heightBox10,
                  SizedBox(
                    height: 550,
                    child: Obx(
                      () => CardSwiper(
                        padding: const EdgeInsets.only(left: 0, right: 12),
                        scale: 0.98,
                        backCardOffset: const Offset(12, 0),
                        numberOfCardsDisplayed: 2,
                        cardsCount: _buildCards().length,
                        cardBuilder: (context, index, _, __) =>
                            _buildCards()[index],
                      ),
                    ),
                  ),

                  heightBox100,
                  heightBox100,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
