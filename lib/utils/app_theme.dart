import 'package:flutter/material.dart';
import 'package:hope_pursuit/utils/app_colors.dart';

class AppTheme {
  static ColorScheme light = const ColorScheme.light(
    primary: AppColors.primaryLight,
    secondary: AppColors.secondary,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    background: AppColors.whiteLight,
  );
}
