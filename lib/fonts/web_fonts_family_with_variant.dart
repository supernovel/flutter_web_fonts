import 'package:flutter/foundation.dart';

import 'web_fonts_variant.dart';

/// Represents fonts variant in Flutter-specific types.
class WebFontsFamilyWithVariant {
  const WebFontsFamilyWithVariant({
    required this.family,
    required this.fontsVariant,
  })  : assert(family != null),
        assert(fontsVariant != null);

  final String family;
  final WebFontsVariant fontsVariant;

  String toApiFilenamePrefix() {
    return '$family-${fontsVariant.toApiFilenamePart()}';
  }

  /// Returns a font family name that is modified with additional [fontWeight]
  /// and [fontStyle] descriptions.
  ///
  /// This string is used as a key to the loaded or stored fonts
  @override
  String toString() => '${family}_$fontsVariant';
}
