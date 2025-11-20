import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsHeader extends StatelessWidget {
  final String imagePath;
  final String name;
  final VoidCallback onTap;
  final String rating;
  const SettingsHeader({
    super.key,
    required this.imagePath,
    required this.name,
    required this.onTap,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffF3F3F5),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 24.r,
                    child: CircleAvatar(
                      radius: 22.r,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundImage: NetworkImage(imagePath),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '$rating Rating',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: onTap,
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
