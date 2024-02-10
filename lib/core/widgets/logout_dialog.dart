import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';

logoutDialog(BuildContext context, void Function()? onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          "msg_logout",
          style: AppTextStyles.regular18.copyWith(color: Colors.grey[850]),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "cancel",
              style: AppTextStyles.bold16,
            ),
          ),
          TextButton(
            onPressed: onConfirm,
            child: Text(
              "confirm",
              style: AppTextStyles.bold16.copyWith(color: AppColors.secondary),
            ),
          ),
        ],
      );
    },
  );
}
