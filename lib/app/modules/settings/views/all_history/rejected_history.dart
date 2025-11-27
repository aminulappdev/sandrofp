// completed_history.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/cart/widget/exchange_card.dart';
import 'package:sandrofp/app/modules/exchange/views/exchange_process_screen.dart';
import 'package:sandrofp/app/modules/settings/controller/exchange_history_controller.dart';
import 'package:sandrofp/app/res/common_widgets/date_formatter.dart';

class RejectedHistory extends GetView<ExchangeHistoryController> {
  const RejectedHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isRejectedLoading.value) {
        return SizedBox(
          height: 550,
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.rejectedList.isEmpty) {
        return SizedBox(
          height: 550,
          child: const Center(
            child: Text(
              "No rejected exchanges yet",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        );
      }

      return Expanded(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.rejectedList.length,
          itemBuilder: (context, index) {
            final item = controller.rejectedList[index];
            DateFormatter dateFormatter = DateFormatter(item.createdAt!);
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ExchangeCard(
                isShowButton: true,
                exchangeName: item.exchangeWith.first.name ?? 'N/A',
                requestsForm: item.user?.name ?? 'N/A',
                requestsTo: item.requestTo?.name ?? 'N/A',
                requestsDate: dateFormatter.getFullDateFormat(),
                approvedDate: item.createdAt.toString(),
                onTap: () {
                  Get.to(
                    () => ExchangeProcessScreen(),
                    arguments: {'data': item},
                  );
                },
              ),
            );
          },
        ),
      );
    });
  }
}
