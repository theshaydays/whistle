import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatefulWidget {
  final List<String> imagePaths;
  final List<int> randomList;

  const LoadingPage(this.imagePaths, this.randomList);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  color: Colors.white,
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
                  fontFamily: 'fantasy',
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: CircleAvatar(
              backgroundImage: Image.asset('images/Logo_black.png').image,
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
