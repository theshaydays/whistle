import 'package:flutter/material.dart';
import 'package:whistle/models/constants.dart';
import 'StaticPlayer.dart';

class SongScreen extends StatefulWidget {
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
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
              'Now Playing',
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
                  margin:
                      EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage('images/beach photo.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        'Sample 1',
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
                    'Whistle',
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
                        '04:30',
                        style: TextStyle(
                            color: kLightColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        '06:30',
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
                        onPressed: () => null,
                        icon: Icon(Icons.playlist_add),
                        color: kLightColor,
                        iconSize: 0.09 * MediaQuery.of(context).size.width,
                      ),
                      Icon(
                        Icons.skip_previous,
                        color: kPrimaryColor,
                        size: 0.12 * MediaQuery.of(context).size.width,
                      ),
                      StaticPlayer('audio/royalty.mp3', 'asset'),
                      Icon(
                        Icons.skip_next,
                        color: kPrimaryColor,
                        size: 0.12 * MediaQuery.of(context).size.width,
                      ),
                      Icon(
                        Icons.swap_horiz,
                        color: kLightColor,
                        size: 0.09 * MediaQuery.of(context).size.width,
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
