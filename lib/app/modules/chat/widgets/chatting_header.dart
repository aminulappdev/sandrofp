import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/profile/views/other_profile_screen.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

// ==================== Profile View Page (Optional) ====================

// =============================
// তোমার ফাইনাল ChatHeader (100% কাজ করবে)
// =============================
class ChatHeader extends StatelessWidget {
  final String? id;
  final String? name;
  final String? image;

  final bool? isOnline;

  const ChatHeader({super.key, this.name, this.image, this.isOnline, this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        image: DecorationImage(
          image: AssetImage(Assets.images.background.keyName),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Left Side: Avatar + Name + Online Status
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: (image != null && image!.isNotEmpty)
                            ? NetworkImage(image!)
                            : const AssetImage(
                                    "assets/images/default_avatar.png",
                                  )
                                  as ImageProvider,
                      ),
                    ),
                    widthBox10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name ?? 'User',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Seller',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xffFFDD3A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Right Side: More Options (Dropdown)
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 30,
                  ),
                  color: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  offset: const Offset(0, 10), // নিচে সামান্য গ্যাপ
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'view_profile',
                      child: Row(
                        children: const [
                          Icon(Icons.person_outline, color: Colors.deepPurple),
                          SizedBox(width: 12),
                          Text(
                            "View Profile",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'view_profile') {
                      Get.to(() => OtherProfileScreen(), arguments: {'id': id});
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
