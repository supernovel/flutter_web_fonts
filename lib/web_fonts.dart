import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'fonts/web_fonts_base.dart';
import 'fonts/web_fonts_descriptor.dart';
import 'fonts/web_fonts_variant.dart';

/// Lazy load fonts
class WebFonts {
  static Map<String, Map<WebFontsVariant, WebFontsFile>> _fontsMap = {};

  static void register(
      String fontFamily, Map<WebFontsVariant, WebFontsFile> fonts) {
    _fontsMap[fontFamily] = fonts;
  }

  /// Applies the font family from given [textStyle].
  static getTextStyle(
    String fontFamily, {
    TextStyle? textStyle,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<ui.Shadow>? shadows,
    List<ui.FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    final fonts = _fontsMap[fontFamily];

    if (fonts == null) {
      return;
    }

    return webFontsTextStyle(
      textStyle: textStyle,
      fontFamily: fontFamily,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      fonts: fonts,
    );
  }

  /// Applies the [fontFamily] in the given [textTheme].
  static TextTheme getTextTheme(String fontFamily, [TextTheme? textTheme]) {
    textTheme ??= ThemeData.light().textTheme;

    return TextTheme(
      displayLarge: WebFonts.getTextStyle(
        fontFamily,
        textStyle: textTheme.displayLarge,
      ),
      displayMedium: WebFonts.getTextStyle(
        fontFamily,
        textStyle: textTheme.displayMedium,
      ),
      displaySmall: WebFonts.getTextStyle(
        fontFamily,
        textStyle: textTheme.displaySmall,
      ),
      headlineMedium: WebFonts.getTextStyle(
        fontFamily,
        textStyle: textTheme.headlineMedium,
      ),
      headlineSmall: WebFonts.getTextStyle(
        fontFamily,
        textStyle: textTheme.headlineSmall,
      ),
      titleLarge: WebFonts.getTextStyle(
        fontFamily,
        textStyle: textTheme.titleLarge,
      ),
      titleMedium: WebFonts.getTextStyle(
        fontFamily,
        textStyle: textTheme.titleMedium,
      ),
      titleSmall: WebFonts.getTextStyle(
        fontFamily,
        textStyle: textTheme.titleSmall,
      ),
      bodyLarge: WebFonts.getTextStyle(
        fontFamily,
        textStyle: textTheme.bodyLarge,
      ),
      bodyMedium: WebFonts.getTextStyle(
        fontFamily,
        textStyle: textTheme.bodyMedium,
      ),
      bodySmall: WebFonts.getTextStyle(
        fontFamily,
        textStyle: textTheme.bodySmall,
      ),
      labelLarge: WebFonts.getTextStyle(
        fontFamily,
        textStyle: textTheme.labelLarge,
      ),
      labelSmall: WebFonts.getTextStyle(
        fontFamily,
        textStyle: textTheme.labelSmall,
      ),
    );
  }
}
