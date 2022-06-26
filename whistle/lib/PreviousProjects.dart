// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piano/piano.dart';
import 'main.dart';

class PreviousProjects extends StatefulWidget {
  @override
  _PreviousProjectsState createState() => _PreviousProjectsState();
}

void main() {
  runApp(MyApp());
}

class _PreviousProjectsState extends State<PreviousProjects> {
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
            // Use an audio library like flutter_midi to play the sound
          },
        ),
      ),
    );
  }
}
