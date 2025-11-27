import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/chat/views/message_screen.dart';
import 'package:sandrofp/app/modules/profile/views/other_profile_screen.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class BuyerDetails extends StatelessWidget {
  final String? image;
  final String? name;
  final int? rating;
  final String? description;
  final String? id;
  const BuyerDetails({
    super.key,
    this.image,
    this.name,
    this.rating,
    this.description,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xffF3F3F5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(image ?? ''),
                      radius: 15,
                    ),
                    widthBox8,
                    Text(
                      name ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CrashSafeImage(
                      Assets.images.brushSheld.keyName,
                      height: 24,
                    ),
                    widthBox4,
                    Text(
                      'Beginer',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            heightBox10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CrashSafeImage(Assets.images.star.keyName, height: 24),
                widthBox4,
                Text(
                  '$rating (20 Reviews)',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            heightBox10,
            Text(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              description ?? '',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            heightBox10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: CustomElevatedButton(
                    color: Colors.transparent,
                    borderColor: Colors.black,
                    textColor: Colors.black,
                    title: 'View profile',
                    onPress: () {
                      Get.to(() => const OtherProfileScreen());
                    },
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: CustomElevatedButton(
                    color: Colors.black,
                    borderColor: Colors.black,
                    textColor: Colors.white,
                    title: 'Message',
                    onPress: () {
                      Get.to(() => ChatScreen());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
