import 'package:flutter/material.dart';
import 'package:whistle/FFTAnalysis.dart';
import 'package:whistle/LoadingPage.dart';
import 'package:whistle/models/NoteFrequencies.dart';
import 'package:whistle/models/constants.dart';
import 'package:whistle/models/Formatting.dart';
import 'StaticPlayer.dart';
import 'package:whistle/RecentProjects.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class NewAudioPage extends StatefulWidget {
  final String filePath;
  final String audioName;
  final String duration;

  const NewAudioPage(this.filePath, this.audioName, this.duration);

  @override
  _NewAudioPageState createState() => _NewAudioPageState();
}

class _NewAudioPageState extends State<NewAudioPage> {
  bool _isLoading = false;
  List<String>? images;
  List<int>? randomList;

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/LoadingScreen/'))
        .where((String key) => key.contains('.jpg'))
        .toList();

    setState(() {
      images = imagePaths;
      randomList = List.generate(images!.length, (index) => index + 1);
      randomList?.shuffle();
    });
    print('testing $images');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (_isLoading) {
      return LoadingPage(images!, randomList!);
    }

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
                      await _initImages();
                      setState(() => _isLoading = true);
                      Future.delayed(Duration(seconds: 5));
                      List<double> freq =
                          await FFTAnalysis(widget.filePath, widget.duration)
                              .main();
                      double resolution =
                          FFTAnalysis(widget.filePath, widget.duration)
                              .getResolution();
                      print(freq);
                      //String note = NoteFrequencies().getNote(freq[0]);
                      List<List<dynamic>> notes =
                          NoteFrequencies().getNoteList(freq, resolution);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecentProjects(notes),
                        ),
                      );
                      setState(() => _isLoading = false);

                      // old code where a popup would come up with the notes produced by fft
                      // showDialog<String>(
                      //   context: context,
                      //   builder: (BuildContext context) => AlertDialog(
                      //     content: Text('Your note is ' + notes),
                      //     actions: <Widget>[
                      //       TextButton(
                      //           onPressed: () =>
                      //               Navigator.pop(context, 'Close'),
                      //           child: const Text('Close')),
                      //     ],
                      //   ),
                      // );
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
