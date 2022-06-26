import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

//original code that works
// Widget _buildScore(BuildContext context, List<List<dynamic>> list) {
//   return ClefImage(
//     clef: Clef.Treble,
//     noteRange: NoteRange(NotePosition(note: Note.C, octave: -10),
//         NotePosition(note: Note.C, octave: 10)),
//     noteImages: getNotes(list),
//     clefColor: kPrimaryColor,
//     noteColor: kPrimaryColor,
//     size: Size.infinite,
//   );
// }

//the one i tried .... but idk if this works
Widget _buildScore(BuildContext context, noteResults) {
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
      height: size.height + (stavesRequired - 3) * 200,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text("JODY IS SMART"),
      ),
    )
  ];
  for (int i = 0; i < stavesRequired; i++) {
    staves.add(Positioned(
      top: i * 200,
      child: ClefImage(
        clef: Clef.Treble,
        noteRange: NoteRange(NotePosition(note: Note.C, octave: -10),
            NotePosition(note: Note.C, octave: 10)),
        noteImages: getNotes(splitNotes[i]),
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
  if (noteResults.length == 0) {
    return 0;
  }
  return (noteResults.length ~/ 10) + 1;
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
