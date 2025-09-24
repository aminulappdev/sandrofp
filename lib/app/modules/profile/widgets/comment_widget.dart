
import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                Assets.images.onboarding01.keyName,
              ),
            ),
            widthBox10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'McKenna T.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
               
                CrashSafeImage(
                  Assets.images.star.keyName,
                  height: 20,
                ),
              
                SizedBox(
                  width: 250,
                  child: Text(
                    'Sunghee was a great sitter and Dallas thoroughly enjoyed his stay.',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        heightBox10,
        Container(
          color: Color.fromARGB(255, 187, 186, 186),
          height: 1,
          width: double.infinity,)
      ],
    );
  }
}
