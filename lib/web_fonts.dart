import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'fonts/web_fonts_base.dart';
import 'fonts/web_fonts_descriptor.dart';
import 'fonts/web_fonts_variant.dart';

/// Lazy load fonts
class WebFonts {
  static Map<String, Map<WebFontsVariant, WebFontsFile>> _fontsMap =
      {};

  static void register(
      String fontFamily, Map<WebFontsVariant, WebFontsFile> fonts) {
    _fontsMap[fontFamily] = fonts;
  }

  /// Applies the font family from given [textStyle].
  static getTextStyle(
    String fontFamily, {
    TextStyle textStyle,
    Color color,
    Color backgroundColor,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextBaseline textBaseline,
    double height,
    Locale locale,
    Paint foreground,
    Paint background,
    List<ui.Shadow> shadows,
    List<ui.FontFeature> fontFeatures,
    TextDecoration decoration,
    Color decorationColor,
    TextDecorationStyle decorationStyle,
    double decorationThickness,
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
  static TextTheme getTextTheme(String fontFamily, [TextTheme textTheme]) {
    textTheme ??= ThemeData.light().textTheme;

    return TextTheme(
      headline1:
          WebFonts.getTextStyle(fontFamily, textStyle: textTheme?.headline1),
      headline2:
          WebFonts.getTextStyle(fontFamily, textStyle: textTheme?.headline2),
      headline3:
          WebFonts.getTextStyle(fontFamily, textStyle: textTheme?.headline3),
      headline4:
          WebFonts.getTextStyle(fontFamily, textStyle: textTheme?.headline4),
      headline5:
          WebFonts.getTextStyle(fontFamily, textStyle: textTheme?.headline5),
      headline6:
          WebFonts.getTextStyle(fontFamily, textStyle: textTheme?.headline6),
      subtitle1:
          WebFonts.getTextStyle(fontFamily, textStyle: textTheme?.subtitle1),
      subtitle2:
          WebFonts.getTextStyle(fontFamily, textStyle: textTheme?.subtitle2),
      bodyText1:
          WebFonts.getTextStyle(fontFamily, textStyle: textTheme?.bodyText1),
      bodyText2:
          WebFonts.getTextStyle(fontFamily, textStyle: textTheme?.bodyText2),
      caption:
          WebFonts.getTextStyle(fontFamily, textStyle: textTheme?.caption),
      button:
          WebFonts.getTextStyle(fontFamily, textStyle: textTheme?.button),
      overline:
          WebFonts.getTextStyle(fontFamily, textStyle: textTheme?.overline),
    );
  }
}
