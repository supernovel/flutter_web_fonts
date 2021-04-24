import 'package:path/path.dart' as path;

import 'web_fonts_family_with_variant.dart';

/// Describes fonts.
///
/// This class mostly serves as a simple way to keep the connected font
/// information together.
class WebFontsDescriptor {
  const WebFontsDescriptor({
    required this.familyWithVariant,
    required this.file,
  });

  final WebFontsFamilyWithVariant familyWithVariant;
  final WebFontsFile file;
}

/// Describes a font file as it is _expected_ to be received from the server.
class WebFontsFile {
  WebFontsFile(this.url);

  final String url;

  String get ext =>
      (path.extension(Uri.tryParse(this.url)!.path)).replaceFirst('.', '');
}
