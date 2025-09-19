import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/authentication/views/verification_screen.dart';
import 'package:sandrofp/app/modules/authentication/widget/agree_condition_widget.dart';
import 'package:sandrofp/app/modules/authentication/widget/auth_header_widget.dart';
import 'package:sandrofp/app/modules/authentication/widget/label_name_widget.dart';
import 'package:sandrofp/app/modules/authentication/widget/liner_widger.dart';
import 'package:sandrofp/app/modules/authentication/widget/sign_up_widhet.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController roomNoCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RxString selectedSchool = 'Please select'.obs;

  bool _obscureText = true;
  bool _confirmObscureText = true;
  bool showButton = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox30,
              AuthHeaderWidget(
                title: 'Sign up',
                subtitle:
                    'There are many variations of passages of Lorem Ipsum available, but the majority...',
              ),
              heightBox20,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightBox10,
                    LabelName(label: 'Username'),
                    heightBox10,
                    TextFormField(
                      controller: firstNameCtrl,

                      decoration: const InputDecoration(
                        hintText: 'Enter your username',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    heightBox20,
                    LabelName(label: 'Email'),
                    heightBox10,
                    TextFormField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    heightBox20,
                    LabelName(label: 'Phone Number'),
                    heightBox10,
                    TextFormField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Enter your phone number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    heightBox20,
                    LabelName(label: 'Password'),
                    heightBox10,
                    TextFormField(
                      controller: passwordCtrl,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: '************',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                    heightBox20,
                    LabelName(label: 'Confirm password'),
                    heightBox10,
                    TextFormField(
                      controller: confirmPasswordCtrl,
                      obscureText: _confirmObscureText,
                      decoration: InputDecoration(
                        hintText: '************',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmObscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmObscureText = !_confirmObscureText;
                            });
                          },
                        ),
                      ),
                    ),

                    heightBox10,
                    AgreeConditionCheck(onChanged: (bool value) {}),
                    heightBox10,
                    CustomElevatedButton(title: 'Sign up', onPress: () {
                      Get.to(() => const OtpVerifyScreen(email: '', isVerify: false,));
                    }),
                    heightBox10,
                    Liner(title: 'Continue'), 
                    heightBox10,
                    CustomElevatedButton(
                      color: Colors.transparent,
                      textColor: Colors.black,
                      borderColor: Colors.grey,
                      iconData: Assets.images.google.keyName,
                      title: 'Login with Google',
                      onPress: () {},
                    ),
                    heightBox20,
                   
                  
                    Center(child: SignUpWidget()),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> onTabNextScreen() async {
  //   if (_formKey.currentState!.validate()) {
  //     final String fullName =
  //         '${firstNameCtrl.text.trim()} ${lastNameCtrl.text.trim()}';
  //     final AllSchoolItemModel selectedSchoolData = allSchoolController
  //         .allSchoolData
  //         .firstWhere(
  //           (school) => school.name == selectedSchool.value,
  //           orElse: () => AllSchoolItemModel(
  //             id: null,
  //             name: null,
  //             district: null,
  //             createdAt: null,
  //             updatedAt: null,
  //             v: null,
  //           ),
  //         );

  //     if (selectedSchoolData.id == null) {
  //       showSnackBarMessage(context, 'Please select a valid school', true);
  //       return;
  //     }

  //     if (mounted) {
  //       Get.off(
  //         () => AddProfileImageScreen(
  //           name: fullName,
  //           email: emailCtrl.text.trim(),
  //           room: roomNoCtrl.text.trim(),
  //           password: passwordCtrl.text.trim(),
  //           schoolName: selectedSchoolData.id ?? '',
  //           discrictId: widget.districtId ?? '',
  //         ),
  //       );
  //     }
  //   }
  // }
}
