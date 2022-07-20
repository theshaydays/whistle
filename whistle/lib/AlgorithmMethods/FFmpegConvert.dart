// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter/media_information_session.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

class FFmpegConvert {
  final String filePath;

  const FFmpegConvert(this.filePath);

  void main() {
    FFprobeKit.getMediaInformation(this.filePath).then((session) async {
      final information = await session.getMediaInformation();

      if (information == null) {
        // CHECK THE FOLLOWING ATTRIBUTES ON ERROR
        // final state =
        //     FFmpegKitConfig.sessionStateToString(await session.getState());
        // final returnCode = await session.getReturnCode();
        // final failStackTrace = await session.getFailStackTrace();
        // final duration = await session.getDuration();
        // final output = await session.getOutput();
      }
      print(information?.getAllProperties());
    });
  }

  Future<double> getSampleRate() async {
    double sampleRate;
    MediaInformationSession properties =
        await FFprobeKit.getMediaInformation(this.filePath);
    Map<dynamic, dynamic>? infoMap =
        properties.getMediaInformation()?.getAllProperties();
    sampleRate = double.parse(infoMap!['streams'][0]['sample_rate']);
    return sampleRate;
  }

  Future<String> getFileType() async {
    String fileType;
    MediaInformationSession properties =
        await FFprobeKit.getMediaInformation(this.filePath);
    fileType = properties.getMediaInformation()!.getFormat()!;

    return fileType;
  }

  Future<String> convertFile() async {
    String path = this.filePath;
    Directory appDocumentDir = await getApplicationDocumentsDirectory();
    String rawDocumentPath = appDocumentDir.path;
    String fullFileName = this.filePath.split('/').last;
    String fileName = fullFileName.split('.').first;
    String outputPath = rawDocumentPath + "/" + fileName + ".wav";
    String command = '-i ' + path + ' ' + outputPath;
    FFmpegSession sess = await FFmpegKit.execute(command);
    //print('issit the entire thing ' + outputPath);
    return outputPath;
  }

  Future<String> getDuration() async {
    String duration;
    MediaInformationSession properties =
        await FFprobeKit.getMediaInformation(this.filePath);
    duration = properties.getMediaInformation()!.getDuration()!;
    return duration;
  }

  Future<String> sliceAudio(double start, double end, int idx) async {
    //String fileType = await getFileType();
    String path = this.filePath;
    Directory appDocumentDir = await getApplicationDocumentsDirectory();
    String rawDocumentPath = appDocumentDir.path;
    //i ended up just calling the file result, the following 4 lines of code is q pointless
    String fullFileName = this.filePath.split('/').last;
    String fileName = fullFileName.split('.').first;
    fileName = fileName.replaceAll(' ', '');
    String outPath = rawDocumentPath +
        "output$idx.wav"; // files are converted to wav before slicing already
    var cmd =
        "-y -i \"$path\" -vn -ss $start -to $end -ar 16k -ac 2 -b:a 96k -acodec copy $outPath";
    FFmpegSession sess = await FFmpegKit.execute(cmd);
    return outPath;
  }
}
