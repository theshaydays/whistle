import 'package:flutter/material.dart';
import 'package:piano/piano.dart';
import 'package:whistle/HomeScreen.dart';
import 'package:whistle/models/Notes.dart';
import 'package:whistle/models/constants.dart';

class RecentProjects extends StatefulWidget {
  final List<List<dynamic>> noteList;

  const RecentProjects(this.noteList);

  @override
  _RecentProjectsState createState() => _RecentProjectsState();
}

class _RecentProjectsState extends State<RecentProjects> {
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
              'Recent Projects',
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
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
                              builder: (context) => HomeScreen(),
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
          body: _buildScore(context, widget.noteList),
          backgroundColor: kSecondaryColor,
        ),
      );
}

Widget _buildScore(BuildContext context, List<List<dynamic>> list) {
  return ClefImage(
    clef: Clef.Treble,
    noteRange: NoteRange(NotePosition(note: Note.C, octave: -10),
        NotePosition(note: Note.C, octave: 10)),
    noteImages: getNotes(list),
    clefColor: kPrimaryColor,
    noteColor: kPrimaryColor,
    size: Size.infinite,
  );
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

//function to get the number of staves needed
int getStaves(List<List<dynamic>> noteResults) {
  int noOfStaves = 0;
  for (int i = 0; i < noteResults.length; i++) {
    if (noteResults.length % (10) == 0) {
      noOfStaves++;
    }
  }
  return noOfStaves;
}

//function to split the list of notes into smaller lists (each containing only 10 notes)
List<List<List<dynamic>>> getSmallLists(List<List<dynamic>> noteResults) {
  List<List<List<dynamic>>> chunks = [];
  int chunkSize = 10;
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
