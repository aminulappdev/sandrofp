// app/modules/authentication/controller/reset_password_controller.dart
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/custom.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController oldPasswordCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirm = true.obs;
  final RxBool obscureOld = true.obs;

  final NetworkCaller _networkCaller = NetworkCaller();

  @override
  void onClose() {
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() => obscurePassword.toggle();
  void toggleConfirmVisibility() => obscureConfirm.toggle();
  void toggleOldVisibility() => obscureOld.toggle();

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;

    showLoadingOverLay(
      asyncFunction: _performReset,
      msg: 'Changing password...',
    );
  }

  Future<void> _performReset() async {
    try {
      isLoading(true);

      final body = {
        "oldPassword": oldPasswordCtrl.text,
        "confirmPassword": passwordCtrl.text,
        "newPassword": confirmPasswordCtrl.text,
      };

      final response = await _networkCaller.patchRequest(
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
        Urls.changePasswordUrl,

        body: body,
      );

      if (response.isSuccess) {
        showSuccess('Password changed successfully!');
      } else {
        showError(response.errorMessage);
      }
    } catch (e) {
      print('Reset Password Error: $e');
      showError('Something went wrong');
    } finally {
      isLoading(false);
    }
  }
}
