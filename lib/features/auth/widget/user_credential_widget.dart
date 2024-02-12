import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';
import 'package:watt_test/core/widgets/button_widget.dart';

class UserCredentialInfo extends StatelessWidget {
  const UserCredentialInfo({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.red, size: 20.sp),
            Text(
              "Attintion: Username and Password bellow:",
              style: AppTextStyles.regular14.copyWith(color: AppColors.red),
            ).paddingAll(10.w),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username: kminchelle",
                  style: AppTextStyles.regular14
                      .copyWith(color: AppColors.darkgrey),
                ).paddingSymmetric(horizontal: 10.w),
                SizedBox(height: 5.h),
                Text(
                  "Password: 0lelplR",
                  style: AppTextStyles.regular14
                      .copyWith(color: AppColors.darkgrey),
                ).paddingSymmetric(horizontal: 10.w),
              ],
            ),
            const Spacer(),
            ButtonWidget(
                width: 120.w,
                color: AppColors.lightgrey,
                onPressed: () {
                  usernameController.text = "kminchelle";
                  passwordController.text = "0lelplR";
                },
                child: Row(children: [
                  Text(
                    "Insert",
                    style: AppTextStyles.regular14
                        .copyWith(color: AppColors.primaryBlue),
                  ),
                  SizedBox(width: 5.w),
                  const Icon(Icons.copy_all_outlined,
                      color: AppColors.primaryBlue),
                ]))
          ],
        ),
      ],
    );
  }
}
