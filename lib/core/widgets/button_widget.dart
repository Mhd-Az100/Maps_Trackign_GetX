// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';

class ButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Color color;
  final String? title;
  final double width;
  final double height;
  final double radius;
  final TextStyle? style;
  final Widget? child;
  const ButtonWidget({
    super.key,
    this.color = AppColors.secondary,
    required this.onPressed,
    this.title,
    this.width = double.infinity,
    this.height = 45,
    this.radius = 12,
    this.child,
    this.style,
  });
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          maximumSize: MaterialStateProperty.all(Size(width, height)),
          minimumSize: MaterialStateProperty.all(Size(width, height)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius.r),
          ))),
      child: child ??
          Text(
            title ?? "Button",
            style: style ?? AppTextStyles.bold18.copyWith(color: Colors.white),
          ),
    );
  }
}
