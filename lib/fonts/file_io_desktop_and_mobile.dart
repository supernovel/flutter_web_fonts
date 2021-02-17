import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> saveFontToDeviceFileSystem(String name, List<int> bytes,
    {String ext}) async {
  final file = await _localFile(name, ext: ext);
  await file.writeAsBytes(bytes);
}

Future<ByteData> loadFontFromDeviceFileSystem(String name, {String ext}) async {
  try {
    final file = await _localFile(name, ext: ext);
    final fileExists = file.existsSync();
    if (fileExists) {
      List<int> contents = await file.readAsBytes();
      if (contents != null && contents.isNotEmpty) {
        return ByteData.view(Uint8List.fromList(contents).buffer);
      }
    }
  } catch (e) {
    return null;
  }
  return null;
}

Future<String> get _localPath async {
  final directory = await path_provider.getApplicationSupportDirectory();
  return directory.path;
}

Future<File> _localFile(String name, {String ext}) async {
  final path = await _localPath;
  return File('$path/$name.${ext ?? 'otf'}');
}
