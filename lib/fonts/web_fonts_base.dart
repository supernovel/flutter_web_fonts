import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'file_io.dart' // Stubbed implementation by default.
    // Concrete implementation if File IO is available.
    if (dart.library.io) 'file_io_desktop_and_mobile.dart' as file_io;
import 'web_fonts_descriptor.dart';
import 'web_fonts_family_with_variant.dart';
import 'web_fonts_variant.dart';

// Keep track of the fonts that are loaded or currently loading in FontLoader
// for the life of the app instance. Once a font is attempted to load, it does
// not need to be attempted to load again, unless the attempted load resulted
// in an error.
final Set<String> _loadedFonts = {};

@visibleForTesting
http.Client httpClient = http.Client();

@visibleForTesting
void clearCache() => _loadedFonts.clear();

/// Creates a [TextStyle] that either uses the [fontFamily] for the requested
///
/// This function has a side effect of loading the font into the [FontLoader],
/// either by network or from the device file system.
TextStyle webFontsTextStyle({
  required String fontFamily,
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
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  required Map<WebFontsVariant, WebFontsFile> fonts,
}) {
  textStyle ??= TextStyle();
  textStyle = textStyle.copyWith(
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
  );

  loadFontsIfNecessary(fontFamily, fonts);

  return textStyle.copyWith(fontFamily: fontFamily);
}

/// Loads a font into the [FontLoader]
///
/// If a font with the [fontName] has already been loaded into memory, then
/// this method does nothing as there is no need to load it a second time.
///
/// Otherwise, this method will first check to see if the font is available
/// as an asset, then on the device file system. If it isn't, it is fetched via
/// the [fontUrl] and stored on device. In all cases, the font is loaded into
/// the [FontLoader].
Future<void> loadFontsIfNecessary(
    String fontFamily, Map<WebFontsVariant, WebFontsFile> fonts) async {
  // If this font has already already loaded or is loading, then there is no
  // need to attempt to load it again, unless the attempted load results in an
  // error.
  if (_loadedFonts.contains(fontFamily)) {
    return;
  } else {
    _loadedFonts.add(fontFamily);
  }

  final fontLoader = FontLoader(fontFamily);

  await Future.wait(fonts.keys.map((fontVariant) {
    final fontFile = fonts[fontVariant];

    if (fontFile == null) {
      return Future.value();
    }

    return (() async {
      final byteData = await _loadFontByteData(
        WebFontsDescriptor(
            familyWithVariant: WebFontsFamilyWithVariant(
                family: fontFamily, fontsVariant: fontVariant),
            file: fontFile),
      );

      if (byteData == null) {
        return;
      }

      fontLoader.addFont(Future.value(byteData));
    })();
  }));

  await fontLoader.load();
}

Future<ByteData?> _loadFontByteData(WebFontsDescriptor descriptor) async {
  final familyWithVariantString = descriptor.familyWithVariant.toString();

  try {
    // Check if this font can be loaded from the device file system.
    final byteData = await file_io.loadFontFromDeviceFileSystem(
        familyWithVariantString,
        ext: descriptor.file.ext);

    return byteData;
  } catch (e) {
    print(
        'Error: unable to load font $familyWithVariantString from local storage because the '
        'following exception occurred:\n$e');
  }

  try {
    final byteData = await _httpFetchFontAndSaveToDevice(
      familyWithVariantString,
      descriptor.file,
    );

    return byteData;
  } catch (e) {
    print('Error: unable to load font $familyWithVariantString because the '
        'following exception occurred:\n$e');
  }

  return null;
}

/// Fetches a font with [fontName] from the [fontUrl] and saves it locally if
/// it is the first time it is being loaded.
///
/// This function can return `null` if the font fails to load from the URL.
Future<ByteData> _httpFetchFontAndSaveToDevice(
  String fontName,
  WebFontsFile file,
) async {
  final uri = Uri.tryParse(file.url);

  if (uri == null) {
    throw Exception('Invalid fontUrl: ${file.url}');
  }

  http.Response response;
  try {
    response = await httpClient.get(uri);
  } catch (e) {
    throw Exception('Failed to load font with url: ${file.url}');
  }
  if (response.statusCode == 200) {
    file_io
        .saveFontToDeviceFileSystem(fontName, response.bodyBytes, ext: file.ext)
        .ignore();

    return ByteData.view(response.bodyBytes.buffer);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load font with url: ${file.url}');
  }
}
