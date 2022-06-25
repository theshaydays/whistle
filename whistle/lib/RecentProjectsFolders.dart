import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:whistle/FFMPEGConvert.dart';
import 'package:whistle/HomeScreen.dart';
import 'package:whistle/NewAudioPage.dart';
import 'package:whistle/RecentProjects.dart';
import 'package:whistle/models/constants.dart';

class RecentProjectsFolders extends StatefulWidget {
  @override
  _RecentProjectsFoldersState createState() => _RecentProjectsFoldersState();
}

class _RecentProjectsFoldersState extends State<RecentProjectsFolders> {
  final myDecoratedField = InputDecoration(
    filled: true,
    fillColor: kPrimaryColor,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
    hintText: "Project Title",
    hintStyle: TextStyle(color: kSecondaryColor, fontSize: 15.0),
  );

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
              'RECENT PROJECTS',
              style: TextStyle(
                  fontSize: 20.0,
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
          body: _buildFolders(context),
          backgroundColor: kSecondaryColor,
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: kSecondaryColor,
            color: kLightColor2,
            items: <Widget>[
              Icon(Icons.home, size: 30, color: kPrimaryColor),
              Icon(Icons.search, size: 30, color: kPrimaryColor),
              Icon(Icons.favorite, size: 30, color: kPrimaryColor),
              IconButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(type: FileType.audio);
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
                  }
                },
                icon: Icon(Icons.playlist_play),
                color: kPrimaryColor,
              ),
              Icon(Icons.person, size: 30, color: kPrimaryColor),
            ],
          ),
        ),
      );

  Widget _buildFolders(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                decoration: myDecoratedField.copyWith(
                  hintText: "Project Title",
                  icon: IconButton(
                    icon: Icon(Icons.folder),
                    iconSize: 75,
                    color: kPrimaryColor,
                    alignment: Alignment.center,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecentProjects(test),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextField(
                decoration: myDecoratedField.copyWith(
                  hintText: "Project Title",
                  icon: IconButton(
                    icon: Icon(Icons.folder),
                    iconSize: 75,
                    color: kPrimaryColor,
                    alignment: Alignment.center,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecentProjects(test),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextField(
                decoration: myDecoratedField.copyWith(
                  hintText: "Project Title",
                  icon: IconButton(
                    icon: Icon(Icons.folder),
                    iconSize: 75,
                    color: kPrimaryColor,
                    alignment: Alignment.center,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecentProjects(test),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextField(
                decoration: myDecoratedField.copyWith(
                  hintText: "Project Title",
                  icon: IconButton(
                    icon: Icon(Icons.folder),
                    iconSize: 75,
                    color: kPrimaryColor,
                    alignment: Alignment.center,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecentProjects(test),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextField(
                decoration: myDecoratedField.copyWith(
                  hintText: "Project Title",
                  icon: IconButton(
                    icon: Icon(Icons.folder),
                    iconSize: 75,
                    color: kPrimaryColor,
                    alignment: Alignment.center,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecentProjects(test),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextField(
                decoration: myDecoratedField.copyWith(
                  hintText: "Project Title",
                  icon: IconButton(
                    icon: Icon(Icons.folder),
                    iconSize: 75,
                    color: kPrimaryColor,
                    alignment: Alignment.center,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecentProjects(test),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextField(
                decoration: myDecoratedField.copyWith(
                  hintText: "Project Title",
                  icon: IconButton(
                    icon: Icon(Icons.folder),
                    iconSize: 75,
                    color: kPrimaryColor,
                    alignment: Alignment.center,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecentProjects(test),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextField(
                decoration: myDecoratedField.copyWith(
                  hintText: "Project Title",
                  icon: IconButton(
                    icon: Icon(Icons.folder),
                    iconSize: 75,
                    color: kPrimaryColor,
                    alignment: Alignment.center,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecentProjects(test),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextField(
                decoration: myDecoratedField.copyWith(
                  hintText: "Project Title",
                  icon: IconButton(
                    icon: Icon(Icons.folder),
                    iconSize: 75,
                    color: kPrimaryColor,
                    alignment: Alignment.center,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecentProjects(test),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
