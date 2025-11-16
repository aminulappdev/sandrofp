import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmerEffectWidget extends StatelessWidget {
  const CategoryShimmerEffectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 265.h,
      width: MediaQuery.of(context).size.width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: GridView.builder(
          padding: const EdgeInsets.all(0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 1.6,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
