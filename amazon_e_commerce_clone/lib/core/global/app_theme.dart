import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme{

  static final ThemeData light = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.secondaryColor,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );

  static final ThemeData dark = ThemeData(

  );
}