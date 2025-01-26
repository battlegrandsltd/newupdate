import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/resources/color_manager.dart';
import 'package:shimmer/shimmer.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    required this.heightFactor,
    required this.widthFactor,
  });
  final double heightFactor;
  final double widthFactor;
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          ColorManager.lightGrey,
          ColorManager.white,
          ColorManager.lightGrey,
        ],
        begin: Alignment(-1, -1),
        end: Alignment(1, 1),
        stops: [0, 0.5, 1],
      ),
      direction: ShimmerDirection.ltr,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorManager.black,
        ),
        height: Get.height * heightFactor,
        width: Get.width * widthFactor,
      ),
    );
  }
}
