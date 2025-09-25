import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart'
    show IntlPhoneField;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/cart/views/my_product_card_page.dart';
import 'package:sandrofp/app/modules/cart/widget/exchange_card.dart';
import 'package:sandrofp/app/modules/cart/widget/product_cart.dart';
import 'package:sandrofp/app/modules/cart/widget/status_card.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class TokenExchangeScreen extends StatefulWidget {
  const TokenExchangeScreen({super.key});

  @override
  State<TokenExchangeScreen> createState() => _TokenExchangeScreenState();
}

class _TokenExchangeScreenState extends State<TokenExchangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Exchange Process',
        leading: Row(
          children: [
            CircleIconWidget(
              radius: 20,
              iconRadius: 20,
              color: Color(0xffFFFFFF).withValues(alpha: 0.05),
              imagePath: Assets.images.notification.keyName,
              onTap: () {},
            ),
            widthBox10,
            CircleAvatar(
              backgroundImage: AssetImage(Assets.images.onboarding01.keyName),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            heightBox12,
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CrashSafeImage(
                          Assets.images.banana.keyName,
                          height: 16,
                        ),
                        widthBox10,

                        Text(
                          '100 banana token equals',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '1.00',
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' United States Dollar',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.greenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur our adipiscing elit. Maecenas hendrerit luctus libero accused vulputate.',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    heightBox16,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 140,
                          child: IntlPhoneField(
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              labelText: '10',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            initialCountryCode: 'IN',
                            onChanged: (phone) {
                              print(phone.completeNumber);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: CrashSafeImage(
                            Assets.images.exchange.keyName,
                            height: 24,
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              labelText: '100',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    heightBox20,
                    CustomElevatedButton(
                      title: 'Exchange ',
                      onPress: () {
                        showSnackBarMessage(context, 'Successfully Exchange');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
