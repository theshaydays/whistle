import 'package:flutter/material.dart';
import 'package:whistle/models/Formatting.dart';
import 'package:whistle/models/constants.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:whistle/FFMPEGConvert.dart';
import 'package:whistle/NewAudioPage.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({Key? key}) : super(key: key);

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  String? filePath;

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) return;
    filePath = await recorder.stopRecorder();

    print('Recorded audio: $filePath');
  }

  Future pause() async {
    if (!isRecorderReady) return;
    await recorder.pauseRecorder();
  }

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
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

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
              'New Project',
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
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 200, 10, 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
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
                      Ink(
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
                            if (recorder.isRecording) {
                              await stop();
                            } else {
                              await record();
                            }
                            setState(() {});
                          },
                          iconSize: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(recorder.isRecording
                            ? 'Press to stop recording'
                            : 'Press to record'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
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
                                  builder: ((context) => NewAudioPage(filePath!,
                                      'recorded audio', fileDuration))));
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
