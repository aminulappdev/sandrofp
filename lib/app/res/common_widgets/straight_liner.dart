import 'package:flutter/material.dart';

class StraightLiner extends StatelessWidget {
  const StraightLiner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      decoration: BoxDecoration(color: Color(0xffCCCCCC)),
    );
  }
}