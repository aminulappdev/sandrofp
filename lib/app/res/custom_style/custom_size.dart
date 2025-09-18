import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


final heightBox4 =  SizedBox(height: 4.h,);
final heightBox5 =  SizedBox(height: 5.h,);
final heightBox8 = SizedBox(height: 8.h,);
final heightBox10 = SizedBox(height: 10.h,);
final heightBox12 = SizedBox(height: 12.h,);
final heightBox14 = SizedBox(height: 14.h,);
final heightBox16 = SizedBox(height: 16.h,);
final heightBox20 = SizedBox(height: 20.h,);
final heightBox24 = SizedBox(height: 24.h,);
final heightBox30 = SizedBox(height: 30.h,);
final heightBox40 = SizedBox(height: 40.h,);
final heightBox50 = SizedBox(height: 50.h,);
final heightBox100 = SizedBox(height: 100.h,);

final widthBox4 = SizedBox(width: 4.w,);
final widthBox5 = SizedBox(width: 5.w,);
final widthBox8 = SizedBox(width: 8.w,);
final widthBox10 = SizedBox(width: 10.w,);
final widthBox12 = SizedBox(width: 12.w,);
final widthBox14 = SizedBox(width: 14.w,);
final widthBox20 = SizedBox(width: 20.w,);
final widthBox15 = SizedBox(width: 15.w,);
final widthBox40 = SizedBox(width: 40.w,);
final widthBox50 = SizedBox(width: 50.w,);


// Extensions on int for Responsive Width & Height
extension SpacingExtension on int {
  Widget get widthBox => SizedBox(width: w);  // ✅ Correct usage of ScreenUtil
  Widget get heightBox => SizedBox(height: h); // ✅ Correct usage of ScreenUtil
}
