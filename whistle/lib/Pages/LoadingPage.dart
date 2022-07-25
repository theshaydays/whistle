import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:whistle/models/Constant.dart';

class LoadingPage extends StatefulWidget {
  final List<String> imagePaths;
  final List<int> randomList;
  final String audioDuration;

  const LoadingPage(this.imagePaths, this.randomList, this.audioDuration);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late int timeNeeded = (double.parse(widget.audioDuration) * 2).round();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SpinKitFadingCircle(
            size: 400,
            duration: Duration(milliseconds: 2000),
            itemBuilder: (context, index) {
              List<Image> imageList = [];
              for (String element in widget.imagePaths) {
                imageList.add(Image.asset(
                  element,
                  height: 10,
                  width: 10,
                ));
              }
              final selectedImage = imageList[widget.randomList[index] - 1];
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  image: DecorationImage(
                    image: selectedImage.image,
                    scale: 1,
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 125,
            child: Text(
              'Loading',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            child: Text(
              'Analysis may take up to $timeNeeded seconds',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: CircleAvatar(
              backgroundImage:
                  Image.asset('images/loading_screen_logo.png').image,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              radius: 120,
            ),
          ),
        ],
      ),
    );
  }
}
