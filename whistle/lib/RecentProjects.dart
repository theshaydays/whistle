import 'package:flutter/material.dart';
import 'package:whistle/models/constants.dart';

class RecentProjects extends StatefulWidget {
  @override
  _RecentProjectsState createState() => _RecentProjectsState();
}

class _RecentProjectsState extends State<RecentProjects> {
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
              'Score Sheet',
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
        ),
      );
}
