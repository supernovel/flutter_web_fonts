import 'dart:ui';

/// Represents a Google Fonts API variant in Flutter-specific types.
class WebFontsVariant {
  const WebFontsVariant({
    required this.fontWeight,
    required this.fontStyle,
  });

  final FontWeight fontWeight;
  final FontStyle fontStyle;

  /// Converts this [WebFontsVariant] to a Google Fonts API specific variant
  /// name string.
  ///
  /// The following table shows how these variant strings convert:
  /// weight: 400, style: normal -> 'regular'
  /// weight: 400, style: italic -> 'italic'
  /// weight: 700, style: normal -> '700'
  /// weight: 700, style: italic -> '700italic'
  ///
  /// See [WebFontsVariant.toString] for the inverse function.
  @override
  String toString() {
    final fontWeightString =
        fontWeight.index == 3 ? '' : (fontWeight.index + 1) * 100;
    final fontStyleString = fontStyle
        .toString()
        .replaceAll('FontStyle.', '')
        .replaceFirst(_normal, fontWeight.index == 3 ? _regular : '');
    return '$fontWeightString$fontStyleString';
  }

  @override
  int get hashCode => hashValues(fontWeight, fontStyle);

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other.fontWeight == fontWeight && other.fontStyle == fontStyle;
  }
}

/// What the Flutter API calls a font style of normal/regular.
const _normal = 'normal';

/// What the Google Fonts API calls a font style of normal/regular.
const _regular = 'regular';
