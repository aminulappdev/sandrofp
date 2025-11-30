// app/modules/product_details/views/product_details_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  const ProductDetailsScreen({super.key});

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

                    // Main Product Image
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
                    controller.product!.images.length > 1
                        ? SizedBox(
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
                                        controller
                                            .product
                                            ?.images[newIndex]
                                            .url ??
                                        '',
                                    radius: 16,
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(),

                    heightBox10,
                    controller.product!.author?.id !=
                            StorageUtil.getData(StorageUtil.userId)
                        ? BuyerDetails(
                            image: controller.product!.author?.profile ?? '',
                            description: controller.product?.descriptions ?? '',
                            rating: controller.product?.author?.avgRating ?? 0,
                            id: controller.product?.author?.id ?? '',
                            name: controller.product?.author?.name ?? '',
                          )
                        : Container(),
                    controller.product!.author?.id !=
                            StorageUtil.getData(StorageUtil.userId)
                        ? heightBox20
                        : heightBox4,

                    Obx(() {
                      var lat = controller.product?.location?.coordinates[0];
                      var lng = controller.product?.location?.coordinates[1];
                      final address$ = AddressHelper.getAddress(lat, lng).obs;
                      var updatePrice =
                          controller.product!.price! -
                          controller.product?.discount;
                      return ProductStaticData(
                        title: controller.product?.name ?? '',
                        price: updatePrice.toString(),
                        address: address$.value,
                        description: controller.product?.descriptions ?? '',
                        discount: controller.product?.discount.toString() ?? '',
                      );
                    }),

                    // Title
                    Text(
                      'Product Details',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    heightBox10,

                    // Size Selection
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

                    // Brand Selection
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

                    // Color Selection
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

                    // Delivery Policy
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

          // Bottom Action Buttons
          controller.product!.author?.id ==
                  StorageUtil.getData(StorageUtil.userId)
              ? Container()
              : Card(
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

  // Reusable Selectable Label
}
