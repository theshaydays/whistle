import 'dart:js';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:whistle/models/constants.dart';

import 'FFMPEGConvert.dart';
import 'NewAudioPage.dart';

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
        color: Colors.white,
      ),
      Icon(Icons.settings, size: 30, color: kPrimaryColor),
      Icon(Icons.person, size: 30, color: kPrimaryColor),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Whistle',
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.account_circle,
              color: kPrimaryColor,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*_buildNavigationRail(),*/
                  /*_buildPlayListAndSongs(size),*/
                ],
              ),
            ),
            /*_buildCurrentPlayingSong(size),*/
            /*_buildBottomBar(size),*/
          ],
        ),
      ),
      bottomNavigationBar:
          CurvedNavigationBar(backgroundColor: kSecondaryColor, items: items),
    );
  }
}

  /*Widget _buildNavigationRail() {
    return NavigationRail(
      minWidth: 56.0,
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
            SizedBox(height: 5.0),
            RotatedBox(
              quarterTurns: -1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: Text(
                  'Previous Projects',
                  style: TextStyle(
                      color: Colors.white,
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
          label: RotatedBox(
            quarterTurns: -1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
              ),
              child: Text(
                'Recent Projects',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
              ),
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
        NavigationRailDestination(
          icon: SizedBox.shrink(),
          label: RotatedBox(
            quarterTurns: -1,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: Text(
                  'New Project',
                  style: TextStyle(
                      color: Colors.white,
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


  Widget _buildBottomBar(Size size) {
    return Container(
      height: size.height * 0.15,
      color: kSecondaryColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: kSecondaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            IconButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(type: FileType.audio);
                if (result != null) {
                  PlatformFile file = result.files.first;
                  String fileDuration =
                      await FFmpegConvert(file.path!).getDuration();
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
              color: Colors.white,
            ),
            // Icon(
            //   Icons.playlist_play,
            //   color: kLightColor,
            // ),
            Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPlayingSong(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/song');
      },
      child: Container(
        height: size.height * 0.103,
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0))),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('images/beach photo.jpg'),
            ),
            SizedBox(
              width: 10.0,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sample 1',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Whistle',
                    style: TextStyle(
                      color: kLightColor2,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Icon(
              Icons.favorite_border,
              color: kPrimaryColor,
            ),
            SizedBox(width: 10.0),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(10.0),
                color: Colors.white,
              ),
              child: Icon(
                Icons.pause,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  } 


  Widget _buildNavigationRail() {
    return NavigationRail(
      minWidth: 56.0,
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
            SizedBox(height: 5.0),
            RotatedBox(
              quarterTurns: -1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: Text(
                  'Previous Projects',
                  style: TextStyle(
                      color: Colors.white,
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
          label: RotatedBox(
            quarterTurns: -1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
              ),
              child: Text(
                'Recent Projects',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
              ),
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
        NavigationRailDestination(
          icon: SizedBox.shrink(),
          label: RotatedBox(
            quarterTurns: -1,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: Text(
                  'New Project',
                  style: TextStyle(
                      color: Colors.white,
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

  Widget _buildPlayListAndSongs(Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 0.35 * size.height,
            width: size.width * 0.8,
            //color: Colors.purple,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: playlists.length,
              itemBuilder: (context, index) => _buildPlayListItem(
                  image: playlists[index].image,
                  title: playlists[index].playlistName),
            ),
          ),
          Container(
            height: 0.35 * size.height,
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
      {required String image,
      required String title,
      required String subtitle}) {
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
      width: 220,
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
              padding: const EdgeInsets.all(12.0),
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
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white),
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
} 

      Center(
        child: currentIndex == 0
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white, //background colour
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: Colors.orange,
                      ),
                      onPressed: () {
                        setState(() {
                          buttonName = 'Clicked';
                        });
                      },
                      child: Text(buttonName),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UploadAudioPage(),
                          ),
                        );
                      },
                      child: const Text('Next Page'),
                    ),
                  ],
                ),
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    isClicked = !isClicked; //to invert it everytime you click
                  });
                },
                child: isClicked
                    ? Image.asset('images/whistle.jpg')
                    : Image.asset('images/whistle.jpg'),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: 'Settings', icon: Icon(Icons.settings)),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
} */