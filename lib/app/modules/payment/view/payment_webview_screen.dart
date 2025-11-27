
import 'package:flutter/material.dart';
import 'package:sandrofp/app/modules/payment/controller/payment_url_controller.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PaymentView extends StatefulWidget {
  final Map<String, dynamic> paymentData;

  static const String routeName = '/payment-webview-screen';

  const PaymentView({
    super.key,
    required this.paymentData,
  }); 

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late WebViewController _controller;
  
  final PaymentURLController paymentURLController = PaymentURLController();

  @override
   void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.primaryBackgroundColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('Page start loading: $url');
          },
          onPageFinished: (String url) async {
            debugPrint('Page finished loading: $url');
            if (url.contains("confirm-payment")) {
              debugPrint('Confirmed payment hoye geche............................');
              final bool isSuccess = await paymentURLController.paymentUrl(url);
              if (isSuccess) {
                //Get.to(MainButtonNavbarScreen());
                // await confirmPayment('${widget.paymentData['reference']}');
                // Navigator.pushNamed(context, '/payment-success-screen'); // Adjust route name if needed
              }
              debugPrint('::::::::::::: if condition ::::::::::::::::');
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentData['link'] ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        title: Text('Payment',),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }

}