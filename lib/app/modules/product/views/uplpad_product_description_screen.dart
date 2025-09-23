import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/cart/widget/status_card.dart';
import 'package:sandrofp/app/modules/home/widget/label_data.dart';
import 'package:sandrofp/app/modules/product/views/upload_file_screen.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class UploadProductDescriptionScreen extends StatefulWidget {
  const UploadProductDescriptionScreen({super.key});

  @override
  State<UploadProductDescriptionScreen> createState() =>
      _UploadProductDescriptionScreenState();
}

class _UploadProductDescriptionScreenState
    extends State<UploadProductDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Product information',
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
                'Product Description',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox12,
              Label(label: 'Size'),
              heightBox8,
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffF3F3F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      LabelData(bgColor: Colors.white, title: 'M'),
                      widthBox8,
                      LabelData(bgColor: Colors.white, title: 'L'),
                      widthBox8,
                      LabelData(bgColor: Colors.white, title: 'XL'),
                      widthBox8,
                      LabelData(bgColor: Colors.white, title: 'XXL'),
                    ],
                  ),
                ),
              ),
              heightBox12,
              Label(label: 'Size Parameters'),
              heightBox8,
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffF3F3F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          LabelData(bgColor: Colors.white, title: 'M'),
                          widthBox8,
                          LabelData(bgColor: Colors.white, title: 'L'),
                          widthBox8,
                          LabelData(bgColor: Colors.white, title: 'XL'),
                          widthBox8,
                          LabelData(bgColor: Colors.white, title: 'XXL'),
                        ],
                      ),
                      heightBox8,
                      Row(
                        children: [
                          LabelData(bgColor: Colors.white, title: 'M'),
                          widthBox8,
                          LabelData(bgColor: Colors.white, title: 'L'),
                          widthBox8,
                          LabelData(bgColor: Colors.white, title: 'XL'),
                          widthBox8,
                          LabelData(bgColor: Colors.white, title: 'XXL'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              heightBox12,
              Label(label: 'Category'),
              heightBox8,
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffF3F3F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      LabelData(bgColor: Colors.white, title: 'M'),
                      widthBox8,
                      LabelData(bgColor: Colors.white, title: 'L'),
                    ],
                  ),
                ),
              ),
              heightBox12,
              Label(label: 'Sub-Category'),
              heightBox8,
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffF3F3F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      LabelData(bgColor: Colors.white, title: 'M'),
                      widthBox8,
                      LabelData(bgColor: Colors.white, title: 'L'),
                      widthBox8,
                    ],
                  ),
                ),
              ),
              heightBox12,
              Label(label: 'Sub-Category'),
              heightBox8,
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffF3F3F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      LabelData(bgColor: Colors.white, title: 'M'),
                      widthBox8,
                      LabelData(bgColor: Colors.white, title: 'L'),
                      widthBox8,
                    ],
                  ),
                ),
              ),
              heightBox12,
              Label(label: 'Material'),
              heightBox8,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your material',
                ),
              ),
              heightBox20,
              CustomElevatedButton(title: 'Next', onPress: () {
                 Get.to(UploadProductFileScreen());
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
