import 'package:flutter/material.dart';
import 'package:whistle/Pages/AuthenticatePage.dart';
import 'package:whistle/models/HomeModel.dart';
import 'package:provider/provider.dart';

// This is to test CI

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

void main() => runApp(MyApp());

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
