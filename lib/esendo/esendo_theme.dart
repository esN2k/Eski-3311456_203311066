// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences _prefs;

abstract class EsenDoTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static EsenDoTheme of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? DarkModeTheme()
          : LightModeTheme();

  Color primaryColor;
  Color secondaryColor;
  Color tertiaryColor;
  Color alternate;
  Color primaryBackground;
  Color secondaryBackground;
  Color primaryText;
  Color secondaryText;

  Color white;
  Color grayBG;
  Color darkBG;
  Color primaryBlack;

  TextStyle get title1 => GoogleFonts.getFont(
        'Lexend Deca',
        color: white,
        fontWeight: FontWeight.bold,
        fontSize: 34,
      );
  TextStyle get title2 => GoogleFonts.getFont(
        'Lexend Deca',
        color: white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      );
  TextStyle get title3 => GoogleFonts.getFont(
        'Lexend Deca',
        color: white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Lexend Deca',
        color: tertiaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Lexend Deca',
        color: white,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Lexend Deca',
        color: white,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Lexend Deca',
        color: tertiaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      );
}

class LightModeTheme extends EsenDoTheme {
  Color primaryColor = const Color(0xFF7962FF);
  Color secondaryColor = const Color(0xFF191919);
  Color tertiaryColor = const Color(0xFFE7E7E7);
  Color alternate = const Color(0x00000000);
  Color primaryBackground = const Color(0x00000000);
  Color secondaryBackground = const Color(0x00000000);
  Color primaryText = const Color(0x00000000);
  Color secondaryText = const Color(0x00000000);

  Color white = const Color(0xFFE7E7E7);
  Color grayBG = const Color(0xFFE7E7E7);
  Color darkBG = const Color(0xFF191919);
  Color primaryBlack = const Color(0xFF191919);
}

class DarkModeTheme extends EsenDoTheme {
  Color primaryColor = const Color(0xFF7962FF);
  Color secondaryColor = const Color(0xFFE7E7E7);
  Color tertiaryColor = const Color(0xFF191919);
  Color alternate = const Color(0x00000000);
  Color primaryBackground = const Color(0x00000000);
  Color secondaryBackground = const Color(0x00000000);
  Color primaryText = const Color(0x00000000);
  Color secondaryText = const Color(0x00000000);

  Color white = const Color(0xFFE7E7E7);
  Color grayBG = const Color(0xFF191919);
  Color darkBG = const Color(0xFFE7E7E7);
  Color primaryBlack = const Color(0xFF191919);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily,
    Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    bool useGoogleFonts = true,
    TextDecoration decoration,
    double lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
