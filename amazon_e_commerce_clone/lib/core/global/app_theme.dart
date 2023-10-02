import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme{

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.secondaryColor,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.black,),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll<Color>(
          AppColors.secondaryColor
        )
      )
    ),

  );

  static final ThemeData dark = ThemeData(

  );
}