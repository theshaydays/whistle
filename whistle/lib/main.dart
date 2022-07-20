import 'package:flutter/material.dart';
import 'package:whistle/Pages/AuthenticatePage.dart';
import 'package:whistle/models/HomeModel.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

/*void main() {
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
}*/

Future<void> main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthenticateScreen(),
      ),
    );
  }
}
