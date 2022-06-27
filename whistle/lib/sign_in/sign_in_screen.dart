import 'package:flutter/material.dart';
import 'package:whistle/HomeScreen.dart';
import 'package:whistle/models/constants.dart';
import 'package:whistle/size_config.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        shadowColor: kPrimaryColor,
        title: Text(
          "Sign In",
          style: TextStyle(
              fontSize: 25.0,
              color: kSecondaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text("Welcome Back",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: getProportionateScreenWidth(28),
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100, top: 25),
                    child: Text(
                      "Sign in with your email and password \nor continue with social media",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SignForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  // final _formKey = GlobalKey<FormState>();
  // final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      /*key: _formKey,*/
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            /*onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            }, */
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 42, vertical: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: kPrimaryColor),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: kPrimaryColor),
                gapPadding: 10,
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.fromLTRB(
                  0,
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20),
                ),
                child: Icon(
                  Icons.mail,
                  size: getProportionateScreenWidth(18),
                ),
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 42, vertical: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: kPrimaryColor),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: kPrimaryColor),
                gapPadding: 10,
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.fromLTRB(
                  0,
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20),
                ),
                child: Icon(
                  Icons.lock,
                  size: getProportionateScreenWidth(18),
                ),
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          /*FormError(errors: errors),*/
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
