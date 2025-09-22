import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/cart/widget/product_cart.dart';
import 'package:sandrofp/app/modules/home/widget/feature_row.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/straight_liner.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Exchange',
        leading: Row(
          children: [
            CircleIconWidget(
              radius: 20,
              iconRadius: 20,
              color: Color(0xffFFFFFF).withValues(alpha: 0.05),
              imagePath: Assets.images.notification.keyName,
              onTap: () {},
            ),
            widthBox10,
            CircleAvatar(
              backgroundImage: AssetImage(Assets.images.onboarding01.keyName),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          heightBox12,
          Expanded(
            // ✅ Wrap the inner Column with Expanded
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Exchange Product',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'change',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.greenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    heightBox4,
                    ProductCart(),
                    heightBox20,
                    Center(
                      child: CrashSafeImage(
                        Assets.images.exchange.keyName,
                        height: 50,
                        color: AppColors.greenColor,
                      ),
                    ),
                    heightBox20,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Product',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'change',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.greenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ProductCart(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Text(
                                'Apply',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      hintText: 'Enter discount code',
                      filled: true,
                      fillColor: Color(0xffF3F3F5),
                    ),
                  ),
                  heightBox12,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FeatureRow(
                        titleWeight: FontWeight.w400,
                        title: 'Total',
                        widget: Text('3000'),
                      ),
                      heightBox12,
                      FeatureRow(
                        titleWeight: FontWeight.w400,
                        title: 'Subtotal',
                        widget: Row(
                          children: [
                            CrashSafeImage(
                              Assets.images.banana.keyName,
                              height: 12,
                              width: 12,
                            ),
                            widthBox5,
                            Text(
                              '3000',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.yellowColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      heightBox20,
                      StraightLiner(),
                      heightBox10,
                      FeatureRow(
                        titleWeight: FontWeight.w400,
                        title: 'Total',
                        widget: Text(
                          'Rs. 3000',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      heightBox10,
                    ],
                  ),

                  CustomElevatedButton(
                    title: 'Next',
                    onPress: () {
                      Get.to(() => ExchangeScreen());
                    },
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
