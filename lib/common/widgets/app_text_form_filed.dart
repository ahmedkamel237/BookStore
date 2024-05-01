import 'package:flutter/material.dart';
import 'package:stor_app/common/padding_values/padding_dimentions.dart';
import 'package:stor_app/common/themes/colors.dart';
import 'package:stor_app/common/themes/text_styles.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.onChanged,
    this.decoration,
    this.validator,
    this.controller,
    this.contentPadding,
    this.fontSize,
    this.textColor,
  });

  final void Function(String)? onChanged;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final double? contentPadding;
  final double? fontSize;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: decoration ??
          InputDecoration(
            contentPadding: EdgeInsets.all(contentPadding ?? 12),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),

      style: TextStyles.regular(
        fontSize: fontSize ?? Dimentions.large,
        textColor: textColor ??  AppColor.black,
      ),
      validator: validator,
      controller: controller,
    );
  }
}
