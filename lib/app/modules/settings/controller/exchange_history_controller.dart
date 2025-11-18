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
  final RxList<AllExchangeItemModel> completedList =
      <AllExchangeItemModel>[].obs;
  final RxList<AllExchangeItemModel> pendingList = <AllExchangeItemModel>[].obs;
  final RxList<AllExchangeItemModel> declinedList =
      <AllExchangeItemModel>[].obs;

  // লোডিং স্টেট প্রতি ট্যাবের জন্য
  final RxBool isCompletedLoading = true.obs;
  final RxBool isPendingLoading = true.obs;
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
    if (index == 1) status = 'pending';
    if (index == 2) status = 'declined';

    // যে ট্যাবে গেলো, সেটার ডাটা লোড করবে (যদি আগে লোড না করা থাকে)
    fetchExchanges(status);
  }

  // API কল
  Future<void> fetchExchanges(String status) async {
    // লোডিং স্টেট সেট করা
    if (status == 'approved') isCompletedLoading(true);
    if (status == 'requested') isPendingLoading(true);
    if (status == 'declined') isDeclinedLoading(true);

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
        if (status == 'approved') completedList.assignAll(data);
        if (status == 'requested') pendingList.assignAll(data);
        if (status == 'declined') declinedList.assignAll(data);
      } else {
        showError(response.errorMessage);
        _clearList(status);
      }
    } catch (e) {
      showError('Network error: $e');
      _clearList(status);
    } finally {
      // লোডিং বন্ধ
      if (status == 'approved') isCompletedLoading(false);
      if (status == 'requested') isPendingLoading(false);
      if (status == 'declined') isDeclinedLoading(false);
    }
  }

  void _clearList(String status) {
    if (status == 'approved') completedList.clear();
    if (status == 'requested') pendingList.clear();
    if (status == 'declined') declinedList.clear();
  }

  // রিফ্রেশ করার জন্য
  Future<void> refreshCurrentTab() async {
    String status = '';
    switch (selectedIndex.value) {
      case 0:
        status = 'approved';
        break;
      case 1:
        status = 'requested';
        break;
      case 2:
        status = 'declined';
        break;
    }
    await fetchExchanges(status);
  }
}
