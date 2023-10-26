import 'package:dogs_app/ui/common/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeClass {
  Color primaryColor = const Color(0xFF0366C4);
  Color secondaryColor = const Color(0xFF96CB39);
  Color kcDarkGreyColor = const Color(0xFF1A1B1E);
  Color kcLightGrey = const Color(0xFFA4A9B8);
  Color kcGrey3 = const Color(0xFF94A3B8);
  Color kcLightBlue = const Color(0xFFB3A7FF);
  Color kcDeepGrey = const Color(0XFFEEEDFB);
  Color kcAppBackgroundColor = const Color(0xFFF3F6FB);
  Color kcLDeepGreen = const Color(0xFF09663E);
  Color kcTransparent = Colors.transparent;
  Color kcDeepBlue = const Color(0xFF1492E6);
  Color kcPaymentMethodColor = const Color(0XFF8540FF);
  Color kcCategoryColor = const Color(0XFF0561F0);

  /// White
  Color kcWhite200 = const Color(0xFFE2E3E5);

  /// App loader color
  Color kcLoader = const Color(0xFFD9D9D9);
// App Border color
  Color kcInputBorderColor = const Color(0x555B6726);

  /// Disabled button color
  Color kcDisabledButtonColor = const Color(0xffF0F3F6);

  static ThemeData lightTheme = ThemeData(
      splashColor: _themeClass.kcTransparent,
      highlightColor: _themeClass.kcTransparent,
      hoverColor: _themeClass.kcTransparent,
      fontFamily: 'Montserrat',
      scaffoldBackgroundColor: kcDarkBlueBlack,
      colorScheme: const ColorScheme.light().copyWith(
        onSurface: _themeClass.kcDarkGreyColor,
        onSurfaceVariant: _themeClass.kcGrey3,
        tertiaryContainer: _themeClass.kcLightGrey,
        onPrimaryContainer: _themeClass.kcLightBlue,
        onBackground: _themeClass.kcAppBackgroundColor,
        onInverseSurface: _themeClass.kcLDeepGreen,
        inverseSurface: _themeClass.kcDeepGrey,
        onSecondaryContainer: _themeClass.kcPaymentMethodColor,
        onTertiaryContainer: _themeClass.kcCategoryColor,

        shadow: _themeClass.kcInputBorderColor,
        scrim: _themeClass.kcDisabledButtonColor,
        background: _themeClass.kcTransparent,
        outlineVariant: Colors.white,

        tertiary: kcLightBlueBlack,
        inversePrimary: _themeClass.kcLightBlue,

        //kcPrimaryColor
        primary: _themeClass.primaryColor,

        //kcSecondary
        secondary: _themeClass.secondaryColor,

        //kcRed
        error: const Color(0xFFF55E5C),
        //kcblack
        onPrimary: Colors.black,
        //kcGrey
        primaryContainer: const Color(0xFF707070),
        //kcDarkGrey
        secondaryContainer: const Color(0xFF0F1C35),

        outline: const Color(0xFF27555B),
        //kcDark700
        surface: const Color(0xFF555B67),
      ));

  static ThemeData darkTheme = ThemeData(
    splashColor: _themeClass.kcTransparent,
    highlightColor: _themeClass.kcTransparent,
    hoverColor: _themeClass.kcTransparent,
    fontFamily: 'Montserrat',
    scaffoldBackgroundColor: const Color(0xFF343434),
    colorScheme: const ColorScheme.dark().copyWith(
      outlineVariant: Colors.white,
      onSurface: _themeClass.kcDarkGreyColor,
      onSurfaceVariant: _themeClass.kcGrey3,
      tertiaryContainer: _themeClass.kcLightGrey,
      onPrimaryContainer: _themeClass.kcLightBlue,
      onBackground: _themeClass.kcAppBackgroundColor,
      onInverseSurface: _themeClass.kcLDeepGreen,
      inverseSurface: _themeClass.kcDeepGrey,
      onSecondaryContainer: _themeClass.kcWhite200,
      onTertiaryContainer: _themeClass.kcWhite200,

      shadow: _themeClass.kcInputBorderColor,
      scrim: _themeClass.kcDisabledButtonColor,
      primary: _themeClass.primaryColor,
      secondary: _themeClass.secondaryColor,
      background: _themeClass.kcTransparent,
      // darkTheme background
      tertiary: kcLightBlueBlack,
      inversePrimary: _themeClass.kcLightBlue,

      error: const Color(0xFFF55E5C),
      onPrimary: Colors.white,
      //kcGrey
      primaryContainer: const Color(0xFFE2E3E5),
      //kcDarkGrey
      secondaryContainer: Colors.white,
      //kcDark700
      surface: Colors.white,

      //kcBorder
      outline: const Color(0xFF666666),
    ),
  );
}

ThemeClass _themeClass = ThemeClass();
