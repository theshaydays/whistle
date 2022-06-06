import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/media_information_session.dart';

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
}
