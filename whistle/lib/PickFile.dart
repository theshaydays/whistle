import 'package:file_picker/file_picker.dart';

class PickFile {
  Future<String?> main() async {
    //user picking files
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    PlatformFile file = result!.files.first;
    return file.path;
  }
}
