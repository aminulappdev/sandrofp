import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:sandrofp/app/modules/authentication/widget/label_name_widget.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        leading: Container(),
        isBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              heightBox12,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 90,
                        backgroundColor: Color(0xffF3F3F5),
                        child: CircleAvatar(
                          radius: 85,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage(
                              Assets.images.onboarding01.keyName,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        child: Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1, color: Colors.white),
                            color: Color(0xffF3F3F5),
                          ),
                          child: Center(
                            child: CrashSafeImage(
                              Assets.images.add.keyName,
                              color: AppColors.greenColor,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              heightBox12,

              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightBox10,
                    LabelName(label: 'Username'),
                    heightBox10,
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your username',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    heightBox20,
                    LabelName(label: 'Email'),
                    heightBox10,
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    heightBox20,
                    LabelName(label: 'Phone Number'),
                    heightBox10,
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your phone number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    heightBox20,
                    LabelName(label: 'About user'),
                    heightBox10,
                    TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    heightBox20,
                  ],
                ),
              ),

              heightBox12,
              CustomElevatedButton(title: 'Save changes', onPress: () {
                showSnackBarMessage(context, 'Profile updated successfully');
              }),
              heightBox12
            ],
          ),
        ),
      ),
    );
  }
}
