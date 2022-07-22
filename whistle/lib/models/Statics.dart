import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF4A82AA);
const kSecondaryColor = Color(0xFFFFFAF7);
const kLightColor = Colors.grey;
const kLightColor2 = Color(0xffedf6fa);
const kWhiteColor = Colors.white;
const favoriteColor = Color(0XFFD293c6);

// dummy note images
List<List<dynamic>> test = [
  ['rest', 0.5],
  ['C#5', 0.25],
  ['E4', 0.5],
  ['rest', 0.25],
  ['G4', 2],
  ['D#5', 1.5],
  ['rest', 2],
  ['F#5', 2],
  ['E4', 1],
  ['rest', 1],
  ['B4', 2],
  ['A#5', 0.75],
  ['rest', 0.25],
  ['G#5', 2],
  ['E4', 1],
  ['rest', 1.5],
  ['F4', 4],
  ['B5', 0.25],
  ['rest', 0.75],
  //repeat
  ['rest', 0.5],
  ['C#5', 0.25],
  ['E4', 0.5],
  ['rest', 0.25],
  ['G4', 2],
  ['D#5', 1.5],
  ['rest', 2],
  ['F#5', 2],
  ['E4', 1],
  ['rest', 1],
  ['B4', 2],
  ['A#5', 0.75],
  ['rest', 0.25],
  ['G#5', 2],
  ['E4', 1],
  ['rest', 1.5],
  ['F4', 4],
  ['B5', 0.25],
  ['rest', 0.75],
  ['rest', 0.5],
  ['C#5', 0.25],
  ['E4', 0.5],
  ['rest', 0.25],
  ['G4', 2],
  ['D#5', 1.5],
  ['rest', 2],
  ['F#5', 2],
  ['E4', 1],
  ['rest', 1],
  ['B4', 2],
  ['A#5', 0.75],
  ['rest', 0.25],
  ['G#5', 2],
  ['E4', 1],
  ['rest', 1.5],
  ['F4', 4],
  ['B5', 0.25],
  ['rest', 0.75],
  ['rest', 0.5],
  ['C#5', 0.25],
  ['E4', 0.5],
  ['rest', 0.25],
  ['G4', 2],
  ['D#5', 1.5],
  ['rest', 2],
  ['F#5', 2],
  ['E4', 1],
  ['rest', 1],
  ['B4', 2],
  ['A#5', 0.75],
  ['rest', 0.25],
  ['G#5', 2],
  ['E4', 1],
  ['rest', 1.5],
  ['F4', 4],
  ['B5', 0.25],
  ['rest', 0.75],
];

//login page form errors

final RegExp emailValidatorRegExp =
    RegExp(r"[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter your valid email";
const String kPassNullError = "Password is too short";
const String kMatchPassError = "Passwords dont match";
