import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:whistle/Pages/RecordingPage.dart';
import 'package:whistle/models/Constant.dart';
import 'package:whistle/Pages/AudioPlayerPage.dart';
import 'package:whistle/AlgorithmMethods/FFmpegConvert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:whistle/Pages/HomePage.dart';

class NewProjectPage extends StatefulWidget {
  @override
  _NewProjectPageState createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          key: ValueKey('BackButton'),
          title: Text('Do you want to return to the previous page?'),
          content: Text('Changes made on this page will not be saved'),
          actions: [
            ElevatedButton(
              key: ValueKey('BackButtonNo'),
              child: Text('No'),
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              key: ValueKey('BackButtonYes'),
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
        key: ValueKey('NewProjectPage'),
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
                key: ValueKey('HomeButton'),
                icon: Icon(Icons.home),
                color: kWhiteColor,
                onPressed: () async {
                  List<Widget> widgetList = [
                    TextButton(
                        key: ValueKey('HomeButtonNo'),
                        onPressed: () => Navigator.pop(context, 'Close'),
                        child: Text('No')),
                    TextButton(
                        key: ValueKey('HomeButtonYes'),
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage(),
                            )),
                        child: Text('Yes')),
                  ];
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      key: ValueKey('GoHomeDialog'),
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
            padding: const EdgeInsets.fromLTRB(10, 200, 10, 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Ink(
                        height: 100,
                        width: 100,
                        decoration: const ShapeDecoration(
                          color: kPrimaryColor,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          key: ValueKey('ToRecordingPage'),
                          icon: const Icon(Icons.mic),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RecordingPage(),
                              ),
                            );
                          },
                          iconSize: 80,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Record Audio',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Ink(
                        width: 100,
                        height: 100,
                        decoration: const ShapeDecoration(
                          color: kPrimaryColor,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.folder),
                          color: Colors.white,
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(type: FileType.audio);
                            if (result != null) {
                              PlatformFile file = result.files.first;
                              String fileDuration =
                                  await FFmpegConvert(file.path!).getDuration();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => AudioPlayerPage(
                                      file.path!,
                                      file.name,
                                      fileDuration,
                                      'device file'))));
                              FilePickerStatus.done;
                              // NewAudioPage(
                              //   file.path!,
                              //   file.name,
                              // );
                              // print(file.path!);
                            } else {
                              // user cancelled picker
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: Text(
                                      'Please enable file selection or record audio in this app itself.'),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Close')),
                                  ],
                                ),
                              );
                            }
                          },
                          iconSize: 75,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Select file from device',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: kSecondaryColor,
            color: kLightColor2,
            items: <Widget>[
              Icon(Icons.home, size: 30, color: kPrimaryColor),
              Icon(Icons.search, size: 30, color: kPrimaryColor),
              Icon(Icons.favorite, size: 30, color: favoriteColor),
              Icon(Icons.playlist_play, size: 30, color: kPrimaryColor),
              Icon(Icons.person, size: 30, color: kPrimaryColor),
            ],
          ),
        ),
      );
}
