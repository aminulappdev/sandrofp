import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerEffectWidget extends StatelessWidget {
  const HomeShimmerEffectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 202, 201, 201),
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: height - 200,
        child: SingleChildScrollView(
          child: Column(children: [shimmerC(height, width)]),
        ),
      ),
    );
  }

  Padding shimmerC(double height, double width) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 24.r),
                  widthBox10,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.grey,
                        ),
                        height: height / 24,
                        width: width / 3,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 20.r),
                  widthBox4,
                  CircleAvatar(radius: 20.r),
                ],
              ),
            ],
          ),
          heightBox16,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Colors.grey,
            ),
            height: height / 6,
            width: width,
          ),
        ],
      ),
    );
  }
}
