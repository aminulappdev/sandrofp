import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/payment/controller/payment_services.dart';
import 'package:sandrofp/app/modules/settings/controller/content_controller.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
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
  final TextEditingController amountController = TextEditingController();
  final PaymentService paymentService = PaymentService();
  
  late final ContentController contentController;

  double tokenToUSD = 0.0;
  double dollarAmount = 0.0;

  bool _isExchanging = false;

  @override
  void initState() {
    super.initState();
    
    contentController = Get.put(ContentController());
    
    // safe way — কোনো error snackbar আসবে না, arguments ছাড়াই fetch
    contentController.loadContentByKey('perTokenPrice');
    
    amountController.text = "1";
    amountController.addListener(_calculateUSD);
  }

  void _calculateUSD() {
    if (!mounted) return;
    final text = amountController.text.replaceAll(',', '').trim();
    final tokens = double.tryParse(text) ?? 0.0;
    setState(() {
      dollarAmount = tokens * tokenToUSD;
    });
  }

  @override
  void dispose() {
    amountController.removeListener(_calculateUSD);
    amountController.dispose();
    super.dispose();
  }

  double _getSafeTokenPrice() {
    dynamic value = contentController.content.value;

    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is Map<String, dynamic>) {
      final price = value['perTokenPrice'];
      return price is num
          ? price.toDouble()
          : (double.tryParse(price?.toString() ?? '0') ?? 0.0);
    }
    if (value is String) return double.tryParse(value) ?? 0.0;

    return 0.0;
  }

  Future<void> _exchangeNow() async {
    final input = amountController.text.trim();
    final tokens = double.tryParse(input.replaceAll(',', ''));

    if (input.isEmpty || tokens == null || tokens <= 0) {
      showError('Please enter a valid token amount');
      return;
    }
    if (tokenToUSD <= 0) {
      showError('Token price not loaded yet. Please wait.');
      return;
    }

    setState(() {
      _isExchanging = true;
    });

    try {
      await paymentService.payment(context, amountController.text.trim());
    } finally {
      if (mounted) {
        setState(() {
          _isExchanging = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Exchange Process', leading: Container()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            heightBox12,
            Obx(() {
              if (contentController.isLoading.value) {
                return const SizedBox(
                  height: 550,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              tokenToUSD = _getSafeTokenPrice();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _calculateUSD();
              });

              return Padding(
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
                          '1 token equals',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    heightBox8,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '\$${tokenToUSD.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
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
                    heightBox12,
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    heightBox40,

                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 280,
                            child: TextField(
                              controller: amountController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: CrashSafeImage(
                                    Assets.images.banana.keyName,
                                    height: 24,
                                  ),
                                ),
                                labelText: 'Token Amount',
                                hintText: 'Enter tokens',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: AppColors.greenColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          heightBox20,
                          CrashSafeImage(
                            Assets.images.exchange.keyName,
                            height: 50,
                          ),
                          heightBox20,
                          Container(
                            width: 280,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '\$${dollarAmount.toStringAsFixed(2)}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.greenColor,
                                    ),
                                  ),
                                  widthBox8,
                                  Text(
                                    'USD',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    heightBox50,

                    _isExchanging
                        ? const Center(
                            child: CustomElevatedButton(
                              color: Color.fromARGB(255, 103, 161, 128),
                              title: 'Loading...',
                              onPress: null,
                            ),
                          )
                        : CustomElevatedButton(
                            title: 'Exchange Now',
                            onPress: _exchangeNow,
                          ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}