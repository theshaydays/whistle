import 'package:flutter/material.dart';
import 'package:whistle/FFTAnalysis.dart';
import 'package:whistle/models/NoteFrequencies.dart';
import 'package:whistle/models/constants.dart';
import 'package:whistle/models/Formatting.dart';
import 'StaticPlayer.dart';

class NewAudioPage extends StatefulWidget {
  final String filePath;
  final String audioName;
  final String duration;

  const NewAudioPage(this.filePath, this.audioName, this.duration);

  @override
  _NewAudioPageState createState() => _NewAudioPageState();
}

class _NewAudioPageState extends State<NewAudioPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back,
          color: kPrimaryColor,
        ),
        title: Text(
          'Now Playing',
          style: TextStyle(
              fontSize: 15.0,
              color: kPrimaryColor,
              fontWeight: FontWeight.w800),
        ),
        actions: [
          SizedBox(
            width: 10.0,
          ),
          Icon(
            Icons.more_horiz,
            color: kPrimaryColor,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
              height: size.height * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: AssetImage('images/music.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    widget.audioName,
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Icon(
                    Icons.favorite,
                    color: favoriteColor,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'User Audio Input',
                style: TextStyle(
                    color: kLightColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(top: 10.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              width: double.infinity,
              child: LinearProgressIndicator(
                backgroundColor: kLightColor2,
                value: 0.6,
                valueColor: AlwaysStoppedAnimation(kPrimaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    '00:00',
                    style: TextStyle(
                        color: kLightColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    formattedTime(double.parse(widget.duration).toInt()),
                    style: TextStyle(
                        color: kLightColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () async {
                      List<double> freq =
                          await FFTAnalysis(widget.filePath, widget.duration)
                              .main();
                      double resolution =
                          FFTAnalysis(widget.filePath, widget.duration)
                              .getResolution();
                      print(freq);
                      //String note = NoteFrequencies().getNote(freq[0]);
                      String notes =
                          NoteFrequencies().getNoteList(freq, resolution);
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: Text('Your note is ' + notes),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Close'),
                                child: const Text('Close')),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.music_note),
                    color: kLightColor,
                    iconSize: 0.09 * size.width,
                  ),
                  Icon(
                    Icons.skip_previous,
                    color: kPrimaryColor,
                    size: 0.12 * size.width,
                  ),
                  StaticPlayer(widget.filePath, 'device file'),
                  Icon(
                    Icons.skip_next,
                    color: kPrimaryColor,
                    size: 0.12 * size.width,
                  ),
                  Icon(
                    Icons.swap_horiz,
                    color: kLightColor,
                    size: 0.09 * size.width,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
