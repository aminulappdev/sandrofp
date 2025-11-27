// completed_history.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/cart/widget/exchange_card.dart';
import 'package:sandrofp/app/modules/exchange/views/exchange_process_screen.dart';
import 'package:sandrofp/app/modules/settings/controller/exchange_history_controller.dart';
import 'package:sandrofp/app/res/common_widgets/date_formatter.dart';

class ApprovedHistory extends GetView<ExchangeHistoryController> {
  const ApprovedHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isApprovedLoading.value) {
        return SizedBox(
          height: 550,
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.approvedList.isEmpty) {
        return SizedBox(
          height: 550,
          child: const Center(
            child: Text(
              "No completed exchanges yet",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        );
      }

      return Expanded(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.approvedList.length,
          itemBuilder: (context, index) {
            final item = controller.approvedList[index];
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
