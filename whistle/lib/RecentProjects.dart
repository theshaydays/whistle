import 'package:flutter/material.dart';
import 'package:piano/piano.dart';
import 'package:whistle/models/Notes.dart';

class RecentProjects extends StatefulWidget {
  final List<List<dynamic>> noteList;

  const RecentProjects(this.noteList);

  @override
  _RecentProjectsState createState() => _RecentProjectsState();
}

class _RecentProjectsState extends State<RecentProjects> {
  Widget build(BuildContext context) {
    return ClefImage(
      clef: Clef.Treble,
      noteRange: NoteRange(NotePosition(note: Note.C, octave: -10),
          NotePosition(note: Note.C, octave: 10)),
      noteImages: getNotes(widget.noteList),
      clefColor: Colors.white,
      noteColor: Colors.white,
      size: Size.zero,
    );
  }
}

//function to get all the notes
List<NoteImage> getNotes(List<List<dynamic>> noteResults) {
  List<NoteImage> noteImages = [];
  for (int i = 0; i < noteResults.length; i++) {
    List<dynamic> noteInfo = notes[noteResults[i][0]] as List<dynamic>;
    if (noteInfo.isNotEmpty) {
      noteImages.add(NoteImage(
          notePosition: NotePosition(
              note: noteInfo[0], accidental: noteInfo[1], octave: noteInfo[2]),
          offset: (i) * 0.1));
    }
  }
  return noteImages;
}
