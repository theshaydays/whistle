import 'dart:typed_data';
import 'package:fftea/fftea.dart';
import 'package:wav/wav.dart';

import 'dart:math';

import 'package:whistle/FFmpegConvert.dart';

class FFTAnalysis {
  final String filePath;
  final String duration;

  const FFTAnalysis(this.filePath, this.duration);

  Future<double> main() async {
    // getting sample rate
    final double sampleRate =
        await FFmpegConvert(this.filePath).getSampleRate();

    // checking file format
    final format = FFmpegConvert(this.filePath).getFileType();

    //converting from wav files
    String newFilePath = this.filePath;
    if (format != 'wav') {
      newFilePath = await FFmpegConvert(this.filePath).convertFile();
    }

    //audio slicing
    double resolution = 0.125;
    int numOfSlices = double.parse(this.duration) ~/ 0.25;
    List<String> splicedAudioFilePaths = [];
    for (int i = 0; i < numOfSlices; i++) {
      splicedAudioFilePaths.add(await FFmpegConvert(newFilePath)
          .sliceAudio(i * resolution, (i + 1) * resolution, i));
    }
    print(splicedAudioFilePaths);

    // analyse slices
    List<Future<double>> frequencyList = [];
    splicedAudioFilePaths.forEach((element) async {
      Wav slice = await Wav.readFile(element);
      frequencyList.add(analyse(slice, sampleRate));
    });
    List<double> frqs = [];
    frequencyList.forEach((element) async => frqs.add(await element));
    print('freq lsit is $frqs');
    return 500.00;
  }

  Future<double> analyse(Wav slice, double sampleRate) async {
    List<double> audio = slice.toMono();
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
