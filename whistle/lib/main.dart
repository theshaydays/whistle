import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'SongScreen.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';

void main() {
  _setTargetPlatformForDesktop();
  return runApp(MyApp());
}

void _setTargetPlatformForDesktop() {
  if (Platform.isMacOS) {
  } else if (Platform.isLinux || Platform.isWindows) {}
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    return MaterialApp(
      title: 'Whistle',
      /*theme: ThemeData(
        textTheme: GoogleFonts.saralaTextTheme(Theme.of(context).textTheme),
      ),*/
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {'/song': (ctx) => SongScreen()},
    );
  }
}
