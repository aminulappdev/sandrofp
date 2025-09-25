import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/cart/views/cart_screen.dart';
import 'package:sandrofp/app/modules/exchange/views/exchange_screen.dart';
import 'package:sandrofp/app/modules/home/widget/buyer_details.dart';
import 'package:sandrofp/app/modules/home/widget/color_plate.dart';
import 'package:sandrofp/app/modules/home/widget/feature_row.dart';
import 'package:sandrofp/app/modules/home/widget/label_data.dart';
import 'package:sandrofp/app/modules/home/widget/product_static_data.dart';
import 'package:sandrofp/app/modules/exchange/views/exchange_screen.dart';
import 'package:sandrofp/app/modules/exchange/views/exchange_completed_screen.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/image_container.dart';
import 'package:sandrofp/app/res/common_widgets/straight_liner.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Back',
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
      body: SingleChildScrollView(
        // Add this wrapper
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox12,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Remove Expanded and just use ListView.builder directly
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageContainer(
                          height: 200,
                          width: double.infinity,
                          imagePath: Assets.images.onboarding01.keyName,
                          radius: 20,
                        ),

                        heightBox12,
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: ImageContainer(
                                height: 80,
                                width: 80,
                                imagePath: Assets.images.onboarding01.keyName,
                                radius: 20,
                              ),
                            ),
                            itemCount: 5,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ),
                        heightBox10,
                        BuyerDetails(),
                        heightBox20,
                        ProductStaticData(),
                        Text(
                          'Product Details',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        heightBox10,

                        FeatureRow(
                          title: 'Size:',
                          widget: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: LabelData(
                                  bgColor: AppColors.greenColor,
                                  title: 'L',
                                  titleColor: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: LabelData(
                                  bgColor: Color(0xffF3F3F5),
                                  title: 'XL',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: LabelData(
                                  bgColor: Color(0xffF3F3F5),
                                  title: 'XXL',
                                ),
                              ),
                            ],
                          ),
                        ),

                        heightBox20,
                        StraightLiner(),

                        heightBox10,

                        FeatureRow(
                          title: 'Brand:',
                          widget: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: LabelData(
                                  bgColor: AppColors.greenColor,
                                  title: 'Gucci',
                                  titleColor: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: LabelData(
                                  bgColor: Color(0xffF3F3F5),
                                  title: 'Zara',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: LabelData(
                                  bgColor: Color(0xffF3F3F5),
                                  title: 'Lotto',
                                ),
                              ),
                            ],
                          ),
                        ),

                        heightBox20,
                        StraightLiner(),

                        heightBox10,

                        FeatureRow(
                          title: 'Category:',
                          widget: Text(
                            'T-shirt',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff595959),
                            ),
                          ),
                        ),

                        heightBox20,
                        StraightLiner(),

                        heightBox10,

                        FeatureRow(
                          title: 'Color:',
                          widget: Row(
                            children: [
                              ColorPlate(color: Color.fromARGB(255, 1, 54, 88)),
                              ColorPlate(
                                color: Color.fromARGB(255, 51, 51, 150),
                              ),
                              ColorPlate(
                                color: Color.fromARGB(255, 24, 156, 101),
                              ),
                            ],
                          ),
                        ),

                        heightBox20,
                        StraightLiner(),

                        heightBox10,

                        FeatureRow(
                          title: 'Delivery Policy:',
                          widget: Text(
                            'Within 2 working days',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff595959),
                            ),
                          ),
                        ),

                        heightBox20,
                        StraightLiner(),
                        heightBox20,
                      ],
                    ),
                  ),

                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 160,
                              child: CustomElevatedButton(
                                color: Colors.transparent,
                                borderColor: AppColors.greenColor,
                                textColor: AppColors.greenColor,
                                title: 'Add to cart',
                                onPress: () {
                                  Get.to(() => CartScreen());
                                },
                              ),
                            ),
                            SizedBox(
                              width: 160,
                              child: CustomElevatedButton(
                                color: AppColors.greenColor,
 
                                textColor: Colors.white,
                                title: 'Exchange',
                                onPress: () {
                                  Get.to(() => ExchangeScreen());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
