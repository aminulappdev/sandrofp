

import 'package:flutter/material.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ImageContainer extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final String imagePath;
  const ImageContainer({
    super.key,
    required this.height,
    required this.width,
    required this.imagePath,
    required this.radius,
  });

  @override 
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),

        image: DecorationImage(
          image: AssetImage(Assets.images.onboarding01.keyName),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
