import 'dart:typed_data';
import 'package:fftea/fftea.dart';
import 'package:wav/wav.dart';

import 'dart:math';

import 'package:whistle/FFmpegConvert.dart';

class FFTAnalysis {
  final String filePath;
  final String duration;
  static final double resolution = 0.25;
  static final int accuracy = 12;
  static final double volThreshold = 100.00;

  const FFTAnalysis(this.filePath, this.duration);

  Future<List<double>> main() async {
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
    int numOfSlices = double.parse(this.duration) ~/ resolution;
    List<String> splicedAudioFilePaths = [];
    for (int i = 0; i < numOfSlices; i++) {
      splicedAudioFilePaths.add(await FFmpegConvert(newFilePath)
          .sliceAudio(i * resolution, (i + 1) * resolution, i));
    }
    //print(splicedAudioFilePaths);

    // analyse slices
    List<double> frequencyList = [];

    for (int i = 0; i < splicedAudioFilePaths.length; i++) {
      Wav slice = await Wav.readFile(splicedAudioFilePaths[i]);
      Future<double> freq = analyse(slice, sampleRate);
      frequencyList.add(await freq);
    }
    return frequencyList;
  }

  Future<double> analyse(Wav slice, double sampleRate) async {
    List<double> audio = slice.toMono();
    // setting accuracy -> higher value leads to higher accuracy, dont go above 15 as it gets really slow
    accuracy; //alr set in final parameters

    //setting up stft
    final chunkSize = pow(2, accuracy) as int;
    final stft = STFT(chunkSize, Window.hanning(chunkSize));
    //final spectrogram = <Float64List>[];

    //finding peak frequency
    List<int> peaks = [];
    bool loudEnough = true;
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

      print(list[idx]);
      if (list[idx] < volThreshold) {
        loudEnough = false;
      }

      peaks += [idx];
      //print(idx);
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
    int minKey = 0; // possible low pass filter
    popular.forEach(
      (key, value) {
        if (v < value && key > minKey) {
          keyIdx = key;
          v = value;
        }
      },
    );

    //Debugging and checking note prints DO NOT DELETE
    // print(popular);
    // print('final idx is ' + keyIdx.toString());
    print('Key frequency is ' + stft.frequency(keyIdx, sampleRate).toString());

    if (loudEnough) {
      return stft.frequency(keyIdx, sampleRate);
    } else {
      return 0.00;
    }
  }

  double getResolution() {
    return resolution;
  }
}
