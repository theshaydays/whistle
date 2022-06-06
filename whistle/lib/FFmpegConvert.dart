import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/media_information_session.dart';
import 'package:path_provider/path_provider.dart';

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
    String outputPath = rawDocumentPath + "/output.wav";
    String command = '-i ' + path + ' ' + outputPath;
    FFmpegSession sess = await FFmpegKit.execute(command);
    print(await sess.getOutput());
    print(outputPath);
    return outputPath;
  }
}
