import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sandrofp/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlViewScreen extends StatefulWidget {
  final String htmlContent;

  const HtmlViewScreen({Key? key, required this.htmlContent}) : super(key: key);

  @override
  _HtmlViewScreenState createState() => _HtmlViewScreenState();
}

class _HtmlViewScreenState extends State<HtmlViewScreen> {
  late WebViewController _controller;
 
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('pay.stripe.com')) {
              print('Navigating to: ${request.url}');
              // Optionally, open in external browser (requires url_launcher)
              return NavigationDecision.prevent;
            } else if (request.url.endsWith('/')) {
              Get.to(DashboardScreen()); // Navigate to home route
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString(widget.htmlContent);

    // Navigate to home page after 3 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Get.offAll(()=> DashboardScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Confirmation'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
