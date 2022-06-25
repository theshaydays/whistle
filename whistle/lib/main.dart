import 'package:flutter/material.dart';
import 'package:whistle/sign_in/sign_in_screen.dart';
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
    return MaterialApp(
      title: 'Whistle',
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
