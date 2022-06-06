import 'dart:typed_data';
import 'package:fftea/fftea.dart';
import 'package:wav/wav.dart';

import 'dart:math';

import 'package:whistle/FFMPEGConvert.dart';

class FFTAnalysis {
  final String filePath;

  const FFTAnalysis(this.filePath);

  Future<double> main() async {
    // Getting Sample rate
    final double sampleRate =
        await FFmpegConvert(this.filePath).getSampleRate();

    //reading wav files
    final sound = await Wav.readFile(filePath);
    List<double> audio = sound.toMono();

    // setting accuracy -> higher value leads to higher accuracy, dont go above 15 as it gets really laggy
    int accuracy = 10;

    //setting up stft
    final chunkSize = pow(2, accuracy) as int;
    final stft = STFT(chunkSize, Window.hanning(chunkSize));
    //final spectrogram = <Float64List>[];

    //finding peak frequency
    List<int> peaks = [];
    stft.run(audio, (Float64x2List freq) {
      //spectrogram.add(freq.discardConjugates().magnitudes());
      List<double> list = freq.discardConjugates().magnitudes().toList();
      double maxVal = 0;
      int idx = 0;
      for (int i = 0; i < list.length; i++) {
        if (list[i] > maxVal) {
          maxVal = list[i];
          idx = i;
        }
      }

      peaks += [idx];
      print(idx);
      //   print(freq
      //       .discardConjugates()
      //       .magnitudes()
      //       .toList()
      //       .reduce(max)
      //       .toString());
    });

    //finding most popular index
    var popular = Map();
    peaks.forEach((k) {
      if (!popular.containsKey(k)) {
        popular[k] = 1;
      } else {
        popular[k] += 1;
      }
    });
    popular.remove(0);
    int v = 0;
    int keyIdx = 0;
    popular.forEach(
      (key, value) {
        if (v < value && key > 8) {
          keyIdx = key;
          v = value;
        }
      },
    );

    //Debugging and checking note prints DO NOT DELETE
    // print(popular);
    // print('final idx is ' + keyIdx.toString());
    print('Key frequency is ' + stft.frequency(keyIdx, sampleRate).toString());

    return stft.frequency(keyIdx, sampleRate);
    // final fft = FFT(myData.length);
    // final freq = fft.realFft(myData);
    // print(freq);

    //String filePath = fftAnalysis().loadAudio();
    //final wav = await Wav.readFile(filePath);
    //print(wav.samplesPerSecond);
  }
}
