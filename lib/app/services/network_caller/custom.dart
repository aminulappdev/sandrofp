import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';

Future<void> showLoadingOverLay({
  required Future<void> Function() asyncFunction,
  String? msg, 
}) async {
  await Get.showOverlay(
    asyncFunction: () async {
      try {
        await asyncFunction();
      } catch (e, stack) {
        Logger().e(e);
        Logger().e(stack);
      }
    },
    loadingWidget: Center(child: _getLoadingIndicator(msg: msg)),
    opacity: 0.7,
    opacityColor: Colors.black,
  );
}

Widget _getLoadingIndicator({String? msg}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 24.h,
          width: 24.w,
          child: Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
              color: Colors.black,
              size: 24,
            ),
          ),
        ),
        12.verticalSpace,
        Text(msg ?? 'Please wait', style: Get.textTheme.bodyLarge),
      ],
    ),
  );
}
