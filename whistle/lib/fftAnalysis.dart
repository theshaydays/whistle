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
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File file;
    if (result != null) {
      File file = File(result.files.single.path);
    } else {}

    //final audio = await Wav.readFile('whistle/assets/audio/note1.wav');
    List<double> myData = file.readAsBytesSync();
    final fft = FFT(myData.length);
    final freq = fft.realFft(myData);
    print(freq);

    //String filePath = fftAnalysis().loadAudio();
    //final wav = await Wav.readFile(filePath);
    //print(wav.samplesPerSecond);
  }
}
