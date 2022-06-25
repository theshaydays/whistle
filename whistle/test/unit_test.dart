import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whistle/fftAnalysis.dart';
import 'package:whistle/models/Formatting.dart';
import 'package:wav/wav.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('Time Formatting', () {
    //setup
    int inputTime = 66;

    //do
    String output = formattedTime(inputTime);

    //test
    expect(output, '01:06');
  });

  test('FFT Analysis', () async {
    //setup
    String filePath =
        "C:\\Users\\shayer\\Documents\\NUS\\Orbital\\Tests\\note1.wav";
    Wav inputAudio = await Wav.readFile(filePath);
    double sampleRate = 41100;

    //do
    double output =
        await FFTAnalysis(filePath, '1.0').analyse(inputAudio, sampleRate);

    //test
    expect(output, 0.0);
  });

  // cannot run ffmpeg tests because it's not supported by windows
  // test('Audio conversion', () async {
  //   //setup
  //   FFmpegConvert ffmpegInstance =
  //       FFmpegConvert('C:/Users/shayer/Documents/NUS/Orbital/royalty.mp3');
  //   String output = '';

  //   //do
  //   output = await ffmpegInstance.convertFile();

  //   //test
  //   expect(output, 'C:/Users/shayer/Documents/NUS/Orbital/royalty.wav');
  // });
}
