import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    this.maxLength,
    this.maxLines,
    this.hint,
    this.onChanged,
    this.borderColor = AppColors.lightgrey,
    this.keyboardType,
    this.inputFormatters,
    this.enable,
    this.suffixIcon,
    this.prefixIcon,
    required this.name,
    this.contentPadding,
    this.onTap,
    this.prefix,
    this.validator,
    this.fillColor = Colors.white,
  });
  final String name;
  final Color fillColor;
  final Color borderColor;
  final String? hint;
  final int? maxLength;
  final bool? enable;
  final int? maxLines;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      enabled: enable ?? true,
      onChanged: onChanged,
      onTap: onTap,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      controller: controller,
      name: name,
      validator: validator,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor)),
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          suffixIcon: suffixIcon,
          prefix: prefix,
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: fillColor,
          hintText: hint,
          helperStyle: AppTextStyles.regular14.copyWith(color: AppColors.grey),
          hintStyle: AppTextStyles.regular14.copyWith(color: AppColors.grey),
          border: InputBorder.none),
    );
  }
}
