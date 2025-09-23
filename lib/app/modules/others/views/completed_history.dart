import 'package:flutter/material.dart';
import 'package:sandrofp/app/modules/cart/widget/exchange_card.dart';

class CompletedHistory extends StatelessWidget {
  const CompletedHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ExchangeCard(isShowButton: true,);
        },
      ),
    );
  }
}
