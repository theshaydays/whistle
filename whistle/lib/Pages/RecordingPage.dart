import 'package:flutter/material.dart';
import 'package:whistle/models/TimeFormatting.dart';
import 'package:whistle/models/Constant.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:whistle/AlgorithmMethods/FFmpegConvert.dart';
import 'package:whistle/Pages/AudioPlayerPage.dart';
import 'package:whistle/Pages/NewProjectPage.dart';
import 'package:whistle/Pages/HomePage.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({Key? key}) : super(key: key);

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  String? filePath;
  bool permissionGranted = true;

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) return;
    filePath = await recorder.stopRecorder();
  }

  Future pause() async {
    if (!isRecorderReady) return;
    await recorder.pauseRecorder();
  }

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
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      permissionGranted = false;
      //throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        key: ValueKey('Recording Page'),
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
              'NEW PROJECT',
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
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<RecordingDisposition>(
                        stream: recorder.onProgress,
                        builder: (context, snapshot) {
                          final duration = snapshot.hasData
                              ? snapshot.data!.duration
                              : Duration.zero;
                          String audioLength =
                              formattedTime(duration.inSeconds);
                          return Text(
                            audioLength,
                            style: TextStyle(fontSize: 80),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Ink(
                          height: 50,
                          width: 50,
                          decoration: const ShapeDecoration(
                            color: kPrimaryColor,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: Icon(recorder.isRecording
                                ? Icons.stop
                                : Icons.fiber_manual_record),
                            color: Colors.white,
                            onPressed: () async {
                              if (!permissionGranted) {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    content: Text(
                                        'Please enable microphone recording or select an audio file from your device.'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewProjectPage(),
                                                ),
                                              ),
                                          child: const Text('Close')),
                                    ],
                                  ),
                                );
                              } else {
                                if (recorder.isRecording) {
                                  await stop();
                                } else {
                                  await record();
                                }
                                setState(() {});
                              }
                            },
                            iconSize: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            recorder.isRecording
                                ? 'Press to stop recording'
                                : 'Press to record',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Ink(
                          height: 50,
                          width: 50,
                          decoration: const ShapeDecoration(
                            color: kPrimaryColor,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.music_note),
                            color: Colors.white,
                            onPressed: () async {
                              if (filePath == null) {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    content: Text('Please record audio first.'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Close'),
                                          child: const Text('Close')),
                                    ],
                                  ),
                                );
                                return;
                              }
                              String fileDuration =
                                  await FFmpegConvert(filePath!).getDuration();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => AudioPlayerPage(
                                      filePath!,
                                      'recorded audio',
                                      fileDuration,
                                      'device file'))));
                              setState(() {});
                            },
                            iconSize: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Press to analyse audio \n (Only after recording is done)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
