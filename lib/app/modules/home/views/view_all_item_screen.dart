// lib/app/modules/home/views/view_all_item_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/home/controller/home_controller.dart';
import 'package:sandrofp/app/modules/home/controller/view_all_item_controller.dart';
import 'package:sandrofp/app/modules/home/widget/home_product_card.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ViewAllItemScreen extends GetView<ViewAllItemController> {
  const ViewAllItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.title ?? 'All Items',
        leading: Row(
          children: [
            CircleIconWidget(
              radius: 20,
              iconRadius: 20,
              color: const Color(0xffFFFFFF).withOpacity(0.05),
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
      body: RefreshIndicator(
        onRefresh: controller.refresh, // <-- এটাই Pull to Refresh
        color: Colors.blue,
        child: Obx(() {
          final allProductController = controller.allProductController;

          if (allProductController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = allProductController.allProductItems;
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No products found',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: HomeProductCard(
                  onTap: () {
                    Get.find<HomeController>().goToProductDetails(product);
                  },
                  imagePath: product.images.isNotEmpty ? product.images.first.url : '',
                  price: '৳${product.price}',
                  ownerName: product.name,
                  description: product.descriptions,
                  address: product.author?.name ?? 'Unknown',
                  discount: '${product.discount}% OFF',
                  distance: '2.5 km',
                  rating: '4.5',
                  profile: product.author?.profile,
                  title: product.brands,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}