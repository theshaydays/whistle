import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:whistle/PreviousProjects.dart';
import 'package:whistle/RecentProjectsFolders.dart';

import 'package:whistle/models/constants.dart';
import 'package:whistle/models/playlist.dart';
import 'package:whistle/models/song.dart';

import 'FFMPEGConvert.dart';
import 'NewAudioPage.dart';
import 'NewProject.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String buttonName = 'Click';
  bool isClicked = false;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final items = <Widget>[
      Icon(Icons.home, size: 30, color: kPrimaryColor),
      Icon(Icons.search, size: 30, color: kPrimaryColor),
      Icon(Icons.favorite, size: 30, color: kPrimaryColor),
      IconButton(
        onPressed: () async {
          FilePickerResult? result =
              await FilePicker.platform.pickFiles(type: FileType.audio);
          if (result != null) {
            PlatformFile file = result.files.first;
            String fileDuration = await FFmpegConvert(file.path!).getDuration();
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) =>
                    NewAudioPage(file.path!, file.name, fileDuration))));
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
    ];

    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'WHISTLE',
          style: TextStyle(
              fontSize: 25.0,
              color: kSecondaryColor,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: kPrimaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.account_circle,
              color: kSecondaryColor,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Container(
              height: size.height * 0.75,
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNavigationRail(),
                  _buildPlayListAndSongs(size),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: kSecondaryColor, color: kLightColor2, items: items),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      backgroundColor: kSecondaryColor,
      minWidth: 40.0,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      groupAlignment: -0.1,
      labelType: NavigationRailLabelType.all,
      selectedLabelTextStyle:
          TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
      unselectedLabelTextStyle:
          TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
      leading: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              child: SizedBox(height: 5.0),
              padding: const EdgeInsets.all(8.0),
            ),
            RotatedBox(
              quarterTurns: -1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: Text(
                  'Sample Keyboard',
                  style: TextStyle(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PreviousProjects(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      destinations: [
        NavigationRailDestination(
          icon: SizedBox.shrink(),
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RotatedBox(
              quarterTurns: -1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: Text(
                  'Recent Projects',
                  style: TextStyle(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecentProjectsFolders(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        NavigationRailDestination(
          icon: SizedBox.shrink(),
          label: RotatedBox(
            quarterTurns: -1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: Text(
                  'New Project',
                  style: TextStyle(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NewProject(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildPlayListAndSongs(Size size) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          height: 0.35 * size.height,
          width: size.width * 0.75,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: playlists.length,
            itemBuilder: (context, index) => _buildPlayListItem(
                image: playlists[index].image,
                title: playlists[index].playlistName),
          ),
        ),
        Container(
          height: 0.375 * size.height,
          width: size.width * 0.8,
          child: ListView.builder(
            itemCount: playlists.length,
            itemBuilder: (context, index) => _buildSongListItem(
              image: songs[index].image,
              title: songs[index].songName,
              subtitle: songs[index].artist,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSongListItem(
    {required String image, required String title, required String subtitle}) {
  return ListTile(
    title: Text(title),
    subtitle: Text(subtitle),
    leading: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(10.0)),
    ),
  );
}

Widget _buildPlayListItem({required String title, required String image}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    width: 200,
    height: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
      image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
    ),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Expanded(child: Container(height: 0)),
          Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            child: Icon(
              Icons.play_circle_outline_outlined,
              color: kPrimaryColor,
            ),
          )
        ],
      ),
    ),
  );
}
