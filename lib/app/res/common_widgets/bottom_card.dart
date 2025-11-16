import 'package:flutter/material.dart';

class BottomCard extends StatelessWidget {
  final Widget child;
  const BottomCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Color(0xffFBFBFD),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Container(
        // height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}
