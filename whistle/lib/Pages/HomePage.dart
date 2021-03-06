import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:whistle/Pages/SampleKeyboardPage.dart';
import 'package:whistle/Pages/SavedProjectsPage.dart';
import 'package:whistle/Pages/NewProjectPage.dart';
import 'package:whistle/models/Constant.dart';
import 'package:whistle/models/Playlists.dart';
import 'package:whistle/models/Songs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String buttonName = 'Click';
  bool isClicked = false;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final items = <Widget>[
      Icon(Icons.home, size: 30, color: kPrimaryColor),
      Icon(Icons.search, size: 30, color: kPrimaryColor),
      Icon(Icons.favorite, size: 30, color: favoriteColor),
      Icon(Icons.playlist_play, size: 30, color: kPrimaryColor),
      Icon(Icons.person, size: 30, color: kPrimaryColor),
    ];

    return Scaffold(
      key: ValueKey('HomePage'),
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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNavigationRail(),
          _buildPlayListAndSongs(size),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: kSecondaryColor, color: kLightColor2, items: items),
    );
  }

  Widget _buildNavigationRail() {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: NavigationRail(
              groupAlignment: -0.25,
              backgroundColor: kSecondaryColor,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              selectedLabelTextStyle:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
              unselectedLabelTextStyle:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
              destinations: [
                NavigationRailDestination(
                  icon: FittedBox(),
                  label: RotatedBox(
                    quarterTurns: -1,
                    child: ElevatedButton(
                      key: ValueKey('SampleKeyboard'),
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                      ),
                      child: Text(
                        'Sample Keyboard',
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SampleKeyboardPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: SizedBox.shrink(),
                  label: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: ElevatedButton(
                        key: ValueKey('RecentProjectsButton'),
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                        child: Text(
                          'Saved Projects',
                          style: TextStyle(
                              color: kSecondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SavedProjectsPage(),
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
                        key: Key('ToNewProject'),
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                        child: Text(
                          'New Project',
                          style: TextStyle(
                              color: kSecondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NewProjectPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
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
          width: size.width * 0.75,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
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
