import 'package:flutter/material.dart';
import 'package:piano/piano.dart';

class RecentProjects extends StatefulWidget {
  @override
  _RecentProjectsState createState() => _RecentProjectsState();
}

class _RecentProjectsState extends State<RecentProjects> {
  Widget build(BuildContext context) {
    return ClefImage(
      clef: Clef.Treble,
      noteRange: NoteRange(NotePosition(note: Note.C, octave: -10),
          NotePosition(note: Note.C, octave: 10)),
      noteImages: [
        NoteImage(
            notePosition: NotePosition(
                note: Note.B, octave: 3, accidental: Accidental.Sharp),
            offset: 0.25),
        NoteImage(
          notePosition: NotePosition(
              note: Note.E, octave: 5, accidental: Accidental.Flat),
          offset: 0.25,
        )
      ],
      clefColor: Colors.white,
      noteColor: Colors.white,
      size: Size.zero,
    );
  }
}
