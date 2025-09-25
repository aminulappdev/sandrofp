import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/cart/widget/status_card.dart';
import 'package:sandrofp/app/modules/product/views/product_details_screen.dart';
import 'package:sandrofp/app/modules/home/widget/label_data.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/image_container.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class UploadProductFileScreen extends StatefulWidget {
  const UploadProductFileScreen({super.key});

  @override
  State<UploadProductFileScreen> createState() =>
      _UploadProductFileScreenState();
}

class _UploadProductFileScreenState extends State<UploadProductFileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Upload Product',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              heightBox12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffEBF2EE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6,
                      ),
                      child: Text(
                        'Undo',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greenColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffEBF2EE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6,
                      ),
                      child: Text(
                        'Save',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greenColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              heightBox20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffEBF2EE),
                        radius: 25,
                        child: CrashSafeImage(
                          Assets.images.group02.keyName,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      heightBox4,
                      SizedBox(
                        child: Text(
                          'Information',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  FlowWidget(),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffEBF2EE),
                        radius: 25,
                        child: CrashSafeImage(
                          Assets.images.group02.keyName,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      heightBox4,
                      SizedBox(
                        child: Text(
                          'Description',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),

                  FlowWidget(),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffEBF2EE),
                        radius: 25,
                        child: CrashSafeImage(
                          Assets.images.group02.keyName,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      heightBox16,
                      SizedBox(
                        child: Text(
                          'Upload',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              heightBox14,
              Text(
                'Product image',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox4,
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),

              heightBox12,
              ImageContainer(
                height: 200,
                width: double.infinity,
                imagePath: Assets.images.onboarding01.keyName,
                radius: 20,
              ),
              heightBox10,
               Text(
                'Image should be 380* 200*',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffFF0000),
                ),
              ),
             
              heightBox20,
              CustomElevatedButton(
                color: Colors.transparent,
                textColor: Colors.black,
                borderColor: Colors.black,
                title: 'Add more photos', onPress: () {}),
              heightBox20,
              CustomElevatedButton(title: 'Next', onPress: () {
                Get.to(()=>ProductDetailsScreen());
              }),
              heightBox20,
            ],
          ),
        ),
      ),
    );
  }
}

class Label extends StatelessWidget {
  final String label;
  const Label({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}
