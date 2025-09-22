import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/cart/views/product_card_page.dart';
import 'package:sandrofp/app/modules/cart/widget/product_cart.dart';
import 'package:sandrofp/app/modules/cart/widget/status_card.dart';
import 'package:sandrofp/app/modules/home/widget/feature_row.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/straight_liner.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ExchangeProcessScreen extends StatefulWidget {
  const ExchangeProcessScreen({super.key});

  @override
  State<ExchangeProcessScreen> createState() => _ExchangeProcessScreenState();
}

class _ExchangeProcessScreenState extends State<ExchangeProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Exchange Process',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            heightBox12,
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Processing Details',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    heightBox4,
                    Text(
                      'On time we got your exchange offer',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    heightBox4,
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffFFFCEB),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CrashSafeImage(
                              Assets.images.warning.keyName,
                              height: 18,
                              width: 18,
                              color: Color(0xff998523),
                            ),
                            widthBox8,
                            Expanded(
                              child: Text(
                                'You have insufficient token balance please add manually otherwise you won’t be',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff998523),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    heightBox30,
                    StatusCard(),

                    heightBox10,
                    Text(
                      'Processing Details',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    heightBox4,
                    Text(
                      'On time we got your exchange offer',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    heightBox20,

                    Row(
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
                          'View',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.greenColor,
                          ),
                        ),
                      ],
                    ),
                    ProductCart(),

                    heightBox10,
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Processing Details',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              heightBox4,
                              Text(
                                'On time we got your exchange offer',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              heightBox16,
                              FeatureRow(title: 'Exchange Id', widget: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFCEB),
                                  borderRadius: BorderRadius.circular(20),),
                               
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'AHJF2132',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffCCB12E),
                                    ),
                                  ),
                                ),
                              )),
                              heightBox20,
                              FeatureRow(title: 'Request from:', widget: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3F3F5),
                                  borderRadius: BorderRadius.circular(20),),
                               
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      CrashSafeImage(
                                        Assets.images.person.keyName,
                                        height: 14,
                                        width: 14,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      widthBox8,
                                      Text(
                                        'AHJF2132',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                              heightBox20,
                              FeatureRow(title: 'Request to:', widget: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3F3F5),
                                  borderRadius: BorderRadius.circular(20),),
                               
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      CrashSafeImage(
                                        Assets.images.person.keyName,
                                        height: 14,
                                        width: 14,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      widthBox8,
                                      Text(
                                        'AHJF2132',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),

                              heightBox20,
                              FeatureRow(title: 'Request date:', widget: Text(
                                '20 Sep 2022',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    heightBox20,
                    CustomElevatedButton(
                      color: Colors.grey,
                      title: 'Exchange ', onPress: () {
                        Get.to(() => ProductCardScreen());
                      },),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
