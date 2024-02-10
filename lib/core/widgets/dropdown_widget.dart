import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    this.onChanged,
    this.enable,
    this.borderColor = AppColors.lightgrey,
    required this.items,
    required this.name,
    this.initialValue,
    this.fillColor = Colors.white,
    this.contentPadding,
    this.prefixIcon,
  });
  final EdgeInsetsGeometry? contentPadding;
  final dynamic initialValue;
  final Color fillColor;
  final bool? enable;
  final Color borderColor;
  final Widget? prefixIcon;
  final void Function(dynamic)? onChanged;
  final String name;
  final List<DropdownMenuItem<dynamic>> items;
  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
        enabled: enable ?? true,
        initialValue: initialValue,
        name: name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null) {
            return "validation_drop";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor)),
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          helperStyle: AppTextStyles.regular14.copyWith(color: AppColors.grey),
          hintStyle: AppTextStyles.regular14.copyWith(color: AppColors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.secondary),
          ),
          hintText: name,
          prefixIcon: prefixIcon,
        ),
        onChanged: onChanged,
        items: items);
  }
}
