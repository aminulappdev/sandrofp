import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Liner extends StatelessWidget {
  final String title;
  const Liner({
     super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 140.w,
            height: 1.5.h,
            color: Color.fromARGB(255, 193, 191, 191),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, color: Colors.black,fontWeight: FontWeight.w500),
          ),
          Container(
            width: 140.w,
            height: 1.5.h,
            color: const Color.fromARGB(255, 193, 191, 191),
          ),
        ],
      ),
    );
  }
}
