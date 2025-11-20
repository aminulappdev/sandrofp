import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class CommentSection extends StatelessWidget {
  final String? imagePath;
  final String? name;
  final String? title;
  final String? comment;
  final int? rating;

  const CommentSection({
    super.key,
    this.imagePath,
    this.name,
    this.comment,
    this.rating,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            CircleAvatar(
              radius: 20,
              backgroundImage: imagePath != null && imagePath!.isNotEmpty
                  ? NetworkImage(imagePath!)
                  : const AssetImage('assets/images/default_avatar.png')
                        as ImageProvider,
              onBackgroundImageError: (_, __) {},
              child: imagePath == null || imagePath!.isEmpty
                  ? const Icon(Icons.person, size: 20)
                  : null,
            ),
            widthBox10,

            // Content
            Expanded(
              // ← এটা খুব জরুরি! বাকি জায়গা নেবে
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    name ?? 'Anonymous',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  heightBox4,

                  // Star Rating (Horizontal)
                  Row(
                    children: List.generate(
                      rating ?? 0,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: CrashSafeImage(
                          Assets.images.star.path,
                          height: 16,
                          width: 16,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                  heightBox4,

                  // Title
                  if (title != null && title!.isNotEmpty)
                    Text(
                      title!,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                  // Comment
                  if (comment != null && comment!.isNotEmpty) ...[
                    heightBox4,
                    Text(
                      comment!,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),

        heightBox12,
        const Divider(height: 1, color: Color(0xFFBBBBBB)),
      ],
    );
  }
}
