import 'package:flutter/material.dart';
import 'package:piano/piano.dart';
import 'package:whistle/models/Notes.dart';

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
      noteImages: [getNotes(List<List<dynamic>> notePosition)],
      clefColor: Colors.white,
      noteColor: Colors.white,
      size: Size.zero,
    );
  }
}

//function to get all the notes
getNotes(List<List<dynamic>> notePosition) {
  List<NoteImage> noteImages = [];
  for (int i = 0; i < notePosition.length; i++) {
  noteImages.add(notes![i]); 
  }
  return noteImages;
}

