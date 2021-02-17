# web_fonts

- Lazy load web fonts
- Refer to `https://github.com/material-foundation/google-fonts-flutter`

## Getting started

First, add the `web_fonts` package to your pubspec dependencies

Define fonts

```dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_fonts/fonts/web_fonts_descriptor.dart';
import 'package:web_fonts/fonts/web_fonts_variant.dart';
import 'package:web_fonts/web_fonts.dart';

class NotoSansKRFont {
  static const _fontFamily = 'NotoSansKR';
  static bool _registered = false;

  // register font files
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

  static TextStyle getTextStyle([TextStyle textStyle]) {
    register();

    return WebFonts.getTextStyle(_fontFamily, textStyle: textStyle);
  }

  static TextTheme getTextTheme([TextTheme textTheme]) {
    register();

    return WebFonts.getTextTheme(_fontFamily, textTheme);
  }
}

```

To use font with the default TextStyle:

```dart
Text(
  'This is NotoSansKR',
  style: NotoSansKRFont.getTextStyle(),
),
```

### Licensing Fonts

The fonts on [fonts.google.com](https://fonts.google.com/) include license files for each font. For
example, the [Lato](https://fonts.google.com/specimen/Lato) font comes with an `OFL.txt` file.

Once you've decided on the fonts you want in your published app, you should add the appropriate
licenses to your flutter app's [LicenseRegistry](https://api.flutter.dev/flutter/foundation/LicenseRegistry-class.html).

For example:

```dart
void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(...);
}
```
