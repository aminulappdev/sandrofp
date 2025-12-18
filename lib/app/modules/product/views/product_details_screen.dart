// app/modules/product_details/views/product_details_screen.dart

import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/cart/views/cart_screen.dart';
import 'package:sandrofp/app/modules/home/widget/buyer_details.dart';
import 'package:sandrofp/app/modules/home/widget/feature_row.dart';
import 'package:sandrofp/app/modules/home/widget/label_data.dart';
import 'package:sandrofp/app/modules/home/widget/product_static_data.dart';
import 'package:sandrofp/app/modules/product/controller/product_details_controller.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/image_container.dart';
import 'package:sandrofp/app/res/common_widgets/straight_liner.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/services/location/address_fetcher.dart';
import 'package:sandrofp/app/services/location/google_distance_services.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsController controller =
      Get.find<ProductDetailsController>();
  final locationService = LocationService.to; // Shared location

  String distanceText = "Calculating...";

  @override
  void initState() {
    super.initState();
    _calculateDistanceWhenReady();
  }

  /// Waits for location to be ready, then calculates distance
  Future<void> _calculateDistanceWhenReady() async {
    // Max 10 seconds wait
    int attempts = 0;
    while (!locationService.isReady.value && attempts < 100) {
      await Future.delayed(const Duration(milliseconds: 100));
      attempts++;
    }

    // If still not ready, use fallback (should never happen because of fallback in LocationService)
    final currentLoc = locationService.currentLocation.value;
    if (currentLoc == null) {
      if (mounted) setState(() => distanceText = "Far");
      return;
    }

    final product = controller.product;
    if (product == null ||
        product.location?.coordinates == null ||
        product.location!.coordinates.length < 2) {
      if (mounted) setState(() => distanceText = "Unknown");
      return;
    }

    final double productLat = product.location!.coordinates[1]; // latitude
    final double productLng = product.location!.coordinates[0]; // longitude

    try {
      final distance = await DistanceService.getDistanceInKm(
        userLat: currentLoc.latitude!,
        userLng: currentLoc.longitude!,
        productLat: productLat,
        productLng: productLng,
      );

      if (mounted) {
        setState(() {
          distanceText = distance;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => distanceText = "Far");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var productLength = controller.product?.images.length ?? 0;

    return Scaffold(
      appBar: CustomAppBar(title: 'Back', leading: Container()),
      body: Column(
        children: [
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightBox12,

                    // Main Image
                    ImageContainer(
                      height: 220,
                      width: double.infinity,
                      imagePath: controller.product?.images.isEmpty == true
                          ? ''
                          : controller.product?.images.first.url ?? '',
                      radius: 20,
                    ),

                    heightBox12,

                    // Thumbnail Images
                    if (controller.product!.images.length > 1)
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: productLength - 1,
                          itemBuilder: (context, index) {
                            var newIndex = index + 1;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ImageContainer(
                                height: 80,
                                width: 80,
                                imagePath:
                                    controller.product?.images[newIndex].url ??
                                    '',
                                radius: 16,
                              ),
                            );
                          },
                        ),
                      ),

                    heightBox10,

                    // Buyer Details (only if not own product)
                    if (controller.product!.author?.id !=
                        StorageUtil.getData(StorageUtil.userId))
                      BuyerDetails(
                        image: controller.product!.author?.profile ?? '',
                        description: controller.product?.descriptions ?? '',
                        rating: controller.product?.author?.avgRating ?? 0,
                        id: controller.product?.author?.id ?? '',
                        name: controller.product?.author?.name ?? '',
                      ),

                    if (controller.product!.author?.id !=
                        StorageUtil.getData(StorageUtil.userId))
                      heightBox20
                    else
                      heightBox4,

                    // Product Info with Distance
                    Obx(() {
                      final lat = controller.product?.location?.coordinates[1];
                      final lng = controller.product?.location?.coordinates[0];
                      final updatePrice =
                          controller.product!.price! -
                          (controller.product?.discount ?? 0);

                      return ProductStaticData(
                        title: controller.product?.name ?? '',
                        price: updatePrice.toString(),
                        address: AddressHelper.getAddress(lat, lng),
                        description: controller.product?.descriptions ?? '',
                        discount: (controller.product?.discount ?? 0)
                            .toString(),
                        distance: distanceText, // Perfect English distance
                      );
                    }),

                    // Product Details Title
                    Text(
                      'Product Details',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    heightBox10,

                    // Size
                    FeatureRow(
                      title: 'Size:',
                      widget: LabelData(
                        onTap: () {},
                        bgColor: const Color(0xffF3F3F5),
                        title: controller.product?.size ?? '',
                        titleColor: Colors.black,
                      ),
                    ),
                    heightBox20,
                    const StraightLiner(),
                    heightBox10,

                    // Material
                    FeatureRow(
                      title: 'Quantity:',
                      widget: LabelData(
                        onTap: () {},
                        bgColor: const Color(0xffF3F3F5),
                        title: controller.product?.quantity ?? '',
                        titleColor: Colors.black,
                      ),
                    ),
                    heightBox20,

                    const StraightLiner(),
                    heightBox10,

                    // Material
                    FeatureRow(
                      title: 'Material:',
                      widget: LabelData(
                        onTap: () {},
                        bgColor: const Color(0xffF3F3F5),
                        title: controller.product?.materials ?? '',
                        titleColor: Colors.black,
                      ),
                    ),
                    heightBox20,
                    const StraightLiner(),
                    heightBox10,

                    // Category
                    FeatureRow(
                      title: 'Category:',
                      widget: Text(
                        controller.product?.category?.name ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff595959),
                        ),
                      ),
                    ),
                    heightBox20,
                    const StraightLiner(),
                    heightBox10,

                    // Color
                    FeatureRow(
                      title: 'Color:',
                      widget: LabelData(
                        onTap: () {},
                        bgColor: const Color(0xffF3F3F5),
                        title: controller.product?.colors ?? '',
                        titleColor: Colors.black,
                      ),
                    ),
                    heightBox20,
                    const StraightLiner(),
                    heightBox10,

                    // Delivery
                    FeatureRow(
                      title: 'Delivery Policy:',
                      widget: Text(
                        'Within 2 working days',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff595959),
                        ),
                      ),
                    ),
                    heightBox20,
                    const StraightLiner(),
                    heightBox30,
                  ],
                ),
              ),
            ),
          ),

          // Bottom Button
          if (controller.product!.author?.id ==
              StorageUtil.getData(StorageUtil.userId))
            Container()
          else
            Card(
              elevation: 3,
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(
                height: 80,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        color: AppColors.greenColor,
                        textColor: Colors.white,
                        title: 'Request Exchange',
                        onPress: () => Get.to(
                          () => CartScreen(),
                          arguments: {'data': controller.product},
                        ),
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
