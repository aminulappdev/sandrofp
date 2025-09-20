import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/widget/home_product_card.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ViewAllItemScreen extends StatefulWidget {
  const ViewAllItemScreen({super.key});

  @override
  State<ViewAllItemScreen> createState() => _ViewAllItemScreenState();
}

class _ViewAllItemScreenState extends State<ViewAllItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Items',
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
      body: SingleChildScrollView(  // Add this wrapper
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox12,
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Furniture items',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  heightBox8,
                  // Remove Expanded and just use ListView.builder directly
                  ListView.builder(
                    shrinkWrap: true,  // Add this
                    physics: NeverScrollableScrollPhysics(),  // Add this
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return HomeProductCard(onTap: () {
                        
                      },);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}