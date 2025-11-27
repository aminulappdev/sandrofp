import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class HomepageHeader extends StatelessWidget {
  final String imagePath;
  final String name;
  final String ammount;
  final VoidCallback notificationAction;
  final VoidCallback settingsAction;
  final VoidCallback arrowAction;
  final VoidCallback imageOnTap;

  const HomepageHeader({
    super.key,
    required this.imagePath,
    required this.name,
    required this.ammount,
    required this.notificationAction,
    required this.settingsAction,
    required this.arrowAction,
    required this.imageOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: imageOnTap,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: imagePath == ''
                          ? null
                          : NetworkImage(imagePath),
                      child: imagePath == ''
                          ? const Icon(Icons.person, size: 30)
                          : Container(),
                    ),
                  ),
                  widthBox8,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Hi, ',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: '$name!',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
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
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  CircleIconWidget(
                    radius: 20,
                    iconRadius: 20,
                    color: Color(0xFFFFFFFF).withValues(alpha: 0.05),
                    imagePath: Assets.images.notification.keyName,
                    onTap: notificationAction,
                  ),
                  widthBox10,
                  CircleIconWidget(
                    radius: 20,
                    iconRadius: 20,
                    color: Color(0xFFFFFFFF).withValues(alpha: 0.05),
                    imagePath: Assets.images.filter.keyName,
                    onTap: settingsAction,
                  ),
                ],
              ),
            ],
          ),
          heightBox14,
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF).withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Balance',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          CrashSafeImage(
                            Assets.images.banana.keyName,
                            height: 16,
                          ),
                          widthBox10,
                          Text(
                            ammount,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.yellowColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  heightBox10,
                  Container(
                    height: 0.3,
                    width: double.infinity,
                    color: Color(0xFFFFFFFF),
                  ),
                  heightBox10,
                  Row(
                    children: [
                      CrashSafeImage(Assets.images.bag.keyName, height: 16),
                      widthBox10,
                      Text(
                        'Buy banana tokens ',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  heightBox10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 260,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur our adipiscing elit Maecenas hendrerit',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      CircleIconWidget(
                        imagePath: Assets.images.arrowFont.keyName,
                        onTap: arrowAction,
                        color: Color(0xFFFFFFFF).withValues(alpha: 0.05),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // heightBox20,

          // TextFormField(
          //   decoration: InputDecoration(
          //     prefixIcon: Icon(Icons.search, color: Colors.black, size: 28),
          //     hintText: 'Looking for..',
          //     fillColor: Colors.white,
          //   ),
          // ),
        ],
      ),
    );
  }
}
