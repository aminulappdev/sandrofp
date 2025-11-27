// app/modules/exchange/views/exchange_view.dart
import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/cart/widget/product_cart.dart';
import 'package:sandrofp/app/modules/exchange/controller/exchange_controller.dart';
import 'package:sandrofp/app/modules/home/widget/feature_row.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/bottom_card.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/straight_liner.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ExchangeView extends GetView<ExchangeController> {
  const ExchangeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExchangeController());

    return Scaffold(
      backgroundColor: const Color(0xffFBFBFD),
      appBar: CustomAppBar(title: 'Exchange', leading: Container()),
      body: Column(
        children: [
          heightBox12,
          Expanded(
            child: GetBuilder<ExchangeController>(
              builder: (ctrl) => SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Exchange Product
                    _sectionHeader(
                      'Exchange Product',
                      ctrl.changeExchangeProduct,
                    ),
                    heightBox4,
                    ProductCart(
                      productImage: ctrl.exchangeProduct.image,
                      productName: ctrl.exchangeProduct.title,
                      productPrice: ctrl.exchangeProduct.price,
                      description: ctrl.exchangeProduct.description,
                      address: '',
                      quantity: 1,
                      onQuantityChanged: (_) {},
                    ),
                    heightBox20,

                    // Exchange Icon
                    Center(
                      child: CrashSafeImage(
                        Assets.images.exchange.keyName,
                        height: 50,
                        color: AppColors.greenColor,
                      ),
                    ),
                    heightBox20,

                    // Your Products
                    _sectionHeader('Your Product', ctrl.changeYourProduct),
                    heightBox8,
                    ...ctrl.selectedProducts.map(
                      (p) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ProductCart(
                          productImage: p.image,
                          productName: p.title,
                          productPrice: p.price,
                          description: p.description,
                          address: '',
                          quantity: 1,
                          onQuantityChanged: (_) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Summary + Exchange Button
          BottomCard(
            child: GetBuilder<ExchangeController>(
              builder: (ctrl) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Column(
                  children: [
                    FeatureRow(
                      title: 'Exch Product Value',
                      widget: Text(
                        'Rs. ${ctrl.exchangeProduct.price}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    heightBox8,
                    FeatureRow(
                      title: 'Selected Total (Token)',
                      widget: Row(
                        children: [
                          CrashSafeImage(
                            Assets.images.banana.keyName,
                            height: 16,
                            width: 16,
                          ),
                          widthBox5,
                          Text(
                            ctrl.selectedTotal.value.toStringAsFixed(2),
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
                        'Rs. ${ctrl.remainingToken.value.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ctrl.remainingToken.value > 0
                              ? Colors.orange
                              : Colors.red,
                        ),
                      ),
                    ),
                    heightBox12,
                    const StraightLiner(),
                    heightBox10,
                    FeatureRow(
                      title: 'Total',
                      widget: Text(
                        'Rs. ${ctrl.exchangeProduct.price}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    heightBox10,

                    // Exchange Button with Loading
                    Obx(
                      () => CustomElevatedButton(
                        title: ctrl.isLoading.value
                            ? 'Processing...'
                            : 'Exchange',
                        onPress: ctrl.isLoading.value
                            ? null
                            : () async {
                                await ctrl.exchangeFunction();
                              },
                        color: AppColors.greenColor,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
