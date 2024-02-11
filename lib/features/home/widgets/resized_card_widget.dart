// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';
import 'package:watt_test/features/home/controller/home_controller.dart';

class ResizeCardTrip extends GetWidget<HomeController> {
  const ResizeCardTrip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.toggleCardTrip();
      },
      child: Card(
        color: Colors.white,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.info_outlined, color: AppColors.primaryBlue),
              const SizedBox(width: 10),
              Text("Tab for show Trip Details", style: AppTextStyles.medium14),
              const Spacer(),
              const Icon(
                Icons.photo_size_select_small_outlined,
                color: AppColors.primaryBlue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
