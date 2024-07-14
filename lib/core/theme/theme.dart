import 'package:flutter/material.dart';
import 'package:junkpoint/core/theme/app_palette.dart';

class AppTheme {
  static _border([Color color = AppPalette.greyColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(100),
      );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPalette.whiteColor,
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(15),
        enabledBorder: _border(),
        focusedBorder: _border(AppPalette.mainColor),
        errorBorder: _border(AppPalette.errorColor),
        focusedErrorBorder: _border(AppPalette.errorColor)),
  );
}
