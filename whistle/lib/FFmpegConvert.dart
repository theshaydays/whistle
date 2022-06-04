import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';

class FFmpegConvert {
  final String filePath;

  const FFmpegConvert(this.filePath);

  void main() {
    FFprobeKit.getMediaInformation(this.filePath).then((session) async {
      final information = await session.getMediaInformation();

      if (information == null) {
        // CHECK THE FOLLOWING ATTRIBUTES ON ERROR
        final state =
            FFmpegKitConfig.sessionStateToString(await session.getState());
        final returnCode = await session.getReturnCode();
        final failStackTrace = await session.getFailStackTrace();
        final duration = await session.getDuration();
        final output = await session.getOutput();
      }
      print(information?.getFormat());
    });
  }
}
