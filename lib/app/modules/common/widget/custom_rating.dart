// lib/app/res/common_widgets/custom_star_rating.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStarRating extends StatelessWidget {
  final int rating;                    // Current rating (0-5)
  final int starCount;                 // Total stars (default 5)
  final double size;                   // Star size
  final Color filledColor;
  final Color unfilledColor;
  final Function(int) onRatingChanged; // Callback when user taps

  const CustomStarRating({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.size = 40.0,
    this.filledColor = Colors.amber,
    this.unfilledColor = const Color(0xFFDDDDDD),
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        return GestureDetector(
          onTap: () => onRatingChanged(index + 1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: size.w,
            height: size.w,
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            child: Icon(
              index < rating ? Icons.star_rounded : Icons.star_border_rounded,
              color: index < rating ? filledColor : unfilledColor,
              size: size.w,
            ),
          ),
        );
      }),
  );
  }
}