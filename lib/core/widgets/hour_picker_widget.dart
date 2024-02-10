// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';

class HourPickerWidget extends StatelessWidget {
  const HourPickerWidget({
    super.key,
    this.contentPadding,
    this.onChanged,
    required this.name,
    this.hintText,
    required this.controller,
    this.validator,
  });
  final EdgeInsetsGeometry? contentPadding;
  final void Function(DateTime?)? onChanged;
  final String name;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(DateTime?)? validator;
  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      fieldHintText: hintText,
      controller: controller,
      validator: validator,
      inputType: InputType.time,
      onChanged: onChanged,
      decoration: InputDecoration(
        helperStyle:
            AppTextStyles.regular14.copyWith(color: AppColors.darkgrey),
        hintStyle: AppTextStyles.regular14.copyWith(color: AppColors.darkgrey),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.secondary)),
        hintText: name,
      ),
      name: name,
      firstDate: DateTime.now(),
      lastDate: DateTime(2222),
    );
  }
}
