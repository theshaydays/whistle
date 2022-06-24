import 'package:flutter/material.dart';
import 'package:whistle/RecordingPage.dart';
import 'package:whistle/models/constants.dart';
import 'package:whistle/NewAudioPage.dart';
import 'package:whistle/FFMPEGConvert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:whistle/HomeScreen.dart';

class NewProject extends StatefulWidget {
  @override
  _NewProjectState createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
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
              'New Project',
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
                        child: Text('Record Audio'),
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
                                  builder: ((context) => NewAudioPage(
                                      file.path!, file.name, fileDuration))));
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
                        child: Text('Select file from device'),
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
