import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/exchange/model/exchange_details_model.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class ExchangeByIdController extends GetxController {
  final RxBool obscureText = true.obs;
  final NetworkCaller _networkCaller = NetworkCaller();

  final Rx<ExchangeDetailsModel?> _exchangeDetailsModel =
      Rx<ExchangeDetailsModel?>(null);
  ExchangeDetailsData? get exchangeDetailsData =>
      _exchangeDetailsModel.value?.data;

  final RxBool isLoading = false.obs;

  Future<void> exchangeById(String id) async {
    isLoading(true);
    final response = await _networkCaller.getRequest(
      Urls.exchangeById(id),
      accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
    );
    isLoading(false);
    if (response.isSuccess) {
      final data = response.responseData['data'];
      if (data != null) {
        _exchangeDetailsModel.value = ExchangeDetailsModel.fromJson(
          response.responseData,
        );
      } else {}
    } else {
      // showError(response.errorMessage);
    }
  }
}
