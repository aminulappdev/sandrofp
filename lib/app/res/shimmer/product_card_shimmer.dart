import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardShimmerEffectWidget extends StatelessWidget {
  const ProductCardShimmerEffectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          // First Card
          Expanded(
            child: _buildShimmerCard(),
          ),
          SizedBox(width: 12.w),
          // Second Card
          Expanded(
            child: _buildShimmerCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      height: 550.h,
      decoration: BoxDecoration(
        color: Colors.white, // Important for shimmer visibility
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}