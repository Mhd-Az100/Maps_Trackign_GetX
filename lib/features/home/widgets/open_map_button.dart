import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';

class OpenMapButton extends StatelessWidget {
  const OpenMapButton({
    super.key,
    required this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Text(
            "Select from map",
            style: AppTextStyles.medium16
                .copyWith(decoration: TextDecoration.underline),
          ),
          SizedBox(width: 10.w),
          const Icon(Icons.location_on_outlined, color: AppColors.primaryBlue)
        ],
      ),
    );
  }
}
