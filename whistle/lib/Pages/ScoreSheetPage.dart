import 'package:flutter/material.dart';
// import 'package:piano/piano.dart';
import 'package:whistle/Pages/HomePage.dart';
import 'package:whistle/models/Notes.dart';
import 'package:whistle/models/Constants.dart';

import 'package:whistle/ScorePainter/ClefImage.dart';
import 'package:whistle/ScorePainter/Clef.dart';
import 'package:whistle/ScorePainter/NoteRange.dart';
import 'package:whistle/ScorePainter/NotePosition.dart';
import 'package:whistle/ScorePainter/ClefPainter.dart';

final int notesPerStave = 8;

class ScoreSheetPage extends StatefulWidget {
  final List<List<dynamic>> noteList;
  final int BPM;

  const ScoreSheetPage(this.noteList, this.BPM);

  @override
  _ScoreSheetPageState createState() => _ScoreSheetPageState();
}

class _ScoreSheetPageState extends State<ScoreSheetPage> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you want to return to the previous page?'),
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
          backgroundColor: kSecondaryColor,
          appBar: AppBar(
            leading: BackButton(),
            backgroundColor: kPrimaryColor,
            title: Text(
              'Score Sheet',
              style: TextStyle(
                  fontSize: 20.0,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              SizedBox(
                width: 10.0,
              ),
              IconButton(
                icon: Icon(Icons.home),
                color: kWhiteColor,
                onPressed: () async {
                  List<Widget> widgetList = [
                    TextButton(
                        onPressed: () => Navigator.pop(context, 'Close'),
                        child: Text('No')),
                    TextButton(
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage(),
                            )),
                        child: Text('Yes')),
                  ];
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('Do you want to return to the home page?'),
                      content:
                          Text('Changes made on this page will not be saved'),
                      actions: widgetList,
                    ),
                  );
                },
              )
            ],
          ),
          body: _buildScore(context, widget.noteList, widget.BPM),
        ),
      );
}

Widget _buildScore(BuildContext context, noteResults, int BPM) {
  Size size = MediaQuery.of(context).size;
  //to determine how many staves should be printed out
  int stavesRequired = getStaves(noteResults);
  //to determine the max number of notes each stave can take
  List<List<List<dynamic>>> splitNotes = getSmallLists(noteResults);

  //list of staves
  List<Widget> staves = [
    Container(
      alignment: AlignmentDirectional.topCenter,
      width: size.width,
      height: size.height + (stavesRequired - 5) * 100,
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Text(
          'Your transcribed score!',
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    )
  ];
  for (int i = 0; i < stavesRequired; i++) {
    staves.add(Positioned(
      top: i * 100,
      child: ClefImage(
        clef: Clef.Treble,
        noteRange: NoteRange(NotePosition(note: Note.C, octave: -10),
            NotePosition(note: Note.C, octave: 10)),
        noteImages: getNotes(splitNotes[i], BPM),
        clefColor: kPrimaryColor,
        noteColor: kPrimaryColor,
        size: size,
      ),
    ));
  }
  return SingleChildScrollView(
    child: Stack(
      children: staves,
    ),
  );
}

//function to get all the notes
List<NoteImage> getNotes(List<List<dynamic>> noteResults, int BPM) {
  List<NoteImage> noteImages = [];
  for (int i = 0; i < noteResults.length; i++) {
    List<dynamic> noteInfo = notes[noteResults[i][0]] as List<dynamic>;
    if (noteInfo.isNotEmpty) {
      noteImages.add(NoteImage(
          isPause: false,
          noteLength: (noteResults[i][1] / (60 / BPM)) / 4,
          //noteLength: 1 / 8,
          notePosition: NotePosition(
              note: noteInfo[0], accidental: noteInfo[1], octave: noteInfo[2]),
          offset: (i) * 0.125));
    } else {
      noteImages.add(NoteImage(
          isPause: true,
          noteLength: (noteResults[i][1] / (60 / BPM)) / 4,
          notePosition: NotePosition(
              note: Note.C, accidental: Accidental.None, octave: -1),
          offset: (i) * 0.125));
    }
  }
  return noteImages;
}

//function to get the number of staves needed
int getStaves(List<List<dynamic>> noteResults) {
  if (noteResults.length == 0) {
    return 0;
  }
  return (noteResults.length % notesPerStave == 0
      ? noteResults.length ~/ notesPerStave
      : (noteResults.length ~/ notesPerStave) + 1);
  // int noOfStaves = 1;
  // for (int i = 0; i < noteResults.length; i+ +) {
  //   if (noteResults.length % (10) == 0) {
  //     noOfStaves++;
  //   }
  // }

  // print(noteResults.length);
  // return noOfStaves;
}

//function to split the list of notes into smaller lists (each containing only 10 notes)
List<List<List<dynamic>>> getSmallLists(List<List<dynamic>> noteResults) {
  List<List<List<dynamic>>> chunks = [];
  int chunkSize = notesPerStave;
  for (var i = 0; i < noteResults.length; i += chunkSize) {
    chunks.add(noteResults.sublist(
        i,
        i + chunkSize > noteResults.length
            ? noteResults.length
            : i + chunkSize));
  }
  return chunks;
}

//for loop to print the different lists of notes
Widget getScoreWidgets(List<String> noteResults) {
  return new Row(children: noteResults.map((item) => new Text(item)).toList());
}
