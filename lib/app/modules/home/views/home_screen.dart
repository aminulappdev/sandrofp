// app/modules/home/views/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/controller/category_controller.dart';
import 'package:sandrofp/app/modules/home/controller/home_controller.dart';
import 'package:sandrofp/app/modules/home/controller/home_product_controller.dart';
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
import 'package:sandrofp/app/services/location/address_fetcher.dart';
import 'package:sandrofp/app/services/location/google_distance_services.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final homeController = Get.find<HomeController>();
    final HomeController homeController = Get.put(HomeController());
    final profileController = Get.find<ProfileController>();
    final categoryController = Get.find<CategoryController>();
    final productController = Get.find<HomeProductController>();

    // Shared location service
    final locationService = LocationService.to;

    Future<String> getLiveDistance(double? lat, double? lng) async {
      if (lat == null || lng == null) return "Far";

      if (!locationService.isReady.value ||
          locationService.currentLocation.value == null) {
        debugPrint("Location not ready yet – showing Far");
        return "Far";
      }

      return await DistanceService.getDistanceInKm(
        userLat: locationService.currentLocation.value!.latitude!,
        userLng: locationService.currentLocation.value!.longitude!,
        productLat: lat,
        productLng: lng,
      );
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await productController.refresh();
          await locationService.getLocation(); // Refresh location too
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
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40.r),
                  ),
                  image: DecorationImage(
                    image: AssetImage(Assets.images.background.keyName),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Obx(() {
                  if (profileController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  return HomepageHeader(
                    imageOnTap: () {},
                    imagePath: profileController.profileData?.profile ?? '',
                    name: profileController.profileData?.name ?? 'User',
                    ammount:
                        profileController.profileData?.tokens.toString() ?? '0',
                    notificationAction: homeController.goToNotifications,
                    settingsAction: homeController.goToFilters,
                    arrowAction: () =>
                        Get.to(() => const TokenExchangeScreen()),
                  );
                }),
              ),
              heightBox12,

              // Main Content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Exchange by items + View all
                    Row(
                      children: [
                        Text(
                          'Exchange by items',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => Get.to(() => ViewAllCategoryScreen()),
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
                    heightBox10,

                    // Categories Grid
                    Obx(() {
                      if (categoryController.isLoading.value) {
                        return const CategoryShimmerEffectWidget();
                      }

                      final categories =
                          categoryController.categoryData?.data ?? [];
                      if (categories.isEmpty) {
                        return const Center(
                          child: Text("No categories available"),
                        );
                      }

                      return SizedBox(
                        height: categories.length < 2
                            ? 110
                            : MediaQuery.of(context).size.height * 0.28,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
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
                          itemBuilder: (context, i) {
                            final cat = categories[i];
                            return CategoryImage(
                              height: 100,
                              width: 100,
                              name: cat.name ?? '',
                              imagePath: cat.banner ?? '',
                              onTap: () => homeController.goToViewAll(
                                cat.name ?? 'Category',
                                cat.id.toString(),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                    heightBox16,

                    // All Products
                    CategoryHeader(
                      name: 'All products',
                      onTap: homeController.goToAllProducts,
                    ),
                    heightBox10,

                    Obx(() {
                      if (productController.isLoadingAll.value) {
                        return const ProductCardShimmerEffectWidget();
                      }

                      final items = productController.allProducts;
                      if (items.isEmpty) {
                        return SizedBox(
                          height: 300,
                          child: Center(child: Text('No matches found')),
                        );
                      }

                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: CardSwiper(
                          padding: const EdgeInsets.only(
                            left: 0,
                            right: 12,
                            bottom: 0,
                          ),
                          scale: 0.98,
                          backCardOffset: const Offset(12, 0),
                          numberOfCardsDisplayed: items.length >= 2 ? 2 : 1,
                          cardsCount: items.length,
                          cardBuilder: (context, index, _, __) {
                            final product = items[index];

                            // GeoJSON format: [longitude, latitude]
                            final double? productLat =
                                product.location?.coordinates[1];
                            final double? productLng =
                                product.location?.coordinates[0];

                            final priceAfterDiscount =
                                (product.price ?? 0) - (product.discount ?? 0);

                            return FutureBuilder<String>(
                              future: getLiveDistance(productLat, productLng),
                              builder: (context, snapshot) {
                                final distance = snapshot.data ?? "Far";

                                return HomeProductCard(
                                  onTap: () => homeController
                                      .goToProductDetails(product),
                                  imagePath: product.images.isNotEmpty
                                      ? product.images.first.url
                                      : 'https://via.placeholder.com/300',
                                  price: '\$$priceAfterDiscount',
                                  ownerName: product.author?.name ?? 'Unknown',
                                  description: product.descriptions ?? '',
                                  address: AddressHelper.getAddress(
                                    productLat,
                                    productLng,
                                  ),
                                  discount: '${product.discount ?? 0}\$',
                                  distance: distance,
                                  rating:
                                      product.author?.avgRating
                                          ?.toStringAsFixed(1) ??
                                      '0',
                                  profile: product.author?.profile ?? '',
                                  title: product.name ?? 'No Title',
                                );
                              },
                            );
                          },
                        ),
                      );
                    }),

                    heightBox20,

                    // Nearby Products
                    CategoryHeader(
                      name: 'Nearby products',
                      onTap: homeController.goToNearbyProducts,
                    ),
                    heightBox10,

                    Obx(() {
                      if (productController.isLoadingNearby.value) {
                        return const ProductCardShimmerEffectWidget();
                      }

                      final items = productController.nearbyProducts;
                      if (items.isEmpty) {
                        return SizedBox(
                          height: 300,
                          child: Center(
                            child: Text('No nearby products found'),
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
                            final double? productLat =
                                product.location?.coordinates[1];
                            final double? productLng =
                                product.location?.coordinates[0];

                            return FutureBuilder<String>(
                              future: getLiveDistance(productLat, productLng),
                              builder: (context, snapshot) {
                                final distance = snapshot.data ?? "Far";

                                final priceAfterDiscount =
                                    (product.price ?? 0) -
                                    (product.discount ?? 0);

                                return HomeProductCard(
                                  onTap: () => homeController
                                      .goToProductDetails(product),
                                  imagePath: product.images.isNotEmpty
                                      ? product.images.first.url
                                      : 'https://via.placeholder.com/300',
                                  price: '\$$priceAfterDiscount',
                                  ownerName: product.author?.name ?? 'Unknown',
                                  description: product.descriptions ?? '',
                                  address: AddressHelper.getAddress(
                                    productLat,
                                    productLng,
                                  ),
                                  discount: '${product.discount ?? 0}\$',
                                  distance: distance,
                                  rating:
                                      product.author?.avgRating
                                          ?.toStringAsFixed(1) ??
                                      '0',
                                  profile: product.author?.profile ?? '',
                                  title: product.name ?? 'No Title',
                                );
                              },
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
