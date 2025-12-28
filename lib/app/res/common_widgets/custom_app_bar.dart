import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isBack;
  final String title;
  final Widget leading;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.leading,
    this.isBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 9,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        image: DecorationImage(
          image: AssetImage(Assets.images.appBarBackground.keyName),
          fit: BoxFit.fill,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: isBack == true ? () => Navigator.pop(context) : null,
                  child: isBack == true
                      ? CrashSafeImage(
                          Assets.images.rreturn.keyName,
                          height: 22,
                          width: 22,
                        )
                      : const SizedBox.shrink(),
                ),
                isBack == false ? widthBox10 : widthBox4,
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            leading,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110); // Add this line
}
