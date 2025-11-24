import 'dart:io';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/authentication/views/sign_in_screen.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/services/network_caller/network_response.dart';
import 'package:sandrofp/app/urls.dart';

class ImageDecodeController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  final RxString _url = ''.obs;
  String get imageUrl => _url.value;
  set imageUrl(String value) => _url.value = value;

  Future<bool> imageDecode({File? image}) async {
    _inProgress.value = true;

    try {
      final NetworkResponse response = await Get.find<NetworkCaller>()
          .postRequest(
            image: image,
            keyNameImage: 'file',
            Urls.imageDecodeUrl,
            accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
          );

      if (response.isSuccess && response.responseData != null) {
        _errorMessage.value = '';
        _url.value = response.responseData['data'];
        _inProgress.value = false; // ✅ LOADER STOP (SUCCESS)
        return true;
      } else {
        _errorMessage.value = response.errorMessage;
        _errorMessage.value.contains('expired') ? Get.to(SignInScreen()) : null;
        _inProgress.value = false; // ✅ LOADER STOP (ERROR)
        return false;
      }
    } catch (e) {
      _errorMessage.value = 'Failed to decode image: ${e.toString()}';
      print('Error decoding image: $e');
      _inProgress.value = false; // ✅ LOADER STOP (EXCEPTION)
      return false;
    }
  }
}
