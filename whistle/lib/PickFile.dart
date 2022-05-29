import 'package:file_picker/file_picker.dart';
import 'package:just_audio/just_audio.dart';

class PickFile {
  Future<PlatformFile?> getFile() async {
    //user picking files
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    PlatformFile file = result!.files.first;
    return file;
  }

  Future<String> getFileName() async {
    PlatformFile? file = await PickFile().getFile();
    String? fileName = file?.name;
    return fileName.toString();
  }

  Future<String> getFileDuration() async {
    PlatformFile? file = await PickFile().getFile();
    String? filePath = file?.name;
    final player = AudioPlayer();
    var duration = await player.setFilePath(filePath!);
    return duration!.inMinutes.toString();
  }

  Future<String> getFilePath() async {
    PlatformFile? file = await PickFile().getFile();
    String? filePath = file?.path;
    return filePath.toString();
  }
}
