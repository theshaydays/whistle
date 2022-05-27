import 'package:fftea/fftea.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:wav/wav.dart';
import 'package:file_picker/file_picker.dart';

class fftAnalysis {
  Future<String> loadAudio() async {
    return await rootBundle.loadString('assets/audio/note1.wav');
  }

  void main() async {
    final audio = await Wav.readFile('whistle/assets/audio/note1.wav');
    List<double> myData = audio.toMono();
    final fft = FFT(myData.length);
    final freq = fft.realFft(myData);
    print(freq);

    //String filePath = fftAnalysis().loadAudio();
    //final wav = await Wav.readFile(filePath);
    //print(wav.samplesPerSecond);
  }
}
