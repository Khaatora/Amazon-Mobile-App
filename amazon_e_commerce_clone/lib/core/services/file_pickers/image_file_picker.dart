import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

abstract class ImageFilePicker {
  Future<List<dynamic>> pickImages();
}

@immutable
class FPImageFilePicker implements ImageFilePicker {
  @override
  Future<List<File>> pickImages() async {
    List<File> images = [];
    try {
      var result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (result != null && result.files.isNotEmpty) {
        for (var file in result.files) {
          images.add(File(file.path!));
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return images;
  }

  const FPImageFilePicker();
}
