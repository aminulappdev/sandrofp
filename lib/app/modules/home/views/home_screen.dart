import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/controller/category_controller.dart';
import 'package:sandrofp/app/modules/home/controller/home_controller.dart';
import 'package:sandrofp/app/modules/home/controller/home_product_controller.dart';
import 'package:sandrofp/app/modules/home/controller/product_interest_controller.dart';
import 'package:sandrofp/app/modules/home/views/view_all_category_screen.dart';
import 'package:sandrofp/app/modules/home/widget/category_header.dart';
import 'package:sandrofp/app/modules/home/widget/category_image.dart';
import 'package:sandrofp/app/modules/home/widget/home_product_card.dart';
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
    final HomeController homeController = Get.put(HomeController());
    final profileController = Get.find<ProfileController>();
    final categoryController = Get.find<CategoryController>();
    final productController = Get.find<HomeProductController>();
    ProductInterestController productInterestController =
        ProductInterestController();

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
      body: CustomScrollView(
        slivers: [
          // SliverAppBar যা স্ক্রল করার সাথে সাথে collapse হবে
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.27,
            collapsedHeight: MediaQuery.of(context).size.height * 0.10,
            floating: false,
            pinned: true,
            snap: false,
            stretch: true,
            backgroundColor: Color.fromARGB(255, 2, 58, 27), // Transparent background
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40.r),
              ),
            ),
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  stretchModes: const [StretchMode.zoomBackground],
                  expandedTitleScale: 1.0,
                  titlePadding: EdgeInsets.zero,
                  background: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(40.r),
                      ),
                    ),
                    child: Stack(
                      children: [
                        // শুধুমাত্র Background Image
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(40.r),
                            ),
                            child: Image.asset(
                              Assets.images.background.keyName,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Balance Card Content
                        Obx(() {
                          if (profileController.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Spacer(),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.17,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Balance',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  Assets.images.banana.keyName,
                                                  height: 16.h,
                                                ),
                                                SizedBox(width: 10.w),
                                                Text(
                                                  profileController
                                                          .profileData
                                                          ?.tokens
                                                          .toString() ??
                                                      '0',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.yellowColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Container(
                                          height: 0.3,
                                          width: double.infinity,
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            Image.asset(
                                              Assets.images.bag.keyName,
                                              height: 16,
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              'Buy banana tokens ',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 260,
                                              child: Text(
                                                'Lorem ipsum dolor sit amet, consectetur our adipiscing elit Maecenas hendrerit',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => Get.to(
                                                () =>
                                                    const TokenExchangeScreen(),
                                              ),
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Color(
                                                    0xFFFFFFFF,
                                                  ).withOpacity(0.15),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    Assets
                                                        .images
                                                        .arrowFont
                                                        .keyName,
                                                    height: 11,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
            title: Obx(() {
              if (profileController.isLoading.value) {
                return SizedBox();
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                profileController
                                        .profileData
                                        ?.profile
                                        ?.isEmpty ??
                                    true
                                ? null
                                : NetworkImage(
                                    profileController.profileData!.profile!,
                                  ),
                            child:
                                (profileController
                                        .profileData
                                        ?.profile
                                        ?.isEmpty ??
                                    true)
                                ? Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Hi, ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${profileController.profileData?.name ?? 'User'}!',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.yellowColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Let\'s exchange',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: homeController.goToNotifications,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                Assets.images.notification.keyName,
                                height: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: homeController.goToFilters,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                Assets.images.filter.keyName,
                                height: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            titleSpacing: 0,
            centerTitle: false,
            elevation: 0,
          ),

          // Main Content Area
          SliverToBoxAdapter(
            child: RefreshIndicator(
              onRefresh: () async {
                await productController.refresh();
                await locationService.getLocation();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightBox12,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () =>
                                  Get.to(() => ViewAllCategoryScreen()),
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
                            height: MediaQuery.of(context).size.height * 0.60,
                            child: CardSwiper(
                              padding: const EdgeInsets.only(
                                left: 0,
                                right: 12,
                                bottom: 0,
                              ),
                              scale: 0.98,
                              onSwipe:
                                  (previousIndex, currentIndex, direction) {
                                if (direction == CardSwiperDirection.left) {
                                  productInterestController.updateInterest(
                                    false,
                                    items[currentIndex!].id.toString(),
                                  );
                                } else if (direction ==
                                    CardSwiperDirection.right) {
                                  productInterestController.updateInterest(
                                    true,
                                    items[currentIndex!].id.toString(),
                                  );
                                }
                                return true;
                              },
                              backCardOffset: const Offset(12, 0),
                              numberOfCardsDisplayed: items.length >= 2 ? 2 : 1,
                              cardsCount: items.length,
                              cardBuilder: (context, index, _, __) {
                                final product = items[index];
                                final double? productLat =
                                    product.location?.coordinates[1];
                                final double? productLng =
                                    product.location?.coordinates[0];
                                final priceAfterDiscount =
                                    (product.price ?? 0) -
                                        (product.discount ?? 0);

                                return FutureBuilder<String>(
                                  future: getLiveDistance(
                                    productLat,
                                    productLng,
                                  ),
                                  builder: (context, snapshot) {
                                    final distance = snapshot.data ?? "Far";
                                    return HomeProductCard(
                                      onTap: () => homeController
                                          .goToProductDetails(product),
                                      imagePath: product.images.isNotEmpty
                                          ? product.images.first.url
                                          : 'https://via.placeholder.com/300',
                                      price: '\$$priceAfterDiscount',
                                      ownerName:
                                          product.author?.name ?? 'Unknown',
                                      description: product.descriptions ?? '',
                                      address: AddressHelper.getAddress(
                                        productLat,
                                        productLng,
                                      ),
                                      discount: '${product.discount ?? 0}\$',
                                      distance: distance,
                                      rating: product.author?.avgRating
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
                            height: MediaQuery.of(context).size.height * 0.60,
                            child: CardSwiper(
                              padding: const EdgeInsets.only(
                                left: 0,
                                right: 12,
                              ),
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
                                final priceAfterDiscount =
                                    (product.price ?? 0) -
                                        (product.discount ?? 0);

                                return FutureBuilder<String>(
                                  future: getLiveDistance(
                                    productLat,
                                    productLng,
                                  ),
                                  builder: (context, snapshot) {
                                    final distance = snapshot.data ?? "Far";
                                    return HomeProductCard(
                                      onTap: () => homeController
                                          .goToProductDetails(product),
                                      imagePath: product.images.isNotEmpty
                                          ? product.images.first.url
                                          : 'https://via.placeholder.com/300',
                                      price: '\$$priceAfterDiscount',
                                      ownerName:
                                          product.author?.name ?? 'Unknown',
                                      description: product.descriptions ?? '',
                                      address: AddressHelper.getAddress(
                                        productLat,
                                        productLng,
                                      ),
                                      discount: '${product.discount ?? 0}\$',
                                      distance: distance,
                                      rating: product.author?.avgRating
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
        ],
      ),
    );
  }
}