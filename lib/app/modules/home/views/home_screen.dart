// app/modules/home/views/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/controller/category_controller.dart';
import 'package:sandrofp/app/modules/home/controller/home_controller.dart';
import 'package:sandrofp/app/modules/home/controller/home_product_controller.dart'; // নতুন
import 'package:sandrofp/app/modules/home/views/view_all_category_screen.dart';
import 'package:sandrofp/app/modules/home/widget/category_header.dart';
import 'package:sandrofp/app/modules/home/widget/category_image.dart';
import 'package:sandrofp/app/modules/home/widget/home_product_card.dart';
import 'package:sandrofp/app/modules/home/widget/homepage_header.dart';
import 'package:sandrofp/app/modules/profile/controllers/profile_controller.dart';
import 'package:sandrofp/app/modules/settings/views/token_exchange_screen.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/res/shimmer/category_shimmer.dart';
import 'package:sandrofp/app/res/shimmer/product_card_shimmer.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers
    final HomeController homeController = Get.put(HomeController());
    final ProfileController profileController = Get.find<ProfileController>();
    final CategoryController categoryController =
        Get.find<CategoryController>();
    final HomeProductController homeProductController = Get.put(
      HomeProductController(),
    );

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([homeProductController.refresh()]);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Background
              Container(
                height: MediaQuery.of(context).size.height * 0.36,
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
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  return HomepageHeader(
                    imagePath: Assets.images.profile.keyName,
                    name: profileController.profileData?.name ?? 'User',
                    ammount:
                        profileController.profileData?.tokens.toString() ?? '0',
                    notificationAction: homeController.goToNotifications,
                    settingsAction: homeController.goToFilters,
                    arrowAction: () => Get.to(() => TokenExchangeScreen()),
                  );
                }),
              ),
              heightBox12,

              // Main Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Exchange by items',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.to(() => ViewAllCategoryScreen());
                          },
                          child: Text(
                            'View all',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.greenColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightBox8,

                    // Categories Grid
                    Obx(() {
                      if (categoryController.isLoading.value) {
                        return const CategoryShimmerEffectWidget();
                      }

                      final categories =
                          categoryController.categoryData?.data ?? [];

                      if (categories.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "No categories available",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      return SizedBox(
                        height: categories.length < 2 ? 110 : 210,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: 1.6,
                              ),
                          itemCount: categories.length > 4
                              ? 4
                              : categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return CategoryImage(
                              height: 100,
                              width: 100,
                              name: category.name ?? '',
                              imagePath: category.banner ?? '',
                              onTap: () {
                                homeController.goToViewAll(
                                  category.name ?? 'Category',
                                  category.id.toString(),
                                );
                              },
                            );
                          },
                        ),
                      );
                    }),
                    heightBox16,

                    // === All Products Section ===
                    CategoryHeader(
                      name: 'All products',
                      onTap: homeController.goToAllProducts,
                    ),
                    heightBox10,

                    Obx(() {
                      if (homeProductController.isLoadingAll.value) {
                        return const ProductCardShimmerEffectWidget();
                      }

                      final items = homeProductController.allProducts;

                      if (items.isEmpty) {
                        return const SizedBox(
                          height: 300,
                          child: Center(
                            child: Text(
                              'No matches found',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }

                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.67,
                        child: CardSwiper(
                          padding: const EdgeInsets.only(left: 0, right: 12),
                          scale: 0.98,
                          backCardOffset: const Offset(12, 0),
                          numberOfCardsDisplayed: items.length >= 2 ? 2 : 1,
                          cardsCount: items.length,
                          cardBuilder: (context, index, _, __) {
                            final product = items[index];
                            return HomeProductCard(
                              onTap: () =>
                                  homeController.goToProductDetails(product),
                              imagePath: product.images.isNotEmpty
                                  ? product.images.first.url
                                  : '',
                              price: '৳${product.price}',
                              ownerName: product.author?.name ?? 'Unknown',
                              description: product.descriptions,
                              address: product.author?.name ?? 'Unknown',
                              discount: '${product.discount}% OFF',
                              distance: '2.5 km',
                              rating: '4.5',
                              profile: product.author?.profile,
                              title: product.name,
                            );
                          },
                        ),
                      );
                    }),
                    heightBox20,

                    // === Nearby Products Section ===
                    CategoryHeader(
                      name: 'Nearby products',
                      onTap: homeController.goToNearbyProducts,
                    ),
                    heightBox10,

                    Obx(() {
                      if (homeProductController.isLoadingNearby.value) {
                        return const ProductCardShimmerEffectWidget();
                      }

                      final items = homeProductController.nearbyProducts;

                      if (items.isEmpty) {
                        return const SizedBox(
                          height: 300,
                          child: Center(
                            child: Text(
                              'No nearby products found',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }

                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.67,
                        child: CardSwiper(
                          padding: const EdgeInsets.only(left: 0, right: 12),
                          scale: 0.98,
                          backCardOffset: const Offset(12, 0),
                          numberOfCardsDisplayed: items.length >= 2 ? 2 : 1,
                          cardsCount: items.length,
                          cardBuilder: (context, index, _, __) {
                            final product = items[index];
                            return HomeProductCard(
                              onTap: () =>
                                  homeController.goToProductDetails(product),
                              imagePath: product.images.isNotEmpty
                                  ? product.images.first.url
                                  : '',
                              price: '৳${product.price}',
                              ownerName: product.author?.name ?? 'Unknown',
                              description: product.descriptions,
                              address: product.author?.name ?? 'Nearby',
                              discount: '${product.discount}% OFF',
                              distance: '2.5 km',
                              rating: '4.5',
                              profile: product.author?.profile,
                              title: product.name,
                            );
                          },
                        ),
                      );
                    }),

                    heightBox100,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
