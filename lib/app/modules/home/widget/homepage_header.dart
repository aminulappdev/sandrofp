import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class HomepageHeader extends StatefulWidget {
  final String imagePath;
  final String name;
  final String ammount;
  final VoidCallback notificationAction;
  final VoidCallback settingsAction;
  final VoidCallback arrowAction;
  final VoidCallback imageOnTap;
  final ScrollController scrollController;

  const HomepageHeader({
    super.key,
    required this.imagePath,
    required this.name,
    required this.ammount,
    required this.notificationAction,
    required this.settingsAction,
    required this.arrowAction,
    required this.imageOnTap,
    required this.scrollController,
  });

  @override
  State<HomepageHeader> createState() => _HomepageHeaderState();
}

class _HomepageHeaderState extends State<HomepageHeader> {
  double _balanceOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final scrollOffset = widget.scrollController.offset;
    // 0 থেকে 120 পিক্সেল স্ক্রলের মধ্যে fade out
    double opacity = 1.0 - (scrollOffset / 120.0);
    opacity = opacity.clamp(0.0, 1.0);

    if (opacity != _balanceOpacity) {
      setState(() {
        _balanceOpacity = opacity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: widget.imageOnTap,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: widget.imagePath.isEmpty
                          ? null
                          : NetworkImage(widget.imagePath),
                      child: widget.imagePath.isEmpty
                          ? const Icon(Icons.person, size: 30)
                          : null,
                    ),
                  ),
                  widthBox8,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Hi, ',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: '${widget.name}!',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.yellowColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Let\'s exchange',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  CircleIconWidget(
                    radius: 20,
                    iconRadius: 20,
                    color: Color(0xFFFFFFFF).withValues(alpha: 0.05),
                    imagePath: Assets.images.notification.keyName,
                    onTap: widget.notificationAction,
                  ),
                  widthBox10,
                  CircleIconWidget(
                    radius: 20,
                    iconRadius: 20,
                    color: Color(0xFFFFFFFF).withValues(alpha: 0.05),
                    imagePath: Assets.images.filter.keyName,
                    onTap: widget.settingsAction,
                  ),
                ],
              ),
            ],
          ),
          heightBox14,
          AnimatedOpacity(
            opacity: _balanceOpacity,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.18,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF).withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Balance',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            CrashSafeImage(
                              Assets.images.banana.keyName,
                              height: 16.h,
                            ),
                            widthBox10,
                            Text(
                              widget.ammount,
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.yellowColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    heightBox10,
                    Container(
                      height: 0.3,
                      width: double.infinity,
                      color: Color(0xFFFFFFFF),
                    ),
                    heightBox10,
                    Row(
                      children: [
                        CrashSafeImage(
                          Assets.images.bag.keyName,
                          height: 16,
                        ),
                        widthBox10,
                        Text(
                          'Buy banana tokens ',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    heightBox10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 260,
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur our adipiscing elit Maecenas hendrerit',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        CircleIconWidget(
                          imagePath: Assets.images.arrowFont.keyName,
                          onTap: widget.arrowAction,
                          color: Color(0xFFFFFFFF).withValues(alpha: 0.05),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}