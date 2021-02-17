import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'web_fonts_descriptor.dart';
import 'web_fonts_family_with_variant.dart';
import 'web_fonts_variant.dart';

import 'file_io.dart' // Stubbed implementation by default.
    // Concrete implementation if File IO is available.
    if (dart.library.io) 'file_io_desktop_and_mobile.dart' as file_io;

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
  @required String fontFamily,
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
  List<Shadow> shadows,
  List<FontFeature> fontFeatures,
  TextDecoration decoration,
  Color decorationColor,
  TextDecorationStyle decorationStyle,
  double decorationThickness,
  @required Map<WebFontsVariant, WebFontsFile> fonts,
}) {
  assert(fontFamily != null);
  assert(fonts != null);

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

  final variant = WebFontsVariant(
    fontWeight: textStyle.fontWeight ?? FontWeight.w400,
    fontStyle: textStyle.fontStyle ?? FontStyle.normal,
  );
  final matchedVariant = _closestMatch(variant, fonts.keys);
  final familyWithVariant = WebFontsFamilyWithVariant(
    family: fontFamily,
    fontsVariant: matchedVariant,
  );

  final descriptor = WebFontsDescriptor(
    familyWithVariant: familyWithVariant,
    file: fonts[matchedVariant],
  );

  loadFontIfNecessary(descriptor);

  return textStyle.copyWith(
    fontFamily: familyWithVariant.toString(),
    fontFamilyFallback: [fontFamily],
  );
}

/// Loads a font into the [FontLoader] with [googleFontsFamilyName] for the
/// matching [expectedFileHash].
///
/// If a font with the [fontName] has already been loaded into memory, then
/// this method does nothing as there is no need to load it a second time.
///
/// Otherwise, this method will first check to see if the font is available
/// as an asset, then on the device file system. If it isn't, it is fetched via
/// the [fontUrl] and stored on device. In all cases, the font is loaded into
/// the [FontLoader].
Future<void> loadFontIfNecessary(WebFontsDescriptor descriptor) async {
  final familyWithVariantString = descriptor.familyWithVariant.toString();
  final fontName = descriptor.familyWithVariant.toApiFilenamePrefix();
  // If this font has already already loaded or is loading, then there is no
  // need to attempt to load it again, unless the attempted load results in an
  // error.
  if (_loadedFonts.contains(familyWithVariantString)) {
    return;
  } else {
    _loadedFonts.add(familyWithVariantString);
  }

  try {
    Future<ByteData> byteData;

    // Check if this font can be loaded from the device file system.
    byteData = file_io.loadFontFromDeviceFileSystem(familyWithVariantString,
        ext: descriptor.file.ext);

    if (await byteData != null) {
      return _loadFontByteData(familyWithVariantString, byteData);
    }

    byteData = _httpFetchFontAndSaveToDevice(
      familyWithVariantString,
      descriptor.file,
    );

    if (await byteData != null) {
      return _loadFontByteData(familyWithVariantString, byteData);
    }
  } catch (e) {
    _loadedFonts.remove(familyWithVariantString);
    print('Error: google_fonts was unable to load font $fontName because the '
        'following exception occured:\n$e');
  }
}

/// Loads a font with [FontLoader], given its name and byte-representation.
Future<void> _loadFontByteData(
  String familyWithVariantString,
  Future<ByteData> byteData,
) async {
  final anyFontDataFound = byteData != null && await byteData != null;
  if (anyFontDataFound) {
    final fontLoader = FontLoader(familyWithVariantString);
    fontLoader.addFont(byteData);
    await fontLoader.load();
  }
}

/// Returns [WebFontsVariant] from [variantsToCompare] that most closely
/// matches [sourceVariant] according to the [_computeMatch] scoring function.
///
/// This logic is derived from the following section of the minikin library,
/// which is ultimately how flutter handles matching fonts.
/// https://github.com/flutter/engine/blob/master/third_party/txt/src/minikin/FontFamily.cpp#L149
WebFontsVariant _closestMatch(
  WebFontsVariant sourceVariant,
  Iterable<WebFontsVariant> variantsToCompare,
) {
  int bestScore;
  WebFontsVariant bestMatch;
  for (final variantToCompare in variantsToCompare) {
    final score = _computeMatch(sourceVariant, variantToCompare);
    if (bestScore == null || score < bestScore) {
      bestScore = score;
      bestMatch = variantToCompare;
    }
  }
  return bestMatch;
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
    _unawaited(file_io.saveFontToDeviceFileSystem(fontName, response.bodyBytes,
        ext: file.ext));

    return ByteData.view(response.bodyBytes.buffer);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load font with url: ${file.url}');
  }
}

// This logic is taken from the following section of the minikin library, which
// is ultimately how flutter handles matching fonts.
// * https://github.com/flutter/engine/blob/master/third_party/txt/src/minikin/FontFamily.cpp#L128
int _computeMatch(WebFontsVariant a, WebFontsVariant b) {
  if (a == b) {
    return 0;
  }
  int score = (a.fontWeight.index - b.fontWeight.index).abs();
  if (a.fontStyle != b.fontStyle) {
    score += 2;
  }
  return score;
}

void _unawaited(Future<void> future) {}
