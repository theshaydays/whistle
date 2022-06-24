import 'package:flutter/material.dart';
import 'package:whistle/FFTAnalysis.dart';
import 'package:whistle/LoadingPage.dart';
import 'package:whistle/PlayButton.dart';
import 'package:whistle/models/NoteFrequencies.dart';
import 'package:whistle/models/constants.dart';
import 'package:whistle/models/Formatting.dart';
import 'StaticPlayer.dart';
import 'package:whistle/RecentProjects.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'Slider.dart';

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
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

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
  void initState() {
    super.initState();
    _audioPlayer.setFilePath(widget.filePath);

    // In the future, we want both asset files and device files to be played. We will need to change the parameters passed into this class so the following code chunk will become pivotal
    // if (widget.pathType == 'asset') {
    //   _audioPlayer.setAsset(widget.filePath);
    // } else if (widget.pathType == 'device file') {
    //   _audioPlayer.setFilePath(widget.filePath);
    // }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _audioPlayer.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (_isLoading) {
      return LoadingPage(images!, randomList!);
    }

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: BackButton(),
          title: Text(
            'Now Playing',
            style: TextStyle(
                fontSize: 15.0,
                color: kWhiteColor,
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
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: StreamBuilder<PositionData>(
                  stream: _positionDataStream,
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;
                    return SeekBar(
                      duration: positionData?.duration ?? Duration.zero,
                      position: positionData?.position ?? Duration.zero,
                      bufferedPosition:
                          positionData?.bufferedPosition ?? Duration.zero,
                      onChangeEnd: _audioPlayer.seek,
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0.0),
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await _initImages();
                        setState(() => _isLoading = true);
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
                    PlayButton(_audioPlayer),
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
      ),
    );
  }
}
