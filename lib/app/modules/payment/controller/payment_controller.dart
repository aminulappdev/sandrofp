import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/payment/model/payment_model.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/network_caller/network_response.dart';
import 'package:sandrofp/app/urls.dart';

class PaymentController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage; 

  String? _accessToken;
  String? get accessToken => _accessToken;

  PaymentModel? paymentModel;
  PaymentModel? get paymentData => paymentModel;

   

  Future<bool> getPayment(String amount) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {"totalToken": double.parse(amount)};

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(
          Urls.paymentsUrl,
          body: requestBody,
          accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        );

    if (response.isSuccess) {
      paymentModel = PaymentModel.fromJson(response.responseData);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
