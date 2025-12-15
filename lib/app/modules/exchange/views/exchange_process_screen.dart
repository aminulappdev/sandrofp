// exchange_process_screen.dart
import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sandrofp/app/modules/cart/widget/exchange_card.dart';
import 'package:sandrofp/app/modules/cart/widget/product_cart.dart';
import 'package:sandrofp/app/modules/cart/widget/status_card.dart';
import 'package:sandrofp/app/modules/common/views/feedback_screen.dart';
import 'package:sandrofp/app/modules/exchange/controller/exchange_process_controller.dart';
import 'package:sandrofp/app/modules/exchange/model/all_exchange_model.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/date_formatter.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ExchangeProcessScreen extends GetView<ExchangeProcessController> {
  const ExchangeProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExchangeProcessController controller = Get.put(
      ExchangeProcessController(),
    );

    AllExchangeItemModel exchangeData = controller.exchangeItemModel;
     DateFormatter dateFormatter = DateFormatter(
                        exchangeData.createdAt!
                      );
    return Scaffold(
      appBar: CustomAppBar(title: 'Exchange Process', leading: Container()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox12,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

                  heightBox12,
                  if (exchangeData.status == 'requested') ...{
                    InfoContainer(status: exchangeData.status),
                  } else if (exchangeData.status == 'rejected' ||
                      exchangeData.status == 'decline') ...{
                    InfoContainer(status: exchangeData.status),
                  },
                  if (exchangeData.status == 'requested') ...{
                    heightBox10,
                  } else if (exchangeData.status == 'rejected' ||
                      exchangeData.status == 'decline') ...{
                    heightBox10,
                  },

                  StatusCard(status: exchangeData.status),
                  heightBox10,
                  Text(
                    exchangeData.status == 'rejected' ||
                            exchangeData.status == 'decline'
                        ? 'Rejection reason'
                        : 'Processing Details',
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
                  exchangeData.status == 'rejected' ||
                          exchangeData.status == 'decline'
                      ? Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffFFE6E6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CrashSafeImage(
                                  Assets.images.warning.keyName,
                                  height: 18,
                                  width: 18,
                                  color: const Color(0xffBF0000),
                                ),
                                widthBox8,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Alignment with Current Strategy',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xffBF0000),
                                        ),
                                      ),
                                      Text(
                                        'Thank you for presenting this product. After careful consideration, we\'ve determined that it doesn\'t align with our current strategic goals and upcoming initiatives.',
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xffBF0000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  heightBox10,

                  exchangeData.status == 'rejected' ||
                          exchangeData.status == 'decline'
                      ? CustomElevatedButton(
                          title: 'Need help?',
                          iconData: Assets.images.help.keyName,
                          onPress: () {},
                          iconColor: Colors.white,
                        )
                      : Container(),

                  exchangeData.status == 'rejected' ||
                          exchangeData.status == 'decline'
                      ? heightBox10
                      : Container(),
                  Text(
                    'Exchange Product',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  ProductCart(
                    productName: exchangeData.exchangeWith.first.name,
                    description: exchangeData.exchangeWith.first.descriptions,
                    productImage: exchangeData.exchangeWith.first.images[0].url,
                    productPrice:
                        (exchangeData.exchangeWith.first.price -
                                exchangeData.exchangeWith.first.discount)
                            .toString(),

                    quantity: int.parse( 
                      exchangeData.exchangeWith.first.quantity!,
                    ),
                  ),

                  heightBox10,
                  Text(
                    'My Products',  
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true, // এটা সবচেয়ে গুরুত্বপূর্ণ
                    physics:
                        const NeverScrollableScrollPhysics(), // Parent SingleChildScrollView এর সাথে কনফ্লিক্ট এড়ানোর জন্য
                    itemCount: exchangeData.products.length,

                    itemBuilder: (context, index) {
                      final product = exchangeData.products[index];
                      
                      var price = product.price?.toDouble() ?? 0.0;
                      var discount = product.discount?.toDouble() ?? 0.0;
                      var updatePrice = price - discount;
                     
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ProductCart(
                          productName: product.name,
                          description: product.descriptions,
                          productImage: product.images[0].url,
                          productPrice: updatePrice.toString(),
                          quantity: int.tryParse(product.quantity ?? '1') ?? 1,
                        ),
                      );
                    },
                  ),
                  heightBox10,
                  ExchangeCard(
                    exchangeName: exchangeData.exchangeWith.first.name,
                    requestsForm: exchangeData.user?.name ?? '',
                    requestsTo: exchangeData.requestTo?.name ?? '',
                    approvedDate: dateFormatter.getFullDateFormat(),
                    requestsDate: exchangeData.createdAt.toString(),
                  ),
                  heightBox20,
                  exchangeData.status == 'accepted' ||
                          exchangeData.status == 'approved'
                      ? CustomElevatedButton(
                          title: 'Review Product',
                          onPress: () => Get.to(
                            () => FeedbackScreen(),
                            arguments: {
                              'sellerId': exchangeData.requestTo?.id,
                              'exchangeId': exchangeData.id,
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  final String? status;
  const InfoContainer({super.key, this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: status == 'requested'
            ? const Color(0xffFFFCEB)
            : Color(0xffFFE6E6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            status == 'requested'
                ? CrashSafeImage(
                    Assets.images.warning.keyName,
                    height: 18,
                    width: 18,
                    color: const Color(0xff998523),
                  )
                : status == 'rejected' || status == 'decline'
                ? CrashSafeImage(
                    Assets.images.warning.keyName,
                    height: 18,
                    width: 18,
                    color: const Color(0xffBF0000),
                  )
                : Container(),
            widthBox8,
            Expanded(
              child: status == 'decline' || status == 'rejected'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'We  are really sorry.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xffBF0000),
                          ),
                        ),
                        Text(
                          'Your products is not authentic verified to our customer services. Next time try with your product.',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xffBF0000),
                          ),
                        ),
                      ],
                    )
                  : status == 'requested'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your products are under verification.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff998523),
                          ),
                        ),
                        Text(
                          'You have insufficient token balance please add manually otherwise you won’t be',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff998523),
                          ),
                        ),
                      ],
                    )
                  : Text(''),
            ),
          ],
        ),
      ),
    );
  }
}
