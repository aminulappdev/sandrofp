// app/modules/cart/views/cart_screen.dart
import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/cart/widget/product_cart.dart';
import 'package:sandrofp/app/modules/exchange/views/exchange_screen.dart';
import 'package:sandrofp/app/modules/home/widget/feature_row.dart';
import 'package:sandrofp/app/modules/product/controller/cart_controller.dart';
import 'package:sandrofp/app/modules/profile/controllers/my_product_controller.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/bottom_card.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/straight_liner.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/services/location/address_fetcher.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    final myProductController = Get.find<MyProductController>();

    return Scaffold(
      backgroundColor: const Color(0xffFBFBFD),
      appBar: CustomAppBar(title: 'Back', leading: Container()),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (myProductController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final products = myProductController.allProductItems;
              if (products.isEmpty) {
                return const Center(child: Text("No products available"));
              }

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Products',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ), 
                    heightBox12,
                    Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          final id = product.id.toString();
                          final price = product.price?.toDouble() ?? 0.0;
                          final discount = product.discount?.toDouble() ?? 0.0;
                          final updatePrice = price - discount;
                           var lat = product.location?.coordinates[0];
                            var lng = product.location?.coordinates[1];

                            final address = AddressHelper.getAddress(lat, lng);

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Obx(
                                  () => Checkbox(
                                    value: controller.selectedProductIds
                                        .contains(id),
                                    onChanged: (_) =>
                                        controller.toggleSelection(id),
                                    activeColor: AppColors.greenColor,
                                  ),
                                ),
                                Expanded(
                                  child: ProductCart(
                                    productImage:
                                        product.images.firstOrNull?.url ?? '',
                                    productName: product.name,
                                    productPrice: updatePrice.toString(),
                                    description: product.descriptions,
                                    address: address,
                                    quantity: 1,
                                    onQuantityChanged: (_) {},
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),

          BottomCard(
            child: Obx(() {
              final count = controller.selectedProductIds.length;
              final hasSelection = count > 0;

              return Column(
                children: [
                  heightBox12,
                  FeatureRow(
                    title: 'Exch Product Value',
                    widget: Text(
                      'Rs. ${controller.exchangePrice.value.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  heightBox8,
                  FeatureRow(
                    title: 'Selected Total',
                    widget: Row(
                      children: [
                        CrashSafeImage(
                          Assets.images.banana.keyName,
                          height: 16,
                          width: 16,
                        ),
                        widthBox5,
                        Text(
                          controller.selectedTotal.value.toStringAsFixed(2),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: AppColors.yellowColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  heightBox8,
                  FeatureRow(
                    title: 'Remaining (Extra Token)',
                    widget: Text(
                      'Rs. ${controller.remainingPrice.value.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: controller.remainingPrice.value > 0
                            ? Colors.orange
                            : Colors.red,
                      ),
                    ),
                  ),
                  heightBox12,
                  const StraightLiner(),
                  heightBox10,
                  CustomElevatedButton(
                    title: hasSelection
                        ? 'Proceed with $count Item${count > 1 ? 's' : ''}'
                        : 'Select items',
                    onPress: hasSelection
                        ? () {
                            final selectedMaps = controller.selectedProductIds
                                .map((id) {
                                  final p = myProductController.allProductItems
                                      .firstWhere((e) => e.id.toString() == id);
                                  final price = p.price?.toDouble() ?? 0.0;
                                  final discount =
                                      p.discount?.toDouble() ?? 0.0;
                                  final updatePrice = price - discount;
                                  return {
                                    'id': p.id.toString(),
                                    'image': p.images.firstOrNull?.url ?? '',
                                    'title': p.name,
                                    'price': updatePrice,
                                    'description': p.descriptions,
                                  };
                                })
                                .toList();

                            Get.to(
                              () => const ExchangeView(),
                              arguments: {
                                'exchangeProduct': {
                                  'id': controller.productData?.id ?? '0',
                                  'image':
                                      controller
                                          .productData
                                          ?.images
                                          .firstOrNull
                                          ?.url ??
                                      '',
                                  'title':
                                      controller.productData?.name ?? 'Unknown',
                                  'price': controller.exchangePrice.value,

                                  'description':
                                      controller.productData?.descriptions,
                                  'userId':
                                      controller.productData!.author?.id ?? '0',
                                },
                                'selectedProducts': selectedMaps,
                                'selectedTotal': controller.selectedTotal.value,
                                'remainingToken':
                                    controller.remainingPrice.value,
                              },
                            );
                          }
                        : null,
                    color: AppColors.greenColor,
                    textColor: Colors.white,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
