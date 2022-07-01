import 'package:flutter/material.dart';
import 'package:whistle/Pages/SignInPage.dart';
import 'dart:io' show Platform;

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
    // add the following lines if you want to force the app to always stay vertical
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    return MaterialApp(
      title: 'Whistle',
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
