import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';

class DateTimePickerWidget extends StatelessWidget {
  const DateTimePickerWidget({
    super.key,
    this.onChanged,
    required this.name,
    required this.controller,
    this.contentPadding,
    required this.hint,
    required this.validator,
  });
  final EdgeInsetsGeometry? contentPadding;
  final void Function(DateTime?)? onChanged;
  final TextEditingController? controller;
  final String name;
  final String hint;
  final String? Function(DateTime?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      controller: controller,
      validator: validator,
      inputType: InputType.date,
      fieldHintText: hint,
      format: DateFormat('yyyy-M-d'),
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        helperStyle:
            AppTextStyles.regular14.copyWith(color: AppColors.darkgrey),
        hintStyle: AppTextStyles.regular14.copyWith(color: AppColors.darkgrey),
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
