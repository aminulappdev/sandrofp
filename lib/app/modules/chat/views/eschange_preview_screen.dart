import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/cart/widget/product_cart.dart';
import 'package:sandrofp/app/modules/exchange/controller/exchange_by_id.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/services/location/address_fetcher.dart';

class EschangePreviewScreen extends StatefulWidget {
  final String? exchangeId;
  const EschangePreviewScreen({super.key, this.exchangeId});

  @override
  State<EschangePreviewScreen> createState() => _EschangePreviewScreenState();
}

class _EschangePreviewScreenState extends State<EschangePreviewScreen> {
  final ExchangeByIdController exchangeByIdController = Get.put(
    ExchangeByIdController(),
  );

  @override
  void initState() {
    if (widget.exchangeId != null) {
      exchangeByIdController.exchangeById(widget.exchangeId!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Exchange Data',
        leading: Container(),
        isBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            heightBox10,
            Obx(() {
              if (exchangeByIdController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                var data = exchangeByIdController.exchangeDetailsData;

                // ডিবাগিং জন্য লগ
                print('Exchange Data: $data');

                // products অ্যারে খালি কি না চেক করুন
                bool hasProducts =
                    data?.products != null && data!.products.isNotEmpty;
                bool hasExchangeWith =
                    data?.exchangeWith != null && data!.exchangeWith.isNotEmpty;

                print('Has Products: $hasProducts');
                print('Has Exchange With: $hasExchangeWith');

                // যদি কোন প্রোডাক্ট না থাকে
                if (!hasProducts && !hasExchangeWith) {
                  return Center(
                    child: Text(
                      'No products found in this exchange',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Exchange Product শুধুমাত্র দেখান যদি আছে
                        if (hasProducts)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Exchange Product',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              heightBox10,
                              // প্রথম প্রোডাক্টের জন্য
                              ProductCart(
                                productImage:
                                    data.products.first.images.isNotEmpty
                                    ? data.products.first.images.first.url ?? ''
                                    : '',
                                productName:
                                    data.products.first.name ?? 'No Name',
                                productPrice: data.products.first.price
                                    .toString(),
                                description:
                                    data.products.first.descriptions ??
                                    'No Description',
                                address: AddressHelper.getAddress(
                                  data.products.first.location?.coordinates[0],
                                  data.products.first.location?.coordinates[1],
                                ),
                                quantity: 1,
                                onQuantityChanged: (_) {},
                              ),
                            ],
                          ),

                        SizedBox(height: 20),

                        // Exchange With Product শুধুমাত্র দেখান যদি আছে
                        if (hasExchangeWith)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Exchange With Product',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              heightBox10,
                              // সব exchangeWith প্রোডাক্টের জন্য
                              ...data.exchangeWith.map((product) {
                                print('Exchange With Product: ${product.name}');
                                return Column(
                                  children: [
                                    ProductCart(
                                      productImage: product.images.isNotEmpty
                                          ? product.images.first.url ?? ''
                                          : '',
                                      productName: product.name ?? 'No Name',
                                      productPrice: product.price.toString(),
                                      description:
                                          product.descriptions ??
                                          'No Description',
                                      address: AddressHelper.getAddress(
                                        data
                                            .products
                                            .first
                                            .location
                                            ?.coordinates[0],
                                        data
                                            .products
                                            .first
                                            .location
                                            ?.coordinates[1],
                                      ),
                                      quantity: 1,
                                      onQuantityChanged: (_) {},
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
