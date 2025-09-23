import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/widget/feature_row.dart';
import 'package:sandrofp/app/modules/home/widget/home_product_card.dart';
import 'package:sandrofp/app/modules/home/widget/label_data.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile', leading: Container()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              heightBox12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 40),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 120,
                        backgroundColor: Color(0xffF3F3F5),
                        child: CircleAvatar(
                          radius: 112,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 104,
                            backgroundImage: AssetImage(
                              Assets.images.onboarding01.keyName,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 50,
                        child: Container(
                          height: 42,
                          width: 138,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1, color: Colors.white),
                            color: Color(0xffF3F3F5),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CrashSafeImage(
                                  Assets.images.brushSheld.keyName,
                                  height: 20,
                                ),
                                widthBox8,
                                Text(
                                  'Beginner',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_horiz, size: 40),
                  ),
                ],
              ),
              heightBox12,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sandro Fernando',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  widthBox8,
                  CrashSafeImage(Assets.images.checked.keyName, height: 30),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CrashSafeImage(Assets.images.star.keyName, height: 30),
                  widthBox8,
                  Text(
                    '4.5',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  widthBox8,
                  Text(
                    '(100)',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              heightBox10,
              CustomElevatedButton(title: 'View Profile', onPress: () {}),
              heightBox20,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffF3F3F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User information',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      heightBox10,
                      FeatureRow(
                        titleWeight: FontWeight.w400,
                        title: 'Location',
                        widget: Text('New York', style: GoogleFonts.poppins()),
                      ),
                      heightBox10,
                      FeatureRow(
                        titleWeight: FontWeight.w400,
                        title: 'Age',
                        widget: Text('25', style: GoogleFonts.poppins()),
                      ),
                      heightBox10,
                      FeatureRow(
                        titleWeight: FontWeight.w400,
                        title: 'Gender',
                        widget: Text('Male', style: GoogleFonts.poppins()),
                      ),
                      heightBox10,
                      FeatureRow(
                        titleWeight: FontWeight.w400,
                        title: 'Height',
                        widget: Text('5\' 8"', style: GoogleFonts.poppins()),
                      ),
                    ],
                  ),
                ),
              ),
              heightBox12,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffF3F3F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User information',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      heightBox10,
                      Text(
                        'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humor, or randomized words which don t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isnt anything embarrassing hidden in the middle of text. All the Lorem Ipsum.',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              heightBox20,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffF3F3F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Exchange Categories',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      heightBox10,
                      Row(
                        children: [
                          LabelData(
                            bgColor: Color.fromARGB(255, 255, 255, 255),
                            titleColor: Colors.black,
                            title: 'Other',
                          ),
                          widthBox10,
                          LabelData(
                            bgColor: Color.fromARGB(255, 255, 255, 255),
                            titleColor: Colors.black,
                            title: 'Other',
                          ),
                          widthBox10,
                          LabelData(
                            bgColor: Color.fromARGB(255, 255, 255, 255),
                            titleColor: Colors.black,
                            title: 'Other',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              heightBox10,
              Text(
                'Clothing items',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox10,
              HomeProductCard(onTap: () {}),
              heightBox100,
            ],
          ),
        ),
      ),
    );
  }
}
