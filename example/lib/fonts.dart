import 'package:flutter/material.dart';
import 'package:web_fonts/fonts/web_fonts_descriptor.dart';
import 'package:web_fonts/fonts/web_fonts_variant.dart';
import 'package:web_fonts/web_fonts.dart';

class NotoSansKR {
  static const _fontFamily = 'NotoSansKR';
  static bool _registered = false;

  static register() {
    if (_registered) {
      return;
    }

    WebFonts.register(_fontFamily, {
      WebFontsVariant(
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
      ): WebFontsFile(
        'http://fonts.gstatic.com/s/notosanskr/v13/Pby7FmXiEBPT4ITbgNA5CgmOelzI7rgQsWYrzw.otf',
      ),
      WebFontsVariant(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ): WebFontsFile(
        'http://fonts.gstatic.com/s/notosanskr/v13/PbykFmXiEBPT4ITbgNA5Cgm20HTs4JMMuA.otf',
      ),
      WebFontsVariant(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ): WebFontsFile(
        'http://fonts.gstatic.com/s/notosanskr/v13/Pby7FmXiEBPT4ITbgNA5CgmOIl3I7rgQsWYrzw.otf',
      ),
      WebFontsVariant(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
      ): WebFontsFile(
        'http://fonts.gstatic.com/s/notosanskr/v13/Pby7FmXiEBPT4ITbgNA5CgmOalvI7rgQsWYrzw.otf',
      ),
      WebFontsVariant(
          fontWeight: FontWeight.w900,
          fontStyle:
              FontStyle.normal): WebFontsFile(
          'http://fonts.gstatic.com/s/notosanskr/v13/Pby7FmXiEBPT4ITbgNA5CgmOUlnI7rgQsWYrzw.otf')
    });

    _registered = true;
  }

  static TextStyle getTextStyle([TextStyle? textStyle]) {
    register();

    return WebFonts.getTextStyle(_fontFamily, textStyle: textStyle);
  }

  static TextTheme getTextTheme([TextTheme? textTheme]) {
    register();

    return WebFonts.getTextTheme(_fontFamily, textTheme);
  }
}

class FiraCode {
  static const _fontFamily = 'FiraCode';
  static bool _registered = false;

  static register() {
    if (_registered) {
      return;
    }

    WebFonts.register(_fontFamily, {
      WebFontsVariant(
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
      ): WebFontsFile(
        'https://raw.githubusercontent.com/tonsky/FiraCode/master/distr/ttf/FiraCode-Light.ttf',
      ),
      WebFontsVariant(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ): WebFontsFile(
        'https://raw.githubusercontent.com/tonsky/FiraCode/master/distr/ttf/FiraCode-Regular.ttf',
      ),
      WebFontsVariant(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ): WebFontsFile(
        'https://raw.githubusercontent.com/tonsky/FiraCode/master/distr/ttf/FiraCode-Medium.ttf',
      ),
      WebFontsVariant(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
      ): WebFontsFile(
        'https://raw.githubusercontent.com/tonsky/FiraCode/master/distr/ttf/FiraCode-Bold.ttf',
      ),
    });

    _registered = true;
  }

  static TextStyle getTextStyle([TextStyle? textStyle]) {
    register();

    return WebFonts.getTextStyle(_fontFamily, textStyle: textStyle);
  }

  static TextTheme getTextTheme([TextTheme? textTheme]) {
    register();

    return WebFonts.getTextTheme(_fontFamily, textTheme);
  }
}

class NotoSansCJKKR {
  static const _fontFamily = 'NotoSansCJKKRRemote';
  static bool _registered = false;

  static get fontFamily => _fontFamily;

  static register() {
    if (_registered) {
      return;
    }

    WebFonts.register(_fontFamily, {
      WebFontsVariant(
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
      ): WebFontsFile(
        'https://raw.githubusercontent.com/supernovel/flutter_web_fonts/master/example/fonts/NotoSansCJKkr-Thin.otf',
      ),
      WebFontsVariant(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ): WebFontsFile(
        'https://raw.githubusercontent.com/supernovel/flutter_web_fonts/master/example/fonts/NotoSansCJKkr-Regular.otf',
      ),
      WebFontsVariant(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ): WebFontsFile(
        'https://raw.githubusercontent.com/supernovel/flutter_web_fonts/master/example/fonts/NotoSansCJKkr-Medium.otf',
      ),
      WebFontsVariant(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
      ): WebFontsFile(
        'https://raw.githubusercontent.com/supernovel/flutter_web_fonts/master/example/fonts/NotoSansCJKkr-Bold.otf',
      ),
      WebFontsVariant(
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.normal,
      ): WebFontsFile(
        'https://raw.githubusercontent.com/supernovel/flutter_web_fonts/master/example/fonts/NotoSansCJKkr-Black.otf',
      ),
    });

    _registered = true;
  }

  static TextStyle getTextStyle([TextStyle? textStyle]) {
    register();

    return WebFonts.getTextStyle(_fontFamily, textStyle: textStyle);
  }

  static TextTheme getTextTheme([TextTheme? textTheme]) {
    register();

    return WebFonts.getTextTheme(_fontFamily, textTheme);
  }
}
