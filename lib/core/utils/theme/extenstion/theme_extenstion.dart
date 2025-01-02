import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/utils/theme/extenstion/custom_colors_extenstion.dart';
import '../cubit/theme_cubit.dart';
import '../utils/theme_mapper.dart';

extension ContextExt on BuildContext {
  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }

  AppTheme get currentThemeState => read<ThemeCubit>().state;

  CustomColors get customColors {
    return Theme.of(this).customColors;
  }
}