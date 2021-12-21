import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';

class ImageUtils {
  static Future<File> cropImage(File file) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(file.path);
    final height = properties.height;
    final width = properties.width;
    File croppedFile = await FlutterNativeImage.cropImage(
        file.path, 15, (height! / 2 - 380).toInt(), (width! - 30).toInt(), 420);
    return croppedFile;
  }

  static Future<File> cropOval(File file) async {
    ImageProperties properties =
    await FlutterNativeImage.getImageProperties(file.path);
    final height = properties.height;
    final width = properties.width;
    File croppedFile = await FlutterNativeImage.cropImage(
        file.path, 15, (height! / 2 - 380).toInt(), (width! - 30).toInt(), 900);
    return croppedFile;
  }

}
