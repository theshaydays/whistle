import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whistle/Pages/AuthenticationWrapperPage.dart';
import 'package:whistle/Pages/HomePage.dart';
import 'package:whistle/Widgets/ButtonWidget.dart';
import 'package:whistle/Widgets/TextFieldWidget.dart';
import 'package:whistle/Widgets/WaveWidget.dart';
import 'package:whistle/models/HomeModel.dart';
import 'package:whistle/models/constants.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final model = Provider.of<HomeModel>(context);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height - 200,
            color: kPrimaryColor,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 3.0,
              color: kSecondaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Welcome to Flutter',
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextFieldWidget(
                  hintText: 'Email',
                  obscureText: false,
                  prefixIconData: Icons.mail_outline,
                  suffixIconData: Icons.check,
                  onChanged: (value) {
                    model.isValidEmail(value);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFieldWidget(
                      hintText: 'Password',
                      obscureText: model.isVisible ? false : true,
                      prefixIconData: Icons.lock_outline,
                      suffixIconData: model.isVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onChanged: (value) {
                        model.isValidEmail(value);
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: Text('Login'),
                  onPressed: () {
                    context.read<AuthenticationService>().signIn(
                      email: emailController.text, 
                      password: passwordController.text,
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                ButtonWidget(
                    title: 'Sign Up', hasBorder: true, onPressed: () async {}),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: Text('Click here to login anonymously'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
