// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:piano/piano.dart';
// import 'package:sheet_music/sheet_music.dart';

class PreviousProjects extends StatefulWidget {
  @override
  _PreviousProjectsState createState() => _PreviousProjectsState();
}

class _PreviousProjectsState extends State<PreviousProjects> {
  Widget build(BuildContext context) {
    return ClefImage(
      clef: Clef.Treble,
      noteRange: NoteRange(NotePosition(note: Note.C, octave: -10),
          NotePosition(note: Note.C, octave: 10)),
      noteImages: [
        NoteImage(
            notePosition: NotePosition(note: Note.B, octave: 3), offset: 0.1),
        NoteImage(
          notePosition: NotePosition(note: Note.E, octave: 5),
          offset: 0.25,
        )
      ],
      clefColor: Colors.white,
      noteColor: Colors.white,
      size: Size.zero,
    );
  }
}
