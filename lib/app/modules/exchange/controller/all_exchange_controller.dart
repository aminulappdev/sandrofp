// lib/app/modules/product/controller/all_product_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/exchange/model/all_exchange_model.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class AllExchangeController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  final Rx<AllExchangeModel?> _exchangeModel = Rx<AllExchangeModel?>(null);
  List<AllExchangeItemModel> get exchangeData =>
      _exchangeModel.value?.data?.data ?? [];

  // লোডিং স্টেট
  final RxBool isLoading = true.obs;
  late String status;

  @override
  void onInit() {
    // final args = Get.arguments;
    // status = args['status'] ?? '';
    super.onInit();
  }

  // API কল
  Future<void> getAllExchange(String? status) async {
    isLoading(true);
    try {
      final response = await _networkCaller.getRequest(
        queryParams: {'status': status},
        Urls.productUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
      );

      if (response.isSuccess && response.responseData != null) {
        _exchangeModel.value = AllExchangeModel.fromJson(response.responseData);
      } else {
         // showError(response.errorMessage);
        _exchangeModel.value = null;
      }
    } catch (e) {
      showError('Network error: $e');
      _exchangeModel.value = null;
    } finally {
      isLoading(false);
    }
  }
}
