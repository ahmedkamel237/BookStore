import 'package:flutter/material.dart';
import 'package:stor_app/common/padding_values/padding_dimentions.dart';
import 'package:stor_app/common/themes/colors.dart';

class TextStyles {
  TextStyles._();

  static TextStyle regular({
    Color? textColor,
    double? fontSize,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize ?? Dimentions.large,
      color: textColor ?? AppColor.black,
      fontWeight: FontWeight.w400,
      height: height ?? 1,
    );
  }

  static TextStyle medium({
    Color? textColor,
    double? fontSize,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize ?? Dimentions.large,
      color: textColor ?? AppColor.black,
      fontWeight: FontWeight.w500,
      height: height ?? 1,
    );
  }

  static TextStyle semiBold({
    Color? textColor,
    double? fontSize,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize ?? Dimentions.large,
      color: textColor ?? AppColor.black,
      fontWeight: FontWeight.w600,
      height: height ?? 1,
    );
  }

  static TextStyle bold({Color? textColor, double? fontSize, double? height}) {
    return TextStyle(
      fontSize: fontSize ?? Dimentions.large,
      color: textColor ?? AppColor.black,
      fontWeight: FontWeight.w700,
      height: height ?? 1,
    );
  }

  static TextStyle extraBold({
    Color? textColor,
    double? fontSize,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize ?? Dimentions.large,
      color: textColor ?? AppColor.black,
      fontWeight: FontWeight.w800,
      height: height ?? 1,
    );
  }
}
