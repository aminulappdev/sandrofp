// lib/app/modules/home/views/view_all_item_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/home/controller/home_controller.dart';
import 'package:sandrofp/app/modules/home/controller/view_all_item_controller.dart';
import 'package:sandrofp/app/modules/home/widget/home_product_card.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/services/location/address_fetcher.dart';

class ViewAllItemScreen extends GetView<ViewAllItemController> {
  const ViewAllItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.title ?? 'All Items',
        leading: Container(),
      ),
      body: RefreshIndicator(
        onRefresh: controller.refresh, // <-- এটাই Pull to Refresh
        color: Colors.blue,
        child: Obx(() {
          final allProductController = controller.allProductController;

          if (allProductController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (allProductController.allProductItems.isEmpty) {
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
              var updatePrice = product.price! - product.discount!;
              var lat = product.location?.coordinates[0];
              var lng = product.location?.coordinates[1];

              final address = AddressHelper.getAddress(lat, lng);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: HomeProductCard(
                  onTap: () {
                    Get.find<HomeController>().goToProductDetails(product);
                  },
                  imagePath: product.images.isNotEmpty
                      ? product.images.first.url
                      : '',
                  price: '\$$updatePrice',
                  ownerName: product.name,
                  description: product.descriptions,
                  address: address,
                  discount: '${product.discount}',
                  distance: '2.5 km',
                  rating: product.author?.avgRating.toString(),
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
