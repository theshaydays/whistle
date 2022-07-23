import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whistle/models/HomeModel.dart';
import 'package:whistle/models/Constant.dart';

// this is for SignInPage.dart
class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function onChanged;

  TextFieldWidget({
    required this.hintText,
    required this.prefixIconData,
    required this.suffixIconData,
    required this.obscureText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);

    return TextField(
      obscureText: obscureText,
      style: TextStyle(color: kPrimaryColor, fontSize: 14.0),
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
          labelText: hintText,
          prefixIcon: Icon(
            prefixIconData,
            size: 18,
            color: kPrimaryColor,
          ),
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              model.isVisible = !model.isVisible;
            },
            child: Icon(
              suffixIconData,
              size: 18,
              color: kPrimaryColor,
            ),
          ),
          labelStyle: TextStyle(color: kPrimaryColor),
          focusColor: kPrimaryColor),
    );
  }
}
