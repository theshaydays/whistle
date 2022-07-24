// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:piano/piano.dart';
import 'package:whistle/models/Notes.dart';

class SampleKeyboardPage extends StatefulWidget {
  @override
  _SampleKeyboardPageState createState() => _SampleKeyboardPageState();
}

class _SampleKeyboardPageState extends State<SampleKeyboardPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      key: ValueKey('KeyboardPage'),
      debugShowCheckedModeBanner: false,
      title: 'Piano Demo',
      home: Center(
        child: InteractivePiano(
          highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
          naturalColor: Colors.white,
          accidentalColor: Colors.black,
          keyWidth: 60,
          noteRange: NoteRange.forClefs([
            Clef.Treble,
          ]),
          onNotePositionTapped: (position) {
            String note = keyboard[position.name] as String;
            print(note);
            AudioPlayer _audioPlayer = AudioPlayer();
            _audioPlayer.setAsset('audio/Piano_$note.mp3');
            _audioPlayer.play();
          },
        ),
      ),
    );
  }
}
