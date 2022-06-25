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
  ['rest', 0.5],
  ['G4', 0.5],
  ['C#5', 0.5],
  ['rest', 0.5],
  ['F#5', 0.25],
  ['E4', 0.5],
  ['rest', 0.5],
  ['B4', 0.5],
  ['A#5', 0.5],
  ['rest', 0.5],
  ['G#5', 0.25],
  ['E4', 0.5],
  ['rest', 0.5],
  ['F4', 0.5],
  ['D#5', 0.5],
  ['rest', 0.5],
  ['C#5', 0.25],
  ['E4', 0.5],
  ['rest', 0.5],
  ['G4', 0.5],
  ['C#5', 0.5],
  ['rest', 0.5],
  ['F#5', 0.25],
  ['E4', 0.5],
  ['rest', 0.5],
  ['B4', 0.5],
  ['A#5', 0.5],
  ['rest', 0.5],
  ['G#5', 0.25],
  ['E4', 0.5],
  ['rest', 0.5],
  ['F4', 0.5],
  ['D#5', 0.5],
];

//login page form errors

final RegExp emailValidatorRegExp =
    RegExp(r"[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter your valid email";
const String kPassNullError = "Password is too short";
const String kMatchPassError = "Passwords dont match";
