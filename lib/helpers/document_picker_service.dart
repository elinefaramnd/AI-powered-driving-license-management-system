import 'dart:io';
import 'package:file_picker/file_picker.dart';
class DocumentPickerService {
  static Future<File?> pick() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf','jpg', 'jpeg','png',],
      allowMultiple: false,withData: false,);
    if (
    result == null || result.files.single.path == null) {
      return null;
    }
    return File(result.files.single.path!,);
  }
}