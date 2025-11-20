// exchange_history_controller.dart
import 'package:get/get.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/exchange/model/all_exchange_model.dart';
import 'package:sandrofp/app/res/common_widgets/custom_snackbar.dart';
import 'package:sandrofp/app/services/network_caller/network_caller.dart';
import 'package:sandrofp/app/urls.dart';

class ExchangeHistoryController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  // আলাদা আলাদা লিস্ট
  final RxList<AllExchangeItemModel> approvedList =
      <AllExchangeItemModel>[].obs;
  final RxList<AllExchangeItemModel> acceptedList =
      <AllExchangeItemModel>[].obs;
  final RxList<AllExchangeItemModel> requestedList =
      <AllExchangeItemModel>[].obs;
  final RxList<AllExchangeItemModel> rejectedList =
      <AllExchangeItemModel>[].obs;
  final RxList<AllExchangeItemModel> declinedList =
      <AllExchangeItemModel>[].obs;

  // লোডিং স্টেট প্রতি ট্যাবের জন্য
  final RxBool isApprovedLoading = true.obs;
  final RxBool isAcceptedLoading = true.obs;
  final RxBool isRequestedLoading = true.obs;
  final RxBool isRejectedLoading = true.obs;
  final RxBool isDeclinedLoading = true.obs;

  final RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // প্রথমে Completed লোড করবে (ডিফল্ট ট্যাব)
    fetchExchanges('approved');
  }

  // ট্যাব চেঞ্জ হলে
  void changeTab(int index) {
    if (selectedIndex.value == index)
      return; // একই ট্যাবে ক্লিক করলে কিছু করবে না

    selectedIndex.value = index;

    String status = '';
    if (index == 0) status = 'approved';
    if (index == 1) status = 'accepted';
    if (index == 2) status = 'requested';
    if (index == 3) status = 'rejected';
    if (index == 4) status = 'decline';

    // যে ট্যাবে গেলো, সেটার ডাটা লোড করবে (যদি আগে লোড না করা থাকে)
    fetchExchanges(status);
  }

  // API কল
  Future<void> fetchExchanges(String status) async {
    // লোডিং স্টেট সেট করা
    if (status == 'approved') isApprovedLoading(true);
    if (status == 'accepted') isAcceptedLoading(true);
    if (status == 'requested') isRequestedLoading(true);
    if (status == 'rejected') isRejectedLoading(true);
    if (status == 'decline') isDeclinedLoading(true);

    try {
      final response = await _networkCaller.getRequest(
        queryParams: {'status': status},
        Urls.myExchangeUrl,
        accessToken: StorageUtil.getData(StorageUtil.userAccessToken),
      );

      if (response.isSuccess && response.responseData != null) {
        final model = AllExchangeModel.fromJson(response.responseData);
        final List<AllExchangeItemModel> data = model.data?.data ?? [];

        // সঠিক লিস্টে ডাটা বসাও
        if (status == 'approved') approvedList.assignAll(data);
        if (status == 'accepted') acceptedList.assignAll(data);
        if (status == 'requested') requestedList.assignAll(data);
        if (status == 'rejected') rejectedList.assignAll(data);
        if (status == 'decline') declinedList.assignAll(data);
      } else {
        showError(response.errorMessage);
        _clearList(status);
      }
    } catch (e) {
      showError('Network error: $e');
      _clearList(status);
    } finally {
      // লোডিং বন্ধ
      if (status == 'approved') isApprovedLoading(false);
      if (status == 'accepted') isAcceptedLoading(false);
      if (status == 'requested') isRequestedLoading(false);
      if (status == 'rejected') isRejectedLoading(false);
      if (status == 'decline') isDeclinedLoading(false);
    }
  }

  void _clearList(String status) {
    if (status == 'approved') approvedList.clear();
    if (status == 'accepted') acceptedList.clear();
    if (status == 'requested') requestedList.clear();
    if (status == 'rejected') rejectedList.clear();
    if (status == 'decline') declinedList.clear();
  }

  // রিফ্রেশ করার জন্য
  Future<void> refreshCurrentTab() async {
    String status = '';
    switch (selectedIndex.value) {
      case 0:
        status = 'approved';
        break;
      case 1:
        status = 'accepted';
        break;
      case 2:
        status = 'requested';
      case 3:
        status = 'rejected';
      case 4:
        status = 'decline';

        break;
    }
    await fetchExchanges(status);
  }
}
