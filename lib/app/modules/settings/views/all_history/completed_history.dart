// completed_history.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandrofp/app/modules/cart/widget/exchange_card.dart';
import 'package:sandrofp/app/modules/settings/controller/exchange_history_controller.dart';

class CompletedHistory extends GetView<ExchangeHistoryController> {
  const CompletedHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isCompletedLoading.value) {
        return SizedBox(
          height: 550,
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.completedList.isEmpty) {
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
          itemCount: controller.completedList.length,
          itemBuilder: (context, index) {
            final item = controller.completedList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ExchangeCard(
                isShowButton: true,
                exchangeName: item.exchangeWith.first.name ?? 'N/A',
                requestsForm: item.user?.name ?? 'N/A',
                requestsTo: item.requestTo?.name ?? 'N/A',
                requestsDate: item.createdAt.toString(),
                approvedDate: item.createdAt.toString(),
                onTap: () {},
              ),
            );
          },
        ),
      );
    });
  }
}
