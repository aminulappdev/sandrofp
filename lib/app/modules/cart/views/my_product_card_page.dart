import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/cart/widget/product_cart.dart';
import 'package:sandrofp/app/modules/product/controller/delete_product_controller.dart';
import 'package:sandrofp/app/modules/product/views/edit_product_screen.dart';
import 'package:sandrofp/app/modules/product/views/upload_product_info_screen.dart';
import 'package:sandrofp/app/modules/profile/controllers/my_product_controller.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/common_widgets/custom_dialog.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class MyProductCardScreen extends StatefulWidget {
  const MyProductCardScreen({super.key});

  @override
  State<MyProductCardScreen> createState() => _MyProductCardScreenState();
}

class _MyProductCardScreenState extends State<MyProductCardScreen> {
  final MyProductController myProductController =
      Get.find<MyProductController>();
  final DeleteProductController deleteProductController = Get.put(
    DeleteProductController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Product Card',
        leading: Row(
          children: [
            CircleIconWidget(
              radius: 20,
              iconRadius: 20,
              color: const Color(0xffFFFFFF).withValues(alpha: 0.05),
              imagePath: Assets.images.notification.keyName,
              onTap: () {},
            ),
            widthBox10,
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(Assets.images.onboarding01.keyName),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Part (Fixed)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Processing Details',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                heightBox4,
                Text(
                  'On time we got your exchange offer',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                heightBox10,
                CustomElevatedButton(
                  title: 'Add Product',
                  onPress: () {
                    Get.to(() => UploadProductInfoScreen());
                  },
                  borderColor: AppColors.greenColor,
                  color: Colors.transparent,
                  textColor: AppColors.greenColor,
                ),
                heightBox10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'My Products',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // List Part - Fixed with Expanded
          Expanded(
            child: Obx(() {
              if (myProductController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 0,
                  ),
                  itemCount: myProductController.allProductItems.length,
                  itemBuilder: (context, index) {
                    var product = myProductController.allProductItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: ProductCart(
                        onDelete: () {
                          _showLogoutDialog(
                            context,
                            productId: product.id ?? '',
                          );
                        },
                        onEdit: () {
                          Get.to(
                            () => EditProductScreen(),
                            arguments: {'data': product},
                          );
                        },
                        productImage: product.images.first.url,
                        address: product.name,
                        productName: product.name,
                        productPrice: product.price.toString(),
                        description: product.descriptions,
                      ),
                    );
                  },
                );
              }
            }),
          ),
          heightBox100,
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, {required String productId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          yesText: 'Yes',
          noText: 'No',
          noOntap: () {
            Navigator.pop(context);
          },
          yesOntap: () {
            deleteProductController.deleteProduct(productId);
          },
          iconData: Icons.delete,
          subtitle: '',
          title: 'Do you want to Delete this product?',
        );
      },
    );
  }
}
