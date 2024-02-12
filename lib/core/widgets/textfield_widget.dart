// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    Key? key,
    required this.name,
    this.fillColor = Colors.white,
    this.borderColor = AppColors.lightgrey,
    this.hint,
    this.maxLength,
    this.enable,
    this.isPassword = false,
    this.visible = false,
    this.maxLines,
    this.prefix,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
    required this.controller,
    this.validator,
    this.contentPadding,
    this.onChanged,
    this.onTap,
  }) : super(key: key);
  final String name;
  final Color fillColor;
  final Color borderColor;
  final String? hint;
  final int? maxLength;
  final bool? enable;
  final bool isPassword;
  final bool visible;
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
  //
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      focusNode: _focusNode,
      obscureText: visible,
      enableSuggestions: !isPassword,
      autocorrect: !isPassword,
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
      onEditingComplete: () {
        // This callback is triggered when the user presses "OK" on the keyboard
        _focusNode.unfocus(); // Close the keyboard
      },
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
