import 'package:flutter/material.dart';
import 'package:playground/app/resources/color_manager.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor, foregroundColor;
  final String title;
  final double width, height;
  final VoidCallback? onPressed;
  final double? borderRadius, fontSize;
  const CustomButton(
      {super.key,
      this.width = 300,
      this.height = 60,
      this.backgroundColor = Colors.white,
      this.foregroundColor = ColorManager.primary,
      required this.title,
      this.onPressed,
      this.fontSize,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10)),
        ),
        onPressed: onPressed,
        child: Text(title,
            style: TextStyle(
              fontSize: fontSize,
              color: foregroundColor,
            )),
      ),
    );
  }
}
