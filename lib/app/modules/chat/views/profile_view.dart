import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/profile/views/other_profile_screen.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ProfileViewPage extends StatelessWidget {
  final String id;
  final String name;
  final String? image;

  const ProfileViewPage({
    super.key,
    required this.name,
    this.image,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        leading: Container(),
        isBack: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 110,
                        backgroundColor: const Color(0xffF3F3F5),
                        child: CircleAvatar(
                          radius: 102,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 94,
                            backgroundImage: NetworkImage(image ?? ''),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 50,
                        child: Container(
                          height: 42,
                          width: 138,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white),
                            color: const Color(0xffF3F3F5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CrashSafeImage(
                                Assets.images.brushSheld.keyName,
                                height: 20,
                              ),
                              widthBox8,
                              Text(
                                'Buyer',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.more_horiz, size: 40),
                  // ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  widthBox8,
                  CrashSafeImage(Assets.images.checked.keyName, height: 30),
                ],
              ),

              // Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CrashSafeImage(Assets.images.star.keyName, height: 30),
                  widthBox8,
                  Text(
                    '0.0',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                  ),
                  widthBox8,
                  Text(
                    '()',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
 
              heightBox10,
              CustomElevatedButton(
                title: 'View Profile',
                onPress: () {
                  Get.to(() => OtherProfileScreen(), arguments: {'id': id});
                },
              ),

              heightBox10,
            ],
          ),
        ),
      ),
    );
  }
}
