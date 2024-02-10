import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:watt_test/core/constants/colors.dart';

import 'styles.dart';

myToast(m) {
  BotToast.showText(
    text: '$m',
    contentColor: AppColors.primaryBlue,
    align: Alignment.center,
    textStyle: AppTextStyles.medium16.copyWith(color: Colors.white),
  );
}
