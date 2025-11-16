import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/profile/model/profile_model.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart'; 

class ProfileController extends GetxController {
  final RxBool obscureText = true.obs;
  final NetworkCaller _networkCaller = NetworkCaller();

  final Rx<ProfileModel?> _profileModel = Rx<ProfileModel?>(null);
  ProfileData? get profileData => _profileModel.value?.data;
  
  final RxBool isLoading = false.obs; 



  Future<void> getMyProfile() async {
    isLoading(true);
    final response = await _networkCaller.getRequest(Urls.profileUrl,accessToken: StorageUtil.getData(StorageUtil.userAccessToken));
    isLoading(false);
    if (response.isSuccess) {
      final data = response.responseData['data'];
      if (data != null) {
        _profileModel.value = ProfileModel.fromJson(response.responseData);

        print('PROFILE DATA: ${_profileModel.value?.data}');
      } else {}
    } else {
      showError(response.errorMessage);
    }
  }
}
