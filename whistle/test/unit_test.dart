import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whistle/FFmpegConvert.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('Audio conversion', () async {
    //setup
    FFmpegConvert ffmpegInstance =
        FFmpegConvert('C:/Users/shayer/Documents/NUS/Orbital/royalty.mp3');
    String output = '';

    //do
    output = await ffmpegInstance.convertFile();

    //test
    expect(output, 'C:/Users/shayer/Documents/NUS/Orbital/royalty.wav');
  });
}
