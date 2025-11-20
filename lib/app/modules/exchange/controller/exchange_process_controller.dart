// app/modules/cart/controllers/exchange_process_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/cart/views/my_product_card_page.dart';
import 'package:sandrofp/app/modules/exchange/model/all_exchange_model.dart';

class ExchangeProcessController extends GetxController {
  // যদি কোন ডাটা/স্টেট ম্যানেজ করতে চাও তাহলে এখানে Rx ভ্যারিয়েবল রাখবে
  // উদাহরণ:
  // var isLoading = false.obs;
  // var tokenBalance = 0.obs;

  late AllExchangeItemModel exchangeItemModel;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    exchangeItemModel = args['data'] ?? '';
  }

  void goToMyProductCard() {
    Get.to(() => const MyProductCardScreen());
  }
}
