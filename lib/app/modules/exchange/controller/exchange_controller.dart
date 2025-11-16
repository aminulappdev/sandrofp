// app/modules/exchange/controller/exchange_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class Product {
  final String id;
  final String image;
  final String title;
  final String price;
  final String? description;

  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    this.description,
  });
}

class ExchangeController extends GetxController {
  final RxBool isLoading = false.obs;
  final NetworkCaller _networkCaller = NetworkCaller();

  // Received Data
  late Product exchangeProduct;
  final RxList<Product> selectedProducts = <Product>[].obs;
  final RxDouble selectedTotal = 0.0.obs;
  final RxDouble remainingToken = 0.0.obs;

  // Cycling indices
  int _exchangeIndex = 0;
  int _yourIndex = 0;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null) {
      exchangeProduct = Product(id: '0', image: '', title: 'Unknown', price: '0');
      return;
    }

    final ex = args['exchangeProduct'] as Map<String, dynamic>;
    exchangeProduct = Product(
      id: ex['id'].toString(),
      image: ex['image'] ?? '',
      title: ex['title'] ?? 'Unknown',
      price: ex['price']?.toString() ?? '0',
      description: ex['description'],
    );

    final List<dynamic> list = args['selectedProducts'] ?? [];
    selectedProducts.assignAll(list.map((e) => Product(
          id: e['id'].toString(),
          image: e['image'] ?? '',
          title: e['title'] ?? '',
          price: e['price']?.toString() ?? '0',
          description: e['description'],
        )));

    selectedTotal.value = (args['selectedTotal'] as num).toDouble();
    remainingToken.value = (args['remainingToken'] as num).toDouble();

    _exchangeIndex = 0;
    _yourIndex = 0;
  }

  // Change Exchange Product
  void changeExchangeProduct() {
    if (selectedProducts.isEmpty) return;
    _exchangeIndex = (_exchangeIndex + 1) % selectedProducts.length;
    exchangeProduct = selectedProducts[_exchangeIndex];
    update();
  }

  // Change Your Product
  Product get currentYourProduct => selectedProducts.isNotEmpty ? selectedProducts[_yourIndex] : exchangeProduct;

  void changeYourProduct() {
    if (selectedProducts.isEmpty) return;
    _yourIndex = (_yourIndex + 1) % selectedProducts.length;
    update();
  }

  // Dynamic Exchange API Call
  Future<void> exchangeFunction() async {
    if (selectedProducts.isEmpty) {
      showError('No product selected!');
      return;
    }

    if (exchangeProduct.id == '0') {
      showError('Invalid exchange product!');
      return;
    }

    try {
      isLoading(true);

      final body = {
        "requestTo": StorageUtil.getData(StorageUtil.userId),
        "products": selectedProducts.map((p) => p.id).toList(), 
        "exchangeWith": [exchangeProduct.id],
        "extraToken": remainingToken.value, 
        "totalToken": selectedTotal.value, 
      };

      print('Exchange Request Body: $body');

      final response = await _networkCaller.postRequest(
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        Urls.exchangeUrl,
        body: body,
      );

      if (response.isSuccess) {
        showSuccess('Exchange request sent successfully!');
        

      } else {
        showError(response.errorMessage);
      }
    } catch (e) {
      print('Exchange Error: $e');
      showError('Something went wrong. Try again.');
    } finally {
      isLoading(false);
    }
  }
}