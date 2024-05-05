part of '../../material.dart';

class TextStyles {
  TextStyles._();

  static TextStyle regular({
    Color? color,
    double? fontSize,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize ?? Dimensions.large,
      color: color ?? AppColors.black,
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
      fontSize: fontSize ?? Dimensions.large,
      color: textColor ?? AppColors.black,
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
      fontSize: fontSize ?? Dimensions.large,
      color: textColor ?? AppColors.black,
      fontWeight: FontWeight.w600,
      height: height ?? 1,
    );
  }

  static TextStyle bold({Color? textColor, double? fontSize, double? height}) {
    return TextStyle(
      fontSize: fontSize ?? Dimensions.large,
      color: textColor ?? AppColors.black,
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
      fontSize: fontSize ?? Dimensions.large,
      color: textColor ?? AppColors.black,
      fontWeight: FontWeight.w800,
      height: height ?? 1,
    );
  }
}
