// controllers/notification_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/home/model/notification_model.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class ProductInterestController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  final Rx<NotificationsModel?> _notificationModel = Rx<NotificationsModel?>(
    null,
  );

  // লোডিং স্টেট
  final RxBool isLoading = true.obs;

  Future<void> updateInterest(bool? isInterest, String id) async {
    isLoading(true);
    var url = isInterest == true
        ? Urls.intertestUrlById(id)
        : Urls.dontInterestUrlById(id);
    try {
      final response = await _networkCaller.patchRequest(
        url,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
      );

      if (response.isSuccess && response.responseData != null) {
        _notificationModel.value = NotificationsModel.fromJson(
          response.responseData,
        );
      } else {
        // showError(response.errorMessage);
        _notificationModel.value = null;
      }
    } catch (e) {
      showError('Network error: $e');
      _notificationModel.value = null;
    } finally {
      isLoading(false);
    }
  }
}
