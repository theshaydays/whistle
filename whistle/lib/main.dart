import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whistle/models/constants.dart';
import 'HomeScreen.dart';
import 'SongScreen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: kPrimaryColor,
  ));
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
      theme: ThemeData(
        textTheme: GoogleFonts.saralaTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {'/song': (ctx) => SongScreen()},
    );
  }
}
