// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:piano/piano.dart';
import 'package:whistle/models/constants.dart';

class PreviousProjects extends StatefulWidget {
  @override
  _PreviousProjectsState createState() => _PreviousProjectsState();
}

class _PreviousProjectsState extends State<PreviousProjects> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you want to return to home page?'),
          content: Text('Changes made on this page will not be saved'),
          actions: [
            ElevatedButton(
              child: Text('No'),
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              child: Text('Yes'),
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
              ),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(),
            backgroundColor: kPrimaryColor,
            title: Text(
              'Score Sheet',
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          ),
          body: ClefImage(
            clef: Clef.Treble,
            size: Size(10.0, 10.0),
            noteRange: NoteRange(NotePosition(note: Note.C, octave: -10),
                NotePosition(note: Note.C, octave: 10)),
            noteImages: [
              NoteImage(
                  notePosition: NotePosition(note: Note.B, octave: 3),
                  offset: 0.1),
              NoteImage(
                notePosition: NotePosition(note: Note.E, octave: 5),
                offset: 0.25,
              )
            ],
            clefColor: kPrimaryColor,
            noteColor: kPrimaryColor,
          ),
        ),
      );
}

/*Widget _buildScoreSheet(BuildContext context) {
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
    clefColor: kPrimaryColor,
    noteColor: kPrimaryColor,
    size: Size.zero,
  );
}*/
