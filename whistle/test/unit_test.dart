import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piano/piano.dart';
import 'package:whistle/Pages/ScoreSheetPage.dart';
import 'package:whistle/AlgorithmMethods/FFTAnalysis.dart';
import 'package:whistle/models/TimeFormatting.dart';
import 'package:wav/wav.dart';
import 'package:whistle/models/NoteFrequencies.dart';

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

  // The following test is only to check that the correct return type is returned. The value being wrong is expected as algorithm testing is done
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

  test('Getting Note from frequency', () async {
    //setup
    double frequency = 440.00;

    //do
    String output = NoteFrequencies().getNote(frequency);

    //test
    expect(output, "A4");
  });

  test('Getting List of notes from frequencies', () async {
    //setup
    List<double> frequencies = [440.00, 0.00, 880.00, 880.00];

    //do
    List<List<dynamic>> output =
        NoteFrequencies().getNoteList(frequencies, 0.25);

    //test
    expect(output, [
      ["A4", 0.25],
      ["rest", 0.25],
      ["A5", 0.5]
    ]);
  });

  test('Getting List of NoteImages for printing', () async {
    //setup
    List<List<dynamic>> notes = [
      ["A4", 0.25],
      ["rest", 0.25],
      ["A5", 0.5]
    ];

    //do
    List<NoteImage> output = getNotes(notes);

    //test
    expect(
        output.toString(),
        [
          NoteImage(notePosition: NotePosition(note: Note.A)),
          NoteImage(notePosition: NotePosition(note: Note.A))
        ].toString());
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
