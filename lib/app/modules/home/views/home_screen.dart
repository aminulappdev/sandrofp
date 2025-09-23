import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/views/product_details_screen.dart';
import 'package:sandrofp/app/modules/home/views/view_all_item_screen.dart';
import 'package:sandrofp/app/modules/home/widget/category_header.dart';
import 'package:sandrofp/app/modules/home/widget/category_image.dart';
import 'package:sandrofp/app/modules/home/widget/home_product_card.dart';
import 'package:sandrofp/app/modules/home/widget/homepage_header.dart';
import 'package:sandrofp/app/modules/product/views/upload_product_info_screen.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [
      HomeProductCard(
        onTap: () {
          Get.to(ProductDetailsScreen());
        },
      ),
      HomeProductCard(
        onTap: () {
          Get.to(UploadProductInfoScreen());
        },
      ),
      HomeProductCard(
        onTap: () {
          Get.to(ProductDetailsScreen());
        },
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 340,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                image: DecorationImage(
                  image: AssetImage(Assets.images.background.keyName),
                  fit: BoxFit.fill,
                ),
              ),

              child: HomepageHeader(
                imagePath: Assets.images.onboarding01.keyName,
                name: 'Aminul',
                ammount: '5000',
                notificationAction: () {},
                settingsAction: () {},
                arrowAction: () {},
              ),
            ),
            heightBox12,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exchange by items',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    heightBox8,
                    Row(
                      children: [
                        Column(
                          children: [
                            CategoryImage(
                              height: 110,
                              width: 160,
                              imagePath: Assets.images.onboarding01.keyName,
                              name: 'Electronics',
                              onTap: () {},
                            ),
                            heightBox8,
                            CategoryImage(
                              height: 110,
                              width: 160,
                              imagePath: Assets.images.onboarding01.keyName,
                              name: 'Electronics',
                              onTap: () {},
                            ),
                          ],
                        ),
                        widthBox10,
                        Column(
                          children: [
                            CategoryImage(
                              height: 72,
                              width: 154,
                              imagePath: Assets.images.onboarding01.keyName,
                              name: 'Clothing',
                              onTap: () {},
                            ),
                            heightBox8,
                            CategoryImage(
                              height: 72,
                              width: 154,
                              imagePath: Assets.images.onboarding01.keyName,
                              name: 'Clothing',
                              onTap: () {},
                            ),
                            heightBox8,
                            CategoryImage(
                              height: 72,
                              width: 154,
                              imagePath: Assets.images.onboarding01.keyName,
                              name: 'Clothing',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    heightBox12,

                    CategoryHeader(
                      name: 'Matches products',
                      onTap: () {
                        Get.to(() => const ViewAllItemScreen());
                      },
                    ),
                    heightBox10,
                    SizedBox(
                      height: 550,
                      width: double.infinity,
                      child: CardSwiper(
                        padding: EdgeInsets.only(left: 0, right: 12),
                        scale: 0.98,
                        backCardOffset: Offset(12, 0), // কম offset (40 থেকে 20)
                        numberOfCardsDisplayed: 2, // আরো কার্ড দেখানোর জন্য
                        cardsCount: cards.length,
                        cardBuilder:
                            (
                              context,
                              index,
                              percentThresholdX,
                              percentThresholdY,
                            ) => cards[index],
                      ),
                    ),
                    heightBox12,

                    CategoryHeader(name: 'Matches products', onTap: () {}),
                    heightBox10,

                    SizedBox(
                      height: 550,
                      width: double.infinity,
                      child: CardSwiper(
                        padding: EdgeInsets.only(left: 0, right: 12),
                        scale: 0.98,
                        backCardOffset: Offset(12, 0), // কম offset (40 থেকে 20)
                        numberOfCardsDisplayed: 2, // আরো কার্ড দেখানোর জন্য
                        cardsCount: cards.length,
                        cardBuilder:
                            (
                              context,
                              index,
                              percentThresholdX,
                              percentThresholdY,
                            ) => cards[index],
                      ),
                    ),
                    heightBox100,
                    heightBox100,
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
