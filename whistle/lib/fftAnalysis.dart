import 'dart:typed_data';
import 'package:fftea/fftea.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:wav/wav.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:math';

class fftAnalysis {
  Future<String> loadAudio() async {
    return await rootBundle.loadString('assets/audio/note1.wav');
  }

  void main() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    String filePath = '';
    if (result != null) {
      filePath = result.files.single.path as String;
    } else {
      // user cancelled picker
    }

    final sound = await Wav.readFile(filePath);
    List<double> audio = sound.toMono();

    final chunkSize = 2048;
    final stft = STFT(chunkSize, Window.hanning(chunkSize));

    final spectrogram = <Float64List>[];
    stft.run(audio, (Float64x2List freq) {
      spectrogram.add(freq.discardConjugates().magnitudes());

      List<double> list = freq.discardConjugates().magnitudes().toList();
      double maxVal = 0;
      int idx = 0;
      for (int i = 0; i < list.length; i++) {
        if (list[i] > maxVal) {
          maxVal = list[i];
          idx = i;
        }
      }
      print(idx);
      print(freq
          .discardConjugates()
          .magnitudes()
          .toList()
          .reduce(max)
          .toString());
    });
    print('value is ' + stft.frequency(49, 44100).toString());

    // final fft = FFT(myData.length);
    // final freq = fft.realFft(myData);
    // print(freq);

    //String filePath = fftAnalysis().loadAudio();
    //final wav = await Wav.readFile(filePath);
    //print(wav.samplesPerSecond);
  }
}
